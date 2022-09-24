local is_luasnip_ok, ls = pcall(require, "luasnip")
if not is_luasnip_ok then
  return
end

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local t = ls.text_node
local c = ls.choice_node
local sn = ls.snippet_node
local create_sn = function(fmt_node)
  return sn(nil, fmt_node)
end

local create_fmt_with_one_insert = function(text)
  return create_sn(fmt(text, {i(1)}, {}))
end

local create_sn_fmt = function(text, nodes)
  return create_sn(fmt(text, nodes, {}))
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

M.import = {
  s(
    "import",
    {
      c(
        1,
        {
          create_sn_fmt([[ import {} from '{}']], {i(2, "placeholder"), i(1)}),
          create_sn_fmt([[ import {{ {} }} from '{}']], {i(2), i(1)}),
          create_sn_fmt([[ import * as {} from '{}']], {i(2), i(1)})
        }
      )
    }
  )
}

local sn_build = function(nodes)
  return function(number)
    return sn(number, nodes)
  end
end

local variable_with_validation = function(trigger, right_node, exception_node)
  return s(
    trigger,
    fmt(
      [[
  const {} = {}

  if ({}{}) {{
    {}
  }}
  ]],
      {i(2, "varName"), right_node(1), rep(2), i(3), exception_node(4)},
      {}
    )
  )
end

M.mongoose = {
  variable_with_validation("fo", sn_build(fmt([[{}.findOne({{ {} }})]], {i(1, "model"), i(2)}, {})), i),
  s("fa", fmt([[const {} = {}.find({{ {} }})]], {i(3, "varName"), i(1, "model"), i(2)}, {})),
  variable_with_validation("fou", sn_build(fmt([[{}.findOneAndUpdate({{ {} }}, {{ {} }})]], {i(1), i(2), i(3)}, {})), i)
}

M.general = {
  variable_with_validation("vwv", i, i)
}

return M
