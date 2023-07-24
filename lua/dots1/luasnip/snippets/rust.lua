local is_luasnip_ok, ls = pcall(require, "luasnip")
if not is_luasnip_ok then
  return
end

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local sn = ls.snippet_node
local f = ls.function_node

local M = {}

M.tokio_test = {
  s(
    "tt",
    fmt(
      [[
      #[tokio::test]
      async fn test_{testName}() {{
          {}
      }}
      ]],
      {
        testName = i(1, "example"),
        i(0)
      }
    )
  )
}

return M
