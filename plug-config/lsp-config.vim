nnoremap <silent> gD   <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd   <Cmd>lua vim.lsp.buf.definition()<CR> 
nnoremap <silent> K   <Cmd>lua vim.lsp.buf.hover()<CR> 
nnoremap <silent> gi   <cmd>lua vim.lsp.buf.implementation()<CR> 
nnoremap <silent> <C-k>   <cmd>lua vim.lsp.buf.signature_help()<CR> 
nnoremap <silent> grn   <cmd>lua vim.lsp.buf.rename()<CR> 
nnoremap <silent> gr   <cmd>lua vim.lsp.buf.references()<CR> 
nnoremap <silent> [d   <cmd>lua vim.lsp.diagnostic.goto_prev()<CR> 
nnoremap <silent> ]d   <cmd>lua vim.lsp.diagnostic.goto_next()<CR> 

" auto-format
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 100)
