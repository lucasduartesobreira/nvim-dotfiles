--add snippet support
local capabilities = require("lsp-server-configs/add-snippet").on_attach

--lsp_signature config
local on_attach = require "plug-config/lspsignature-config".on_attach

require "lspconfig".denols.setup {
  capabilities = capabilities,
  on_attach = on_attach
}
