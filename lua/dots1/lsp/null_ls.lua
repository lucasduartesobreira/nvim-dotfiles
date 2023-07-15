local is_null_ls_ok, null_ls = pcall(require, "null-ls")
if not is_null_ls_ok then
  return
end

local builtins = null_ls.builtins

null_ls.setup(
  {
    sources = {
      builtins.code_actions.eslint_d
      --builtins.diagnostics.eslint_d,
      --builtins.diagnostics.golangci_lint,
      --builtins.diagnostics.standardjs,
      --builtins.formatting.eslint_d,
      --builtins.formatting.prettier,
      --builtins.formatting.gofmt,
      --builtins.formatting.goimports,
      --builtins.formatting.standardjs,
      --builtins.formatting.stylua
    }
  }
)
