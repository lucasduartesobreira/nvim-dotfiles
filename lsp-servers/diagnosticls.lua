require "lspconfig".diagnosticls.setup {
  filetypes = {"javascript", "typescript", "go"},
  cmd = {"diagnostic-languageserver", "--stdio", "--log-level", "2"},
  init_options = {
    linters = {
      eslint = {
        command = "eslint",
        rootPatterns = {".git"},
        debounce = 100,
        args = {
          "--stdin",
          "--stdin-filename",
          "%filepath",
          "--format",
          "json"
        },
        sourceName = "eslint",
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity"
        },
        securities = {
          [2] = "error",
          [1] = "warning"
        }
      },
      ["golangci-lint"] = {
        command = "golangci-lint",
        rootPatterns = {".git", "go.mod"},
        debounce = 100,
        args = {"run", "--out-format", "json", "%filepath"},
        sourceName = "golangci-lint",
        parseJson = {
          sourceName = "Pos.Filename",
          sourceNameFilter = true,
          errorsRoot = "Issues",
          line = "Pos.Line",
          column = "Pos.Column",
          message = "${Text} [${FromLinter}]"
        }
      }
    },
    filetypes = {
      javascript = "eslint",
      typescript = "eslint",
      go = "golangci-lint"
    }
  }
}
