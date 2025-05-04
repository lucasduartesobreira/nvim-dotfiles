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
        path = {
          "lua/?.lua",
          "lua/?/init.lua"
        }
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim"}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {vim.env.VIMRUNTIME},
        checkThirdParty = false
      },
      telemetry = {enabled = false},
      hint = {
        enable = true
      }
    }
  }
}
