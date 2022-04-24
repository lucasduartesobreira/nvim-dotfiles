local status_telescope_ok, telescope = pcall(require, 'telescope')
if not status_telescope_ok then
  return
end
telescope.setup{
defaults = {
    vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case'
        },
    prompt_prefix = "> ",
    selection_caret = "> ",
    color_devicons = true,
    layout_strategy = "flex",
    layout_config = {
        horizontal = {
            mirror = false,
            },
        vertical = {
            mirror = false,
            },
        preview_cutoff = 0
        },
    },
extensions = {
    fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = false, -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
        },
    }
}

telescope.load_extension('fzf')
telescope.load_extension "file_browser"

local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
keymap("n", "<leader>fgf", "<cmd>lua require('telescope.builtin').git_files()<cr>", opts)
keymap("n", "<leader>fw", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", "<leader>fnf", "<cmd>lua require('telescope.builtin').find_files{cwd = '~/.config/nvim'}<CR>", opts)
keymap("n", "<leader>fb", "<cmd>lua require 'telescope'.extensions.file_browser.file_browser{hidden = true}<CR>", opts)
--nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_commits()<cr>
--nnoremap <leader>bl <cmd>lua require('telescope.builtin').buffers{show_all_buffers = true}<cr>
--nnoremap <cr> <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
--nnoremap <leader>tc :TodoTelescope<cr>

--LSP Integration
--nnoremap <leader>gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
--nnoremap <leader>gi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
--nnoremap <leader>ld <cmd>Telescope diagnostics bufnr=0 <cr>
--nnoremap gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
