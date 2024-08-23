if vim.lsp.inlay_hint then
  vim.keymap.set(
    "n",
    "<leader>it",
    function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end,
    {desc = "Toggle Inlay Hints"}
  )
end
