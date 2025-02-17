local is_grug_far_ok, grug_far = pcall(require, "grug-far")
if not is_grug_far_ok then
  return
end

grug_far.setup({})

local keymap = vim.keymap.set
keymap(
  "n",
  "<leader>ggr",
  function()
    grug_far.open(
      {
        engine = "ripgrep"
      }
    )
  end
)

keymap(
  "n",
  "<leader>gga",
  function()
    grug_far.open(
      {
        engine = "astgrep"
      }
    )
  end
)

