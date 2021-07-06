local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

--lsp_signature config
local on_attach = function (client, bufnr)
	require "lsp_signature".on_attach({
		bind = true,
		handler_opts = {
			border = "single"
		}
	})
end

require'lspconfig'.gopls.setup{
  capabilities = capabilities;
  on_attach = on_attach;
}
