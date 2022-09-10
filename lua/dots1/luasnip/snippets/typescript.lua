local is_luasnip_ok, ls = pcall(require, "luasnip")
if not is_luasnip_ok then
  return
end

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local t = ls.text_node
local c = ls.choice_node
local sn = ls.snippet_node
local create_sn = function(fmt_node)
  return sn(nil, fmt_node)
end

local create_fmt_with_one_insert = function(text)
  return create_sn(fmt(text, {i(1)}, {}))
end

local before_all_text = [[
  beforeAll(async () => {{
      {}
    }})

]]

local after_all_text = [[
  afterAll(async () => {{
      {}
    }})

]]

local before_each_text = [[
  beforeEach(async () => {{
      {}
    }})

]]

local after_each_text = [[
  afterEach(async () => {{
      {}
    }})

]]

local M = {}

M.jest = {
  s(
    "jest",
    fmt(
      [[
  describe('{}', () => {{
    {}
    {}
    {}
    {}
    {}
  }})
  ]],
      {
        i(1),
        c(
          2,
          {
            create_fmt_with_one_insert(before_all_text),
            i(1, "")
          }
        ),
        c(
          3,
          {
            create_fmt_with_one_insert(before_each_text),
            i(1, "")
          }
        ),
        c(
          4,
          {
            create_fmt_with_one_insert(after_each_text),
            i(1, "")
          }
        ),
        c(
          5,
          {
            create_fmt_with_one_insert(after_all_text),
            i(1, "")
          }
        ),
        i(0)
      },
      {}
    )
  )
}

return M
