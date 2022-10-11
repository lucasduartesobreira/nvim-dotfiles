return {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
  cmd = {"lua-language-server"},
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
        globals = {"vim"}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          [vim.fn.stdpath("data") .. "/site/pack/packer/start"] = true,
          [vim.fn.stdpath("data") .. "/site/pack/packer/opt"] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true
        }
      }
    }
  },
  root_dir = require("lspconfig.util").root_pattern(".git")
}
