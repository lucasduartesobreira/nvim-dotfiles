local status_lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not status_lspconfig_ok then
  return
end

local handlers = require("dots1.lsp.handlers")

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  local on_attach = handlers.build_on_attach(config.on_attach)
  config.on_attach = on_attach
  config = vim.tbl_deep_extend(
    "force",
    {
      on_init = handlers.on_init,
      capabilities = handlers.capabilities,
      flags = {
        debounce_text_changes = nil
      }
    },
    config
  )
  lspconfig[server].setup(config)
end

return {
  run = function()
    local configs = require("dots1.lsp.settings")
    for server_name, config in pairs(configs) do
      setup_server(server_name, config)
    end
  end
}
