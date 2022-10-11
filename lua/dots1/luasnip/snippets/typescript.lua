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
  variable_with_validation("fou", sn_build(fmt([[{}.findOneAndUpdate({{ {} }}, {{ {} }})]], {i(1), i(2), i(3)}, {})), i),
  s(
    "model",
    fmt(
      [[
interface I{} {{

}}

const {}Schema = new Schema({{ }}, {{ timestamps: true}})

const {}: Model<I{}> = models[] ?? model({}, {}Schema, {})
  ]],
      {
        i(1),
        rep(1),
        rep(1),
        rep(1),
        i(2),
        rep(1),
        rep(2)
      },
      {}
    )
  )
}

local recursive_keys_values
recursive_keys_values = function()
  return sn(
    nil,
    c(
      1,
      {
        t(""),
        sn(nil, fmt([[
{}: {},
  {}
          ]], {i(1), i(2), d(3, recursive_keys_values, {})}, {}))
      }
    )
  )
end

local async_or_not = function()
  return sn(
    nil,
    {
      c(
        1,
        {
          t(""),
          t("async")
        }
      )
    }
  )
end

local upperCase = function(args)
  local first = args[1][1]

  if first == nil then
    first = ""
  end

  local snake_case = string.gsub(first, "([A-Z])", "_%1")

  local sla = string.sub(snake_case, 2)

  return string.upper(sla)
end

local getParameters = function(args)
  local first_line = args[1][1]

  if first_line == nil then
    first_line = ""
  end

  local withoutType = string.gsub(first_line, ":[%s%w%.]+", "")
  local withJumpLine = string.gsub(withoutType, ",", ",\n")
  --print(withJumpLine)

  return withoutType
end

M.general = {
  variable_with_validation("vwv", i, i),
  s(
    "obj",
    fmt(
      [[
const {} = {{
  {} 
}}]],
      {
        i(2, "varName"),
        d(1, recursive_keys_values, {})
      },
      {}
    )
  ),
  s("iobj", d(1, recursive_keys_values, {})),
  s("farr", fmt([[{}({}) => {{{}}}]], {d(1, async_or_not, {}), i(2), i(3)}, {})),
  s(
    "fn",
    c(
      1,
      {
        create_sn_fmt([[const {} = {} ({}) => {{{}}}]], {i(1), d(2, async_or_not, {}), i(3), i(0)}),
        create_sn_fmt([[const {} = {} <{}>({}):{} => {{{}}}]], {i(1), d(2, async_or_not, {}), i(4), i(3), i(5), i(0)})
      }
    )
  ),
  s(
    "buildError",
    fmt(
      [[
/**
 * @openapi
 * definitions:
 *  {}:
 *    type: object
 *    description: {}
 *    properties:
 *      type:
 *        type: string
 *        example: {}
 *      message:
 *        type: string
 *        example: '{}'
 *      statusCode:
 *        type: number
 *        example: {}
 */
const build{}Error = ({}) => error.build({{
  message: i18n.get({}.{}, {{ {} }}),
  statusCode: {},
  type: ErrorTypesEnum.{}
}})
  ]],
      {
        i(1),
        i(2),
        f(upperCase, {1}),
        i(3),
        i(4),
        rep(1),
        i(5),
        i(6),
        f(upperCase, {1}),
        f(getParameters, {5}),
        rep(4),
        f(upperCase, {1})
      },
      {}
    )
  )
}

return M
