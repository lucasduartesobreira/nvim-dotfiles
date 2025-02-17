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

