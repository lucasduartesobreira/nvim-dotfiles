--add snippet support
local capabilities = require("lsp-server-configs/add-snippet").capabilities

--lsp_signature config
local lsp_signature_attach = require("plug-config/lspsignature-config").on_attach
local lsp_format_attach = require("lsp-format").on_attach

function on_attach(client, bufnr)
  lsp_signature_attach(client, bufnr)
  lsp_format_attach(client)
end

require "lspconfig".gopls.setup {
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
  on_attach = on_attach
}
