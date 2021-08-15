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

" Vim integration
nnoremap Y y$

" Keep centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ'z

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u

" Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-A-k> <esc>:m .-2<CR>==i
inoremap <C-A-j> <esc>:m .+1<CR>==i
nnoremap <leader>k <esc>:m .-2<CR>==
nnoremap <leader>j <esc>:m .+1<CR>==

" Copied from The Primeagen vim config
" Nagivation
nnoremap <C-A-k> :cnext<CR>zz
nnoremap <C-A-j> :cprev<CR>zz
nnoremap <C-q> :call ToggleQFList(1)<CR>

let g:the_primeagen_qf_l = 0
let g:the_primeagen_qf_g = 0

fun! ToggleQFList(global)
    if a:global
        if g:the_primeagen_qf_g == 1
            let g:the_primeagen_qf_g = 0
            cclose
        else
            let g:the_primeagen_qf_g = 1
            copen
        end
    else
        if g:the_primeagen_qf_l == 1
            let g:the_primeagen_qf_l = 0
            lclose
        else
            let g:the_primeagen_qf_l = 1
            lopen
        end
    endif
endfun
