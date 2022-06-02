local opts = {noremap = true, silent = true}

local keymap = vim.api.nvim_set_keymap

-- Map leader
keymap("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- move through windows
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- resize windows
keymap("n", "<A-k>", "<C-w>-", opts)
keymap("n", "<A-j>", "<C-w>+", opts)
keymap("n", "<A-h>", "<C-w><", opts)
keymap("n", "<A-l>", "<C-w>>", opts)

-- move with hjkl in insert mode
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-l>", "<Right>", opts)

-- move with hjkl in command mode
keymap("c", "<C-h>", "<Left>", opts)
keymap("c", "<C-j>", "<Down>", opts)
keymap("c", "<C-k>", "<Up>", opts)
keymap("c", "<C-l>", "<Right>", opts)

-- rebind split vertical, horizontal and close a split
keymap("n", "<A-x>", ":split<CR><C-w>j", opts)
keymap("n", "<A-v>", ":vsplit<CR><C-w>l", opts)
keymap("n", "<A-\\>", ":close<CR>", opts)

keymap("n", "gn", "o<esc>",opts)
keymap("n", "gN", "O<esc>",opts)

-- save with control+s
keymap("n", "<C-s>", "<cmd>w<CR>", opts)

-- sugar bind to ` (goto mark)
keymap("n", "gm", "`", opts)

-- Resource nvim
local is_plenary_ok, plenary_reload = pcall(require, "plenary.reload")
if is_plenary_ok then
  vim.keymap.set(
    "n",
    "<leader>r",
    function()
      plenary_reload.reload_module("dots1", true)
      vim.cmd [[source $MYVIMRC]]
    end
  )
end

-- Lazygit
keymap("n", "<leader>lg", "<cmd>LazyGit<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Keep centered
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "J", "mzJ'z", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-f>", "<C-f>zz", opts)
keymap("n", "<C-b>", "<C-b>zz", opts)

-- Jumplist mutations
--[[
   [keymap("n", "k", '(v:count > 5 ? "m\'" . v:count : "") . \'k\'', {expr = true})
   [keymap("n", "j", '(v:count > 5 ? "m\'" . v:count : "") . \'j\'', {expr = true})
   ]]

-- Move text
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("i", "<C-A-k>", "<esc>:m .-2<CR>==i", opts)
keymap("i", "<C-A-j>", "<esc>:m .+1<CR>==i", opts)
keymap("n", "<leader>k", "<esc>:m .-2<CR>==", opts)
keymap("n", "<leader>j", "<esc>:m .+1<CR>==", opts)

keymap("i", "<A-;>", "<esc>A;<esc>", opts)
keymap("n", "<A-;>", "A;<esc>", opts)

local augroup = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd
local terminal_id = augroup("Terminal", {clear = false})

aucmd(
  {"BufWinEnter", "WinEnter"},
  {group = terminal_id, pattern = "*", command = "nnoremap'<buffer> <leader>nt :botright new <bar> :terminal <CR>"}
)
