--luasnip
require "luasnip".config.set_config(
  {
    history = false,
    updateevents = nil
  }
)

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
