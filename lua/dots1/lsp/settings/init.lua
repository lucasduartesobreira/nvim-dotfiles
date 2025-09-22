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
local is_ocamllsp_ok, ocamllsp = pcall(require, "dots1.lsp.settings.ocamllsp")
if not is_ocamllsp_ok then
  ocamllsp = false
end
local is_elixirls_ok, elixirls = pcall(require, "dots1.lsp.settings.elixirls")
if not is_elixirls_ok then
  elixirls = false
end

local is_tstools_ok, tstools = pcall(require, "dots1.lsp.settings.typescript-tools")
if not is_tstools_ok then
  tstools = false
end

local is_astgrep_ok, astgrep = pcall(require, "dots1.lsp.settings.astgrep")
if not is_astgrep_ok then
  astgrep = false
end

local is_tsgo_ok, tsgo = pcall(require, "dots1.lsp.settings.tsgo")
if not is_tsgo_ok then
  return
end

return {
  rust_analyzer = rust_analyzer,
  gopls = gopls,
  lua_ls = lua_ls,
  --ts_ls = tsserver,
  --["typescript-tools"] = tstools,
  efm = efm,
  pyright = pyright,
  ocamllsp = ocamllsp,
  elixirls = elixirls,
  ast_grep = astgrep,
  tsgo_ls = tsgo
}
