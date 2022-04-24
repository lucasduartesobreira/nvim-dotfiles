local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
keymap("n", "<leader>fgf", "<cmd>lua require('telescope.builtin').git_files()<cr>", opts)
keymap("n", "<leader>fw", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", "<leader>fnf", "<cmd>lua require('telescope.builtin').find_files{cwd = '~/.config/nvim'}<CR>", opts)
keymap("n", "<leader>fb", "<cmd>lua require 'telescope'.extensions.file_browser.file_browser{hidden = true}<CR>", opts)
keymap("n", "<leader>bl", "<cmd>lua require('telescope.builtin').buffers{show_all_buffers = true}<cr>", opts)
