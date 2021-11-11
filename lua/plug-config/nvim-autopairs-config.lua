local npairs = require("nvim-autopairs")
npairs.setup(
  {
    check_ts = true,
    ts_config = {
      rust = {"line_comment", "block_comment"},
      go = {"comment"}
    },
    enable_check_bracket_line = false
  }
)

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({map_char = {tex = ""}}))

local Rule = require("nvim-autopairs.rule")

local cond = require("nvim-autopairs.conds")

npairs.add_rules {
  -- Disable '' for when it foresee <
  Rule("'", "'", {"rust"}):with_pair(cond.not_before_text_check("<")),
  Rule("=>", " {  }", {"typescript", "typescriptreact", "javascript", "rust"}):set_end_pair_length(2),
  --Space between () or [] or {}
  Rule(" ", " "):with_pair(
    function(opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({"()", "[]", "{}"}, pair)
    end
  ),
  -- Jump to ) if inside a ( )
  Rule("( ", " )"):with_pair(
    function()
      return false
    end
  ):with_move(
    function(opts)
      return opts.prev_char:match(".%)") ~= nil
    end
  ):use_key(")"),
  -- Jump to } if inside a { }
  Rule("{ ", " }"):with_pair(
    function()
      return false
    end
  ):with_move(
    function(opts)
      return opts.prev_char:match(".%}") ~= nil
    end
  ):use_key("}"),
  -- Jump to ] if inside a ]
  Rule("[ ", " ]"):with_pair(
    function()
      return false
    end
  ):with_move(
    function(opts)
      return opts.prev_char:match(".%]") ~= nil
    end
  ):use_key("]"),
  -- space before = when find variable=
  Rule("=", "", {"rust", "javascript", "typescript", "python"}):with_pair(cond.not_inside_quote()):with_pair(
    function(opts)
      local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
      if last_char:match("[%w%=%s]") then
        return true
      end
      return false
    end
  ):replace_endpair(
    function(opts)
      local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
      local next_char = opts.line:sub(opts.col, opts.col)
      next_char = next_char == " " and "" or " "
      if prev_2char:match("%w$") then
        return "<bs> =" .. next_char
      end
      if prev_2char:match("%=$") then
        return next_char
      end
      if prev_2char:match("=") then
        return "<bs><bs>=" .. next_char
      end
      return ""
    end
  ):set_end_pair_length(0):with_move(cond.none()):with_del(cond.none())
}
