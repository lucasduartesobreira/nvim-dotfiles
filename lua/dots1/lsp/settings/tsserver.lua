return {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
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
