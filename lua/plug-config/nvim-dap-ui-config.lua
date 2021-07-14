require("dapui").setup(
  {
    icons = {
      expanded = "▾",
      collapsed = "▸"
    },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = {"<CR>", "<2-LeftMouse>"},
      open = "o",
      remove = "d",
      edit = "e"
    },
    sidebar = {
      open_on_start = true,
      elements = {
        -- You can change the order of elements in the sidebar
        "scopes",
        "breakpoints",
        "stacks",
        "watches"
      },
      width = 40,
      position = "left" -- Can be "left" or "right"
    },
    tray = {
      open_on_start = false,
      elements = {
        "repl"
      },
      height = 10,
      position = "bottom" -- Can be "bottom" or "top"
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil -- Floats will be treated as percentage of your screen.
    }
  }
)

vim.cmd [[nnoremap <leader>dq :lua require('dapui').toggle()<CR>]]
vim.cmd [[nnoremap <leader>fe :lua require('dapui').float_element()<CR>]]
vim.cmd [[vnoremap <leader>de <Cmd>lua require("dapui").eval()<CR>]]
vim.cmd [[nnoremap <leader>de <Cmd>lua require("dapui").eval()<CR>]]
