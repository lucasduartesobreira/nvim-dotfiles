return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = {enabled = true},
    dim = {enabled = true},
    indent = {enabled = true},
    input = {enabled = true},
    notifier = {enabled = true}
  },
  keys = {
    {
      "<leader>nd",
      function()
        Snacks.notifier.hide()
      end,
      desc = "[N]otification [D]elete"
    },
    {
      "<leader>nh",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "[N]otification [H]istory"
    }
  }
}
