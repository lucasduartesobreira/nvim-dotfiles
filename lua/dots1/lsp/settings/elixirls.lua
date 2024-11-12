return {
  on_attach = function(client)
    client.server_capabilities.documentHighlightProvider = false
  end,
  cmd = {"/home/lucas/.asdf/shims/elixir-ls"}
}
