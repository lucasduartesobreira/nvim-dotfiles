local is_toggleterm_ok, toggleterm = pcall(require, "toggleterm")
if not is_toggleterm_ok then
  return
end

toggleterm.setup {
  open_mapping = [[<c-\>]],
  hide_number = true,
  start_on_insert = true,
  direction = "float",
  float_opts = {
    border = "curved",
    winblend = 0
  }
}

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({cmd = "lazygit", hidden = true})

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local node = Terminal:new({cmd = "node", hidden = true})

function _NODE_TOGGLE()
  node:toggle()
end

local bashtop = Terminal:new({cmd = "bashtop", hidden = true})

function _BASHTOP_TOGGLE()
  bashtop:toggle()
end

local taskwarrior = Terminal:new({cmd = "taskwarrior-tui", hidden = true})

function _TASKWARRIOR_TOGGLE()
  taskwarrior:toggle()
end

vim.keymap.set("n", "<leader>lg", _LAZYGIT_TOGGLE, {silent = true})
vim.keymap.set("n", "<leader>bt", _BASHTOP_TOGGLE, {silent = true})
vim.keymap.set("n", "<leader>tw", _TASKWARRIOR_TOGGLE, {silent = true})
