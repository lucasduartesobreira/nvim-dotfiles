nnoremap <silent> gD   <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> K   <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> grn   <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> [d   <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d   <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
