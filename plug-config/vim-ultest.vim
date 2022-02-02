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


lua << EOF
require("ultest").setup({
    builders = {
        ['typescript#jest'] = function (cmd)
            table.insert(cmd, 2, "--testTimeout=300000")
            return {
                dap = {
                    name = "Launch",
                    type = "node2",
                    request = "launch",
                    --program = "${file}",
                    cwd = vim.fn.getcwd(),
                    sourceMaps = true,
                    protocol = "inspector",
                    console = "integratedTerminal",
                    runtimeArgs = {"--inspect-brk"},
                    args = cmd,
                    port = 9229
                },
            }
        end
    }
})

EOF
