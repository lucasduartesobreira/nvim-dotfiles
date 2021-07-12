local on_attach = function(client, bufnr)
  require "lsp_signature".on_attach(
    {
      bind = true,
      handler_opts = {
        border = "none"
      }
    }
  )
end

return {on_attach = on_attach}
