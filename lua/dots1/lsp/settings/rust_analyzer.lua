return {
  cmd_env = {
    RA_LOG = "rust_analyzer=error"
  },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {command = "clippy"},
      procMacro = {
        attributes = {
          enable = true
        },
        enable = true
      }
    }
  }
}
