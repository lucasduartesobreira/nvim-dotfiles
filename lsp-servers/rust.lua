--add snippet support
local capabilities = require("lsp-server-configs/add-snippet").capabilities

--lsp_signature config
local on_attach = require "plug-config/lspsignature-config".on_attach

require "lspconfig".rust_analyzer.setup {
  --capabilities = capabilities,
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
