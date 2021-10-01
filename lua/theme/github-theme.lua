require "lualine".setup {
  options = {
    icons_enabled = true,
    theme = "github",
    component_separators = "",
    section_separators = "",
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch", "diff"},
    lualine_c = {"filename"},
    lualine_x = {"encoding", "fileformat", "filetype"},
    lualine_y = {"progress"},
    lualine_z = {"location"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- Lua
require("github-theme").setup(
  {
    theme_style = "dark_default",
    function_style = "bold",
    dark_float = true,
    colors = {
      lualine = {
        normal = {a = {bg = "blue", fg = "bg"}, b = {bg = "blue", fg = "bg"}, c = {bg = "blue", fg = "bg"}},
        insert = {a = {bg = "green", fg = "bg"}, b = {bg = "green", fg = "bg"}, c = {bg = "green", fg = "bg"}},
        command = {a = {bg = "magenta", fg = "bg"}, b = {bg = "magenta", fg = "bg"}, c = {bg = "magenta", fg = "bg"}},
        visual = {a = {bg = "yellow", fg = "bg"}, b = {bg = "yellow", fg = "bg"}, c = {bg = "yellow", fg = "bg"}},
        replace = {a = {bg = "red", fg = "bg"}, b = {bg = "red", fg = "bg"}, c = {bg = "red", fg = "bg"}}
      }
    }
  }
)
