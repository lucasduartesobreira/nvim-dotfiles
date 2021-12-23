lua << EOF
require('telescope').setup{
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
    }
  }
}

require('telescope').load_extension('fzf')
EOF

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fw <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fnf <cmd>lua require('telescope.builtin').find_files{cwd = '~/.config/nvim'}<cr>
nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap <leader>bl <cmd>lua require('telescope.builtin').buffers{show_all_buffers = true}<cr>
nnoremap <cr> <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap <leader>tc :TodoTelescope<cr>

"LSP Integration
nnoremap <leader>gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>gi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap <leader>ld <cmd>Telescope diagnostics bufnr=0 <cr>
nnoremap gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
