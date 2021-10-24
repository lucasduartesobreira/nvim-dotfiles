--add snippet support
local capabilities = require("lsp-server-configs/add-snippet").capabilities

--lsp_signature config
local on_attach = require "plug-config/lspsignature-config".on_attach

local lspconfig = require("lspconfig")

lspconfig.ocamllsp.setup {
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern("*.opam", "esy.json", "package.json", "dune")
}
