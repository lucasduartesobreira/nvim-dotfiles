return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup(
      {
        preset = "amongus",
        hi = {
          background = "None"
        },
        options = {
          show_source = {
            enabled = true,
            if_many = true
          },
          add_messages = {
            display_count = true
          },
          multilines = {
            enabled = true
          }
        }
      }
    )

    vim.diagnostic.open_float = require("tiny-inline-diagnostic.override").open_float
    vim.diagnostic.config({virtual_text = false}) -- Disable Neovim's default virtual text diagnostics
  end
}
