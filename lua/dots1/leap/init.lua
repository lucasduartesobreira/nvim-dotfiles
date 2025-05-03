local is_leap_ok, leap = pcall(require, "leap")
if not is_leap_ok then
  return
end

leap.set_default_mappings()
require("leap.user").set_repeat_keys("<s-enter>", "<backspace>", "<tab>")
leap.opts.special_keys.next_target = "<s-enter>"

leap.opts.preview_filter = function(ch0, ch1, ch2)
  return not (ch1:match("%s") or ch0:match("%a") and ch1:match("%a") and ch2:match("%a"))
end

local saved_hls
vim.api.nvim_create_autocmd(
  "User",
  {
    pattern = "LeapEnter",
    callback = function()
      saved_hls = vim.o.hlsearch
      vim.o.hlsearch = false
    end
  }
)
vim.api.nvim_create_autocmd(
  "User",
  {
    pattern = "LeapLeave",
    callback = function()
      vim.o.hlsearch = saved_hls
    end
  }
)

vim.keymap.set(
  {"n", "x", "o"},
  "gs",
  function()
    require("leap.remote").action()
  end
)
