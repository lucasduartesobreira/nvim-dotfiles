nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

augroup Terminal
autocmd BufWinEnter,WinEnter * nnoremap <buffer> <leader>nt :botright new <bar> :terminal <CR>
augroup end

function LuasnipCurrentNodeNil()
    if luaeval("Luasnip_current_nodes==nil")
        return 0
    endif
    :lua Luasnip_current_nodes[vim.fn.bufnr("%")]=nil
endfunction

augroup Sla
autocmd BufWinEnter,WinEnter * inoremap <buffer> <Esc> <Esc>:call LuasnipCurrentNodeNil()<CR>
augroup end
