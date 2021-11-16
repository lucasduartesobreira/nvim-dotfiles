local snippet_capabitilies = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

return {
  capabilities = snippet_capabitilies
}
