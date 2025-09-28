return {
  "mfussenegger/nvim-lint",
  event = {"BufReadPre", "BufNewFile"},
  config = function()
    local is_lint_ok, lint = pcall(require, "lint")
    assert(is_lint_ok, "Failed to load lint")

    lint.linters_by_ft = {
      javascript = {"eslint_d"},
      javascriptreact = {"eslint_d"},
      typescript = {"eslint_d"},
      typescriptreact = {"eslint_d"}
    }

    local lintAugroup = vim.api.nvim_create_augroup("Lint", {clear = true})

    vim.api.nvim_create_autocmd(
      {"BufWritePost", "BufEnter", "InsertLeave"},
      {
        group = lintAugroup,
        pattern = {"*.js", "*.jsx", "*.ts", "*.tsx"},
        callback = function()
          lint.try_lint()
        end
      }
    )
  end
}
