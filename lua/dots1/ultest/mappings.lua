return function()
  local opts = { silent = true }
  local keymap = vim.keymap.set

  keymap("n", "]t", "<Plug>(ultest-next-fail)")
  keymap("n", "[t", "<Plug>(ultest-prev-fail)")
  keymap("n", "<leader>ts", "<Plug>(ultest-summary-toggle)", opts)
  keymap("n", "<leader>trf", "<Plug>(ultest-run-file)", opts)
  keymap("n", "<leader>trn", "<Plug>(ultest-run-nearest)", opts)
  keymap("n", "<leader>to", "<Plug>(ultest-output-show)", opts)
  keymap("n", "<leader>tdf", "<Plug>(ultest-debug-file)", opts)
  keymap("n", "<leader>tdn", "<Plug>(ultest-debug-nearest)", opts)
end
