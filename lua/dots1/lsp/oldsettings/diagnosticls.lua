local linters = {
  eslint_d = {
    command = "eslint_d",
    rootPatterns = {
      ".eslintrc",
      ".eslintrc.cjs",
      ".eslintrc.js",
      ".eslintrc.json",
      ".eslintrc.yaml",
      ".eslintrc.yml"
    },
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
  golangci_lint = {
    command = "golangci-lint",
    args = {"run", "--out-format", "json"},
    debounce = 100,
    parseJson = {
      sourceNameFilter = true,
      sourceName = "Pos.Filename",
      errorsRoot = "Issues",
      line = "Pos.Line",
      column = "Pos.Column",
      message = "[golangci_lint] ${Text} [${FromLinter}]"
    },
    rootPatterns = {".git", "go.mod"}
  },
  standard = {
    command = "./node_modules/.bin/standard",
    debounce = 100,
    args = {"--stdin"},
    offsetLine = 0,
    offsetColumn = 0,
    formatLines = 1,
    formatPattern = {
      [[^\s*<\w+>:(\d+):(\d+):\s+(.*)(\r|\n)*$]],
      {line = 1, column = 2, message = {"[standard] ", 3}}
    },
    rootPatterns = {".git"}
  }
}

local formatters = {
  prettier = {
    command = "prettier",
    args = {"--stdin", "--stdin-filepath", "%filepath"},
    rootPatterns = {
      ".prettierrc",
      ".prettierrc.json",
      ".prettierrc.toml",
      ".prettierrc.json",
      ".prettierrc.yml",
      ".prettierrc.yaml",
      ".prettierrc.json5",
      ".prettierrc.js",
      ".prettierrc.cjs",
      "prettier.config.js",
      "prettier.config.cjs"
    }
  },
  standard_fmt = {
    command = "./node_modules/.bin/standard",
    args = {"--stdin", "--fix"},
    rootPatterns = {".git"},
    isStderr = false,
    isStdout = true
  },
  eslint_d_fmt = {
    command = "eslint_d",
    args = {
      "--fix-to-stdout",
      "--stdin",
      "--stdin-filename",
      "%filepath"
    },
    rootPatterns = {
      ".eslintrc",
      ".eslintrc.cjs",
      ".eslintrc.js",
      ".eslintrc.json",
      ".eslintrc.yaml",
      ".eslintrc.yml"
    }
  },
  luafmt = {
    command = "luafmt",
    args = {"--indent-count", 2, "--stdin"}
  },
  gofmt = {
    command = "gofmt",
    args = {"-s"},
    rootPatterns = {"go.mod", ".git"}
  },
  goimports = {
    command = "goimports",
    rootPatterns = {"go.mod", ".git"}
  }
}

local lsp_format_attach = require("lsp-format").on_attach

function on_attach(client, bufnr)
  lsp_format_attach(client)
end

require "lspconfig".diagnosticls.setup {
  on_attach = on_attach,
  filetypes = {"javascript", "typescript", "go", "lua"},
  cmd = {"diagnostic-languageserver", "--stdio", "--log-level", "2"},
  init_options = {
    linters = linters,
    filetypes = {
      javascript = "eslint_d",
      typescript = "eslint_d",
      go = "golangci_lint"
    },
    formatters = formatters,
    formatFiletypes = {
      typescript = {"standard_fmt", "eslint_d_fmt", "prettier"},
      javascript = {"standard_fmt", "eslint_d_fmt", "prettier"},
      rust = {"rustfmt"},
      lua = {"luafmt"},
      go = {"gofmt", "goimports"}
    }
  }
}
