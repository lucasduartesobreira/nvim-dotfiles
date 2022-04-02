--add snippet support
local capabilities = require("lsp-server-configs/add-snippet").capabilities

--lsp_signature config
local on_attach = require "plug-config/lspsignature-config".on_attach

require "lspconfig".tsserver.setup {
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end,
  init_options = {
    hostInfo = "neovim",
    disableAutomaticTypingAcquisition = false,
    preferences = {
      allowIncompleteCompletions = true,
      includeCompletionsForModuleExports = false
    }
  },
  flags = {
    debounce_text_changes = 500,
    allow_incremental_sync = true
  }
}
