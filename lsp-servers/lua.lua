-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
USER = vim.fn.expand("$USER")

local sumneko_root_path = ""
local sumneko_binary = ""

sumneko_root_path = "/home/" .. USER .. "/lua-language-server"
sumneko_binary = "/home/" .. USER .. "/lua-language-server/bin/lua-language-server"

--add snippet support
local capabilities = require("lsp-server-configs/add-snippet").capabilities

--lsp_signature config
--local lsp_signature_attach = require("plug-config/lspsignature-config").on_attach
local lsp_format_attach = require("lsp-format").on_attach

function on_attach(client, bufnr)
  --lsp_signature_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  lsp_format_attach(client)
end

require "lspconfig".sumneko_lua.setup {
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
  on_attach = on_attach,
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";")
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = { [vim.fn.expand("$VIMRUNTIME/lua")] = true, [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true }
      }
    }
  },
  root_dir = require("lspconfig.util").root_pattern(".git")
}
