--local local_binary = vim.fn.fnamemodify("./node_modules/.bin/tsgo", ":p")
--local local_path = vim.uv.fs_stat(local_binary) and local_binary or "tsgo"
local local_path = "tsgo"

return {
  cmd = {local_path, "--lsp", "--stdio"},
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
