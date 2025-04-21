local is_dap_ok, dap = pcall(require, "dap")
if not is_dap_ok then
  return
end

local settings = require("dots1.dap.dap_settings")

for adapter, config in pairs(settings.adapters) do
  (dap.adapters)[adapter] = config
end

for adapter, config in pairs(settings.configuration) do
  (dap.configurations)[adapter] = config
end
