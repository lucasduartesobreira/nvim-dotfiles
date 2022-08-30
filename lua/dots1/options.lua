local options = {
  clipboard = "unnamedplus",
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  number = true,
  relativenumber = true,
  signcolumn = "yes",
  cmdheight = 1,
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = false,
  showmode = false,
  smartcase = true,
  smartindent = true,
  timeoutlen = 1000,
  undofile = true,
  hidden = true,
  updatetime = 300,
  foldlevel = 20,
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()"
}

local autocmd = vim.api.nvim_create_autocmd

autocmd({"BufWinEnter"}, {command = "normal zx"})

for key, value in pairs(options) do
  vim.opt[key] = value
end

if vim.api.nvim_eval('exists("+termguicolors")') then
  vim.g["&t_8f"] = "<Esc>[38;2;%lu;%lu;%lum"
  vim.g["&t_8b"] = "<Esc>[48;2;%lu;%lu;%lum"
  vim.opt.termguicolors = true
end
