local is_rust_ok, rust_analyzer = pcall(require, "dots1.lsp.settings.rust_analyzer")
if not is_rust_ok then
  rust_analyzer = false
end
local is_go_ok, gopls = pcall(require, "dots1.lsp.settings.gopls")
if not is_go_ok then
  gopls = false
end
local is_lua_ok, lua_ls = pcall(require, "dots1.lsp.settings.lua_ls")
if not is_lua_ok then
  lua_ls = false
end
local is_ts_ok, tsserver = pcall(require, "dots1.lsp.settings.tsserver")
if not is_ts_ok then
  tsserver = false
end
local is_efm_ok, efm = pcall(require, "dots1.lsp.settings.efm")
if not is_efm_ok then
  efm = false
end
local is_pyright_ok, pyright = pcall(require, "dots1.lsp.settings.pyright")
if not is_pyright_ok then
  is_pyright_ok = false
end

return {
  rust_analyzer = rust_analyzer,
  gopls = gopls,
  lua_ls = lua_ls,
  tsserver = tsserver,
  efm = efm,
  pyright = pyright
}
