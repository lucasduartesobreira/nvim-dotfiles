local home = vim.fn.expand("$HOME")
local config_root = home .. "/.config/nvim/lsp-config"
local efm_config_path = config_root .. "/config.yaml"

return {
  on_attach = function(client, bufnr)
    local augroup = vim.api.nvim_create_augroup
    local aucmd = vim.api.nvim_create_autocmd
    local group = augroup("Eslint_dStop", {})
    aucmd(
      {"VimLeavePre"},
      {
        group = group,
        pattern = {"*.ts", "*.tsx", "*.js", "*.jsx"},
        callback = function()
          os.execute("eslint_d stop")
        end
      }
    )
  end,
  filetypes = {"javascript", "typescript", "typescriptreact", "javascriptreact", "go", "lua"},
  cmd = {"efm-langserver", "-c", efm_config_path},
  init_options = {documentFormatting = true, publishDiagnostics = true},
  single_file_support = true
}
