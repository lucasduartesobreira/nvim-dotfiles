local npairs = require("nvim-autopairs")
npairs.setup(
  {
    check_ts = true
  }
)

require("nvim-autopairs.completion.compe").setup(
  {
    map_cr = true,
    map_complete = true
  }
)

local Rule = require("nvim-autopairs.rule")

local ts_conds = require("nvim-autopairs.ts-conds")

npairs.add_rules(
  {
    Rule("<", ">", "rust"):with_pair(ts_conds.is_not_ts_node({"if_statement"})),
    Rule("{", "}"):end_wise(
      function()
        return true
      end
    )
  }
)
