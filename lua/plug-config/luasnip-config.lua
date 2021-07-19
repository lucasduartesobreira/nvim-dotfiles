local ls = require("luasnip")
--luasnip
ls.config.set_config(
  {
    history = false,
    updateevents = nil
  }
)

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.snippets = {
  all = {
    s(
      "todo",
      {
        t("TODO: "),
        i(1)
      }
    )
  }
}

require("luasnip/loaders/from_vscode").lazy_load()

vim.api.nvim_set_keymap(
  "i",
  "<C-E>",
  "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'",
  {expr = true, silent = true}
)
vim.api.nvim_set_keymap(
  "s",
  "<C-E>",
  "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'",
  {expr = true, silent = true}
)
