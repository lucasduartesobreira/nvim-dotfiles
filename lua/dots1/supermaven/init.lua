local is_supermaven_nvim_ok, supermaven_nvim = pcall(require, "supermaven-nvim")
if not is_supermaven_nvim_ok then
  return
end

supermaven_nvim.setup(
  {
    keymaps = {
      accept_suggestion = "<leader><Tab>",
      clear_suggestion = "<C-]>",
      accept_word = "<C-j>"
    },
    disable_inline_completion = false, -- disables inline completion for use with cmp
    disable_keymaps = false -- disables built in keymaps for more manual control
  }
)
