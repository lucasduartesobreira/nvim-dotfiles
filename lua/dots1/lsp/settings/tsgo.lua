return {
  cmd = {"/home/lucas/.asdf/shims/tsgo", "--lsp", "--stdio"},
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx"
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
  end,
  root_markers = {"tsconfig.json", "jsconfig.json", "package.json", ".git"}
}
