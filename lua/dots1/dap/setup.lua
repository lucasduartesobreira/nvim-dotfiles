local is_dap_ok, dap = pcall(require, "dap")
if not is_dap_ok then
  return
end

local is_vscode_js_adapter_ok, dap_vscode_js = pcall(require, "dap-vscode-js")
if not is_vscode_js_adapter_ok then
  return
end

dap_vscode_js.setup(
  {
    adapters = {"pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost"}
  }
)

local settings = require("dots1.dap.dap_settings")

for adapter, config in pairs(settings.adapters) do
  (dap.adapters)[adapter] = config
end

for adapter, config in pairs(settings.configuration) do
  (dap.configurations)[adapter] = config
end
