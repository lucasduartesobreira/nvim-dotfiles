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
    table.insert(result, a)
    if idx == 1 and a == "test" then
      -- Don't run tests, just build
      table.insert(result, "--no-run")
    end
  end

  table.insert(result, "--message-format=json")

  return result
end

local createFinalConfigWithCargo = function(config)
  local utils = require("telescope.utils")
  local cargoArgs = get_cargo_args(config.cargo)
  local command = vim.deepcopy(cargoArgs)
  table.insert(command, 1, "cargo")
  local result, code = utils.get_os_command_output(command, config.cwd)

  if code and code > 0 then
    vim.notify "An error occured while compiling. Please fix all compilation issues and try again."
    return {}
  end

  for _, value in pairs(result) do
    local json = vim.fn.json_decode(value)
    if type(json) == "table" and json.executable ~= vim.NIL and json.executable ~= nil then
      if config.cargo.filter ~= nil and config.cargo.filter ~= vim.NIL then
        local passFilter = true
        for filterKey, filterValue in pairs(config.cargo.filter) do
          if filterValue ~= json.target[filterKey] then
            passFilter = false
            break
          end
        end

        if passFilter then
          return {
            name = config.name,
            type = config.type,
            request = "launch",
            program = json.executable,
            args = config.cargo.executableArgs or {},
            cwd = config.cwd,
            stopOnEntry = config.stopOnEntry or true,
            runInTerminal = config.runInTerminal or false
          }
        end
      else
        return {
          name = config.name,
          type = config.type,
          request = "launch",
          program = json.executable,
          args = config.cargo.executableArgs or {},
          cwd = config.cwd,
          stopOnEntry = config.stopOnEntry or true,
          runInTerminal = config.runInTerminal or false
        }
      end
    end
  end
  vim.notify "No executable passed the filters"
  return {}
end

local enrich_function = function(config, on_config)
  local final_config
  if config.cargo ~= nil and config.cargo ~= vim.NIL then
    final_config = createFinalConfigWithCargo(config)
  end

  if final_config == nil or final_config == vim.NIL then
    final_config = vim.deepcopy(config)
  end

  on_config(final_config)
end

M.adapter = function(callback)
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)

  -- CHANGE THIS!
  local cmd = "/home/dots/projects/debuggers/codelldb/extension/adapter/codelldb"
  local liblldb = "/home/dots/projects/debuggers/codelldb/extension/lldb/lib/liblldb.so"

  local handle, pid_or_err
  local opts = {
    stdio = {nil, stdout, stderr},
    args = {
      "--liblldb",
      liblldb,
      "--params",
      '{"showDisassembly" : "never"}'
    },
    detached = true
  }
  handle, pid_or_err =
    vim.loop.spawn(
    cmd,
    opts,
    function(code)
      stdout:close()
      stderr:close()
      handle:close()
      if code ~= 0 then
        print("codelldb exited with code", code)
      end
    end
  )
  assert(handle, "Error running codelldb: " .. tostring(pid_or_err))
  stdout:read_start(
    function(err, chunk)
      assert(not err, err)
      if chunk then
        local port = chunk:match("Listening on port (%d+)")
        if port then
          vim.schedule(
            function()
              callback(
                {
                  type = "server",
                  host = "127.0.0.1",
                  port = port,
                  enrich_config = enrich_function
                }
              )
            end
          )
        else
          vim.schedule(
            function()
              require("dap.repl").append(chunk)
            end
          )
        end
      end
    end
  )
  stderr:read_start(
    function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(
          function()
            require("dap.repl").append(chunk)
          end
        )
      end
    end
  )
end

return M
