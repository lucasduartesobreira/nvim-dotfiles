return {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
  end,
  init_options = {
    hostInfo = "neovim",
    disableAutomaticTypingAcquisition = true,
    preferences = {
      allowIncompleteCompletions = true,
      includeCompletionsForModuleExports = true
    },
    maxTsServerMemory = 4096
  },
  flags = {
    debounce_text_changes = 500,
    allow_incremental_sync = true
  }
}
