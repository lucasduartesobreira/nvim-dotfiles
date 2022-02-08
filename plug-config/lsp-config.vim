"nnoremap <silent> gD   <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> K   <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> grn   <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> [d   <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d   <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>sdl <cmd> lua vim.lsp.diagnostic.open_float()<CR>
nnoremap <silent> <space>D <cmd>lua vim.lsp.buf.type_definition()<CR>
