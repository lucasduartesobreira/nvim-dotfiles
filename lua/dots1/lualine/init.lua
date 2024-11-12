local is_lualine_ok, lualine = pcall(require, "lualine")
if not is_lualine_ok then
  return
end

local augroup = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd
local terminal_id = augroup("Change Color Scheme", {clear = false})
local colorscheme_name = vim.g.colors_name

aucmd(
  {"ColorScheme"},
  {
    group = terminal_id,
    pattern = "*",
    callback = function()
      colorscheme_name = vim.g.colors_name
      lualine.setup {
        options = {
          icons_enabled = true,
          theme = colorscheme_name,
          disabled_filetypes = {},
          section_separators = "",
          component_separators = ""
        },
        sections = {
          lualine_a = {"mode"},
          lualine_b = {"branch", "diff"},
          lualine_c = {"filename"},
          lualine_x = {"filetype"},
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
    end
  }
)

lualine.setup {
  options = {
    icons_enabled = true,
    theme = colorscheme_name,
    disabled_filetypes = {},
    section_separators = "",
    component_separators = ""
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch", "diff"},
    lualine_c = {"filename"},
    lualine_x = {"filetype"},
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
