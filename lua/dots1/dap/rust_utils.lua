local M = {}
--[[
--args = {
--    args = { "cargo arguments" },
--    executableArgs = { "arguments passed to the binary" },
--    filter = { "possibles filters, anything at target" }
--}
--]]
local get_cargo_args = function(args)
  local result = {}

  assert(args.args, vim.inspect(args))
  for idx, a in ipairs(args.args) do
    if type(a) == "function" then
      table.insert(result, a())
    else
      table.insert(result, a)
    end
    if idx == 1 and a == "test" then
      -- Don't run tests, just build
      table.insert(result, "--no-run")
    end
  end

  table.insert(result, "--message-format=json")

  return result
end

local utils = require("dots1.utils")
local executeCargoCommand = function(config)
  local cargoArgs = get_cargo_args(config.cargo)
  local command = vim.deepcopy(cargoArgs)
  table.insert(command, 1, "cargo")
  local result, code = utils.get_os_command_output(command, config.cwd)

  if code and code > 0 then
    vim.notify "An error occured while compiling. Please fix all compilation issues and try again."
    return {}
  end

  return result
end

-- Code from https://web.archive.org/web/20131225070434/http://snippets.luacode.org/snippets/Deep_Comparison_of_Two_Values_3
local function deepcompare(t1, t2, ignore_mt)
  local ty1 = type(t1)
  local ty2 = type(t2)
  if ty1 ~= ty2 then
    return false
  end
  -- non-table types can be directly compared
  if ty1 ~= "table" and ty2 ~= "table" then
    return t1 == t2
  end
  -- as well as tables which have the metamethod __eq
  local mt = getmetatable(t1)
  if not ignore_mt and mt and mt.__eq then
    return t1 == t2
  end
  for k1, v1 in pairs(t1) do
    local v2 = t2[k1]
    if v2 == nil or not deepcompare(v1, v2) then
      return false
    end
  end
  for k2, v2 in pairs(t2) do
    local v1 = t1[k2]
    if v1 == nil or not deepcompare(v1, v2) then
      return false
    end
  end
  return true
end

local passFilter = function(jsonCargoResponse, config)
  for filterKey, filterValue in pairs(config.cargo.filter) do
    if type(jsonCargoResponse.target[filterKey]) == "table" and type(filterValue) == "table" then
      if not deepcompare(filterValue, jsonCargoResponse.target[filterKey], false) then
        return false
      end
    elseif filterValue ~= jsonCargoResponse.target[filterKey] then
      return false
    end
  end
  return true
end

local notNil = function(item)
  return item ~= nil and item ~= vim.NIL
end

local isNil = function(item)
  return not notNil(item)
end

local createFinalConfigWithCargo = function(config)
  local cargoResponse = executeCargoCommand(config)
  for _, value in pairs(cargoResponse) do
    local jsonCargoResponse = vim.fn.json_decode(value)
    if type(jsonCargoResponse) == "table" and notNil(jsonCargoResponse.executable) then
      local possible_final_config = {
        name = config.name,
        type = config.type,
        request = "launch",
        program = jsonCargoResponse.executable,
        args = --[[
   [          type(config.cargo.executableArgs) == "function" and {config.cargo.executableArgs()} or
   [
   ]]
        {config.cargo.executableArgs} or {},
        cwd = config.cwd,
        stopOnEntry = config.stopOnEntry or true,
        runInTerminal = config.runInTerminal or false
      }
      if isNil(config.cargo.filter) then
        return possible_final_config
      end

      if passFilter(jsonCargoResponse, config) then
        return possible_final_config
      end
    end
  end
  vim.notify "No executable found"
  return {}
end

function enrich_function(config, on_config)
  local final_config
  if notNil(config.cargo) then
    final_config = createFinalConfigWithCargo(config)
  end

  if isNil(final_config) then
    final_config = vim.deepcopy(config)
  end

  print(vim.inspect(final_config))
  on_config(final_config)
end

M.adapter = function(callback)
  local cmd = "/home/lucas/projects/debuggers/codelldb/extension/adapter/codelldb"
  local liblldb = "/home/lucas/projects/debuggers/codelldb/extension/lldb/lib/liblldb.so"
  callback(
    {
      type = "server",
      host = "127.0.0.1",
      port = "${port}",
      executable = {
        command = cmd,
        args = {
          "--liblldb",
          liblldb,
          "--port",
          "${port}",
          "--settings",
          '{"showDisassembly" : "never"}'
        }
      },
      enrich_config = enrich_function
    }
  )
end

return M
