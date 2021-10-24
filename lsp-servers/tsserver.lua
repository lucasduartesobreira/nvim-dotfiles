--add snippet support
local capabilities = require("lsp-server-configs/add-snippet").capabilities

--lsp_signature config
local on_attach = require "plug-config/lspsignature-config".on_attach

require "lspconfig".tsserver.setup {
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
  on_attach = on_attach
}
