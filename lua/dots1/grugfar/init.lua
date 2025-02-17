local is_grug_far_ok, grug_far = pcall(require, "grug-far")
if not is_grug_far_ok then
  return
end

grug_far.setup(
  {
    keymaps = {
      abort = {
        n = "<leader>bg"
      }
    }
  }
)

local keymap = vim.keymap.set
keymap(
  "n",
  "<leader>gf",
  function()
    grug_far.open()
  end
)
