local is_conform_ok, conform = pcall(require, "conform")
if not is_conform_ok then
  return
end

conform.setup(
  {
    formatters_by_ft = {
      lua = {"luafmt"},
      go = {"gofmt", "goimports"},
      typescript = {
        "biome",
        "prettierd",
        "prettier",
        stop_after_first = true
      },
      typescriptreact = {
        "biome",
        "prettierd",
        "prettier",
        stop_after_first = true
      },
      javascript = {
        "biome",
        "prettierd",
        "prettier",
        stop_after_first = true
      }
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback"
    },
    formatters = {
      luafmt = {
        command = "luafmt",
        args = {"--indent-count", "2", "--stdin"},
        stdin = true,
        prepend_args = {}
      }
    }
  }
)
