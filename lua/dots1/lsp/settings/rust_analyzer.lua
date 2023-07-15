return {
  cmd_env = {
    RA_LOG = "rust_analyzer=error"
  },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      check = {command = "clippy"},
      procMacro = {
        attributes = {
          enable = true
        },
        enable = true
      },
      rustc = {source = "discover"},
      workspace = {symbol = {search = {scope = "workspace_and_dependencies"}}}
    }
  }
}
