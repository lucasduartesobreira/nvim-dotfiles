local lsp_format_attach = require("lsp-format").on_attach

function on_attach(client, bufnr)
  --lsp_format_attach(client)
end

local home = vim.fn.expand("$HOME")
local config_root = home .. "/.config/nvim/lsp-config"
local config = config_root .. "/config.yaml"

require "lspconfig".efm.setup {
  --on_attach = on_attach,
  filetypes = {"javascript", "typescript", "go", "lua"},
  cmd = {"efm-langserver", "-c", config},
  init_options = {documentFormatting = true, publishDiagnostics = true}
}
