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
      elements = {
        -- You can change the order of elements in the sidebar
        "scopes",
        "breakpoints",
        "stacks",
        "watches"
      },
      size = 40,
      position = "left" -- Can be "left" or "right"
    },
    tray = {
      open_on_start = false,
      elements = {
        "repl"
      },
      size = 10,
      position = "bottom" -- Can be "bottom" or "top"
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil -- Floats will be treated as percentage of your screen.
    }
  }
)
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.cmd [[nnoremap <leader>dq :lua require('dapui').toggle()<CR>]]
vim.cmd [[nnoremap <leader>fe :lua require('dapui').float_element()<CR>]]
vim.cmd [[vnoremap <leader>de <Cmd>lua require("dapui").eval()<CR>]]
vim.cmd [[nnoremap <leader>de <Cmd>lua require("dapui").eval()<CR>]]
