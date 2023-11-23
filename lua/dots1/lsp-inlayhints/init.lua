if vim.lsp.inlay_hint then
  vim.keymap.set(
    "n",
    "<leader>it",
    function()
      vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
    end,
    {desc = "Toggle Inlay Hints"}
  )
end
