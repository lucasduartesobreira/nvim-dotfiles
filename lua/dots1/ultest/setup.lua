local is_ultest_ok, ultest = pcall(require, "ultest")
if not is_ultest_ok then
  return
end

local settings = require("dots1.ultest.settings")

return function()
  ultest.setup(settings)
  vim.cmd [[
" vim-test config
let test#custom_runners = {'typescript': ['jest']}
let test#strategy = 'neovim'
let test#go#runner = 'gotest'

" vim-ultest config
let test#typescript#jest#options = '--color=always'
]]
  local g = vim.g
  g.ultest_use_pty = 1
  g.ultest_disable_grouping = { "javascript#jest" }
end
