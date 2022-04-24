local is_rust_ok, rust_analyzer = pcall(require, "dots1.lsp.settings.rust_analyzer")
if not is_rust_ok then
  rust_analyzer = false
end
local is_go_ok, gopls = pcall(require, "dots1.lsp.settings.gopls")
if not is_go_ok then
  gopls = false
end
local is_lua_ok, sumneko_lua = pcall(require, "dots1.lsp.settings.sumneko_lua")
if not is_lua_ok then
  sumneko_lua = false
end
local is_ts_ok, tsserver = pcall(require, "dots1.lsp.settings.tsserver")
if not is_ts_ok then
  tsserver = false
end
local is_efm_ok, efm = pcall(require, "dots1.lsp.settings.efm")
if not is_efm_ok then
  efm = false
end

return {
  rust_analyzer = rust_analyzer,
  gopls = gopls,
  sumneko_lua = sumneko_lua,
  tsserver = tsserver,
  efm = efm
}
