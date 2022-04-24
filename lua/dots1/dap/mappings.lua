local opts = { silent = true }
local keymap = vim.keymap.set

-- DAP
keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", opts)
keymap("n", "<F9>", ":lua require'dap'.step_back()<CR>", opts)
keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>", opts)
keymap("n", "<leader>tb", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>sb", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
keymap("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", opts)
keymap("n", "<leader>dl", ":lua require'dap'.run_last()<CR>", opts)
keymap("n", "<leader>du", ":lua require'dap'.up()<CR>", opts)
keymap("n", "<leader>dd", ":lua require'dap'.down()<CR>", opts)
keymap("n", "<leader>dt", ":lua require'dap'.terminate()<CR>", opts)

-- DAP UI
keymap("n", "<leader>dq", ":lua require('dapui').toggle()<CR>", opts)
keymap("n", "<leader>fe", ":lua require('dapui').float_element()<CR>", opts)
keymap("v", "<leader>de", "<Cmd>lua require('dapui').eval()<CR>", opts)
keymap("n", "<leader>de", "<Cmd>lua require('dapui').eval()<CR>", opts)
