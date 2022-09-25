local opts = {noremap = true, silent = true}

local keymap = vim.keymap.set

-- Map leader
keymap("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap({"n", "v"}, "<leader>p", '"_dP')

-- move through windows
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- terminal binds for command mode
keymap("c", "<C-a>", "<Home>", {})
keymap("c", "<C-e>", "<End>", {})
keymap("c", "<C-f>", "<Right>", {})
keymap("c", "<C-b>", "<Left>", {})
keymap("c", "<A-f>", "<S-Right>", {})
keymap("c", "<A-b>", "<S-Left>", {})

-- terminal binds for insert mode
keymap("i", "<C-a>", "<Home>", {})
keymap("i", "<C-e>", "<End>", {})
keymap("i", "<C-f>", "<Right>", {})
keymap("i", "<C-b>", "<Left>", {})
keymap("i", "<A-f>", "<S-Right>", {})
keymap("i", "<A-b>", "<S-Left>", {})
keymap("i", "<A-w>", "<Esc>lciw", {})
keymap("i", "<A-d>", "<Esc>lcw", {})
keymap("i", "<C-u>", "<Esc>cc", {})
keymap("i", "<A-u>", "<Esc>lvwgU", {})

-- resize windows
keymap("n", "<A-k>", "<C-w>-", opts)
keymap("n", "<A-j>", "<C-w>+", opts)
keymap("n", "<A-h>", "<C-w><", opts)
keymap("n", "<A-l>", "<C-w>>", opts)

-- move with hjkl in insert mode
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)

-- rebind split vertical, horizontal and close a split
keymap("n", "<A-x>", ":split<CR><C-w>j", opts)
keymap("n", "<A-v>", ":vsplit<CR><C-w>l", opts)
keymap("n", "<A-\\>", ":close<CR>", opts)

keymap("n", "gn", "o<esc>", opts)
keymap("n", "gN", "O<esc>", opts)

-- save with control+s
keymap("n", "<C-s>", "<cmd>w<CR>", opts)
keymap("i", "<C-s>", "<cmd>w<CR>", opts)

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
vim.cmd [[
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
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
