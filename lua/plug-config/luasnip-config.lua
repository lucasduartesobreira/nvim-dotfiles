--luasnip
require "luasnip".config.set_config(
  {
    history = false,
    updateevents = nil
  }
)

require("luasnip/loaders/from_vscode").lazy_load()
