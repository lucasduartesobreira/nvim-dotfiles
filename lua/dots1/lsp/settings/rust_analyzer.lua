return {
  cmd_env = {
    RA_LOG = "rust_analyzer=error"
  },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {command = "clippy"},
      procMacro = {
        enable = true
      }
    }
  }
}
