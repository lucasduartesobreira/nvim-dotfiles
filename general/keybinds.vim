nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <A-k> <C-w>-
nnoremap <A-j> <C-w>+
nnoremap <A-h> <C-w><
nnoremap <A-l> <C-w>>

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

inoremap <A-w> <C-o>b
inoremap <A-W> <C-o>w

nnoremap <A-x> :split<CR><C-w>j " Horizontal split
nnoremap <A-v> :vsplit<CR><C-w>l " Vertical split
nnoremap <A-\> :close<CR>

nnoremap <A-<> <C-w>K " Convert vertical to horizontal split
nnoremap <A->> <C-w>L " Convert horizontal to vertical split

nnoremap <C-s> <cmd>w<CR>

nnoremap gm `


"Resource nvim
nnoremap <leader>r <cmd>:source $MYVIMRC<CR>

"Open Lazygit
nnoremap <leader>lg <cmd>LazyGit<CR>

augroup Terminal
autocmd BufWinEnter,WinEnter * nnoremap <buffer> <leader>nt :botright new <bar> :terminal <CR>
augroup end

" Keep centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ'z
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz

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

inoremap <A-;> <esc>A;<esc>
nnoremap <A-;> A;<esc>

fun! Rename()
    call inputsave()
    let name = input('Enter name:')
    call inputrestore()

    let path = expand("%:p:h")
    let file_extension = expand("%:p:e")

    let name_with_path =  path . '/' . name . '.' . file_extension

    call inputsave()
    let delete_file =confirm("Delete?","&Yes\n&No",1) 
    call inputrestore()

    try
        execute 'sav ' . name_with_path
        if delete_file == 1
            execute "call delete(expand('#'))"
        end
        bd #
    endtry

endfunction

nnoremap <leader>fr :call Rename()

fun! CargoTestWArgs(args)
    let to_execute = '!run_on_new_tab.sh Testing "cargo test'
    if len(a:args) != 0
        let to_execute .= ' -- '
        try
            let split_args = split(a:args)
            for i in split(a:args)
                let to_execute .= '--' . i
            endfor
        endtry
    endif 

    let to_execute .= '"'

    execute to_execute
endfunction

fun! CargoTest()
    call inputsave()
    let ignored = confirm("Run ignored test?","&Yes\n&No",2) 
    call inputrestore()

    echo ignored

    let to_execute = '!run_on_new_tab.sh Testing "cargo test'

    if ignored == 1
        let to_execute .= ' -- --ignored"'
    else
        let to_execute .= '"'
    endif

    execute to_execute
endfunction

command -nargs=* CargoTestWArgs call CargoTest('<args>')
command -nargs=* CargoTest call CargoTest()
