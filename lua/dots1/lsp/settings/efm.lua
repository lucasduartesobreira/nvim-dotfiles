local home = vim.fn.expand("$HOME")
local config_root = home .. "/.config/nvim/lsp-config"
local efm_config_path = config_root .. "/config.yaml"

return {
  --on_attach = on_attach,
  filetypes = {"javascript", "typescript", "go", "lua"},
  cmd = {"efm-langserver", "-c", efm_config_path},
  init_options = {documentFormatting = true, publishDiagnostics = true}
}
