--add snippet support
local capabilities = require("lsp-server-configs/add-snippet").capabilities

--lsp_signature config
--local lsp_signature_on_attach = require "plug-config/lspsignature-config".on_attach
local lsp_format_attach = require("lsp-format").on_attach
function on_attach(client, bufnr)
  lsp_format_attach(client)
  --lsp_signature_on_attach(client, bufnr)
end

require "lspconfig".rust_analyzer.setup {
  capabilities = capabilities,
  cmd_env = {
    RA_LOG = "rust_analyzer=error"
  },
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {command = "clippy"}
    }
  }
}
--[[
   [
   [require'lspconfig'.rls.setup{
   [  capabilities = capabilities,
   [  on_attach =  on_attach,
   [  settings = {
   [    rust = {
   [      unstable_features = true,
   [      build_on_save = false,
   [      all_features = true,
   [    },
   [  },
   [}
   ]]
