" vim-test config
let test#custom_runners = {'typescript': ['jest']}
let test#strategy = 'neovim'
let test#go#runner = 'gotest'

" vim-ultest config
let g:ultest_use_pty = 1
let test#typescript#jest#options = '--color=always'

nmap ]t <Plug>(ultest-next-fail)
nmap [t <Plug>(ultest-prev-fail)
nmap <silent> <leader>ts <Plug>(ultest-summary-toggle)
nmap <silent> <leader>trf <Plug>(ultest-run-file)
nmap <silent> <leader>trn <Plug>(ultest-run-nearest)
nmap <silent> <leader>to <Plug>(ultest-output-show)
nmap <silent> <leader>tdf <Plug>(ultest-debug-file)
nmap <silent> <leader>tdn <Plug>(ultest-debug-nearest)
