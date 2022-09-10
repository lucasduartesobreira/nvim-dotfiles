local is_luasnip_ok, _ = pcall(require, "luasnip")
if not is_luasnip_ok then
  return
end

local ls = require("luasnip")

--luasnip
ls.config.set_config(
  {
    history = false,
    updateevents = "InsertLeave,TextChanged,TextChangedI",
    region_check_events = "InsertEnter,CursorHold,CursorHoldI,CursorMoved",
    delete_check_events = "TextChanged,InsertLeave,InsertEnter"
  }
)

local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets(
  "all",
  {
    s("todo", fmt("TODO: {}", {i(1)}, {}))
  }
)

local get_final = function(args)
  local parts = vim.split(args[1][1], ".", true)
  return parts[#parts] or ""
end

ls.add_snippets(
  "lua",
  {
    s(
      "req",
      {
        c(
          1,
          {
            sn(
              nil,
              fmt(
                [[
                  local is_{}_ok, {} = pcall(require, "{}")
                  if not is_{}_ok then
                    return
                  end
                ]],
                {
                  f(get_final, {1}),
                  f(get_final, {1}),
                  i(1),
                  f(get_final, {1})
                },
                {}
              )
            ),
            sn(
              nil,
              fmt(
                "local {} = require('{}')",
                {
                  f(get_final, {1}),
                  i(1)
                },
                {}
              )
            )
          }
        )
      }
    )
  },
  {key = "lua"}
)

local typescript = require("dots1.luasnip.snippets.typescript")

for key_name, value in pairs(typescript) do
  ls.add_snippets("typescript", value, {key = key_name})
end

require("luasnip/loaders/from_vscode").lazy_load()
vim.api.nvim_set_keymap("i", "<A-l>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<A-l>", "<Plug>luasnip-next-choice", {})
