local is_cokeline_ok, cokeline = pcall(require, "cokeline")
if not is_cokeline_ok then
  return
end

local is_picking_focus = require("cokeline/mappings").is_picking_focus
local is_picking_close = require("cokeline/mappings").is_picking_close
local get_hex = require("cokeline/utils").get_hex
local errors_fg = get_hex("DiagnosticError", "fg")
local warnings_fg = get_hex("DiagnosticWarn", "fg")
local info_fg = get_hex("DiagnosticInfo", "fg")
local hint_fg = get_hex("DiagnosticHint", "fg")
local green = vim.g.terminal_color_2
local palette = require("nightfox.palette").load("nightfox")
local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_3

cokeline.setup(
  {
    default_hl = {
      fg = function(buffer)
        return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
      end,
      bg = get_hex("ColorColumn", "bg")
    },
    components = {
      {
        text = " ",
        bg = palette.bg0
      },
      {
        text = "",
        fg = get_hex("ColorColumn", "bg"),
        bg = palette.bg0
      },
      {
        text = function(buffer)
          return (is_picking_focus() or is_picking_close()) and buffer.pick_letter .. " " or buffer.devicon.icon
        end,
        fg = function(buffer)
          return (is_picking_focus() and yellow) or (is_picking_close() and red) or buffer.devicon.color
        end,
        style = function(_)
          return (is_picking_focus() or is_picking_close()) and "italic,bold" or nil
        end
      },
      {
        text = " "
      },
      {
        text = function(buffer)
          local has_diagnostics =
            buffer.diagnostics.errors ~= 0 or buffer.diagnostics.warnings ~= 0 or buffer.diagnostics.infos ~= 0 or
            buffer.diagnostics.hints ~= 0

          local space_after_sign = has_diagnostics and "" or "  "
          return (buffer.unique_prefix) .. buffer.filename .. space_after_sign
        end,
        style = function(buffer)
          return buffer.is_focused and "bold" or nil
        end
      },
      {
        text = function(buffer)
          local errors = buffer.diagnostics.errors ~= 0 and "  " .. buffer.diagnostics.errors or ""

          return errors
        end,
        fg = function(buffer)
          return buffer.diagnostics.errors ~= 0 and errors_fg or nil
        end,
        truncation = {priority = 1}
      },
      {
        text = function(buffer)
          local warnings = buffer.diagnostics.warnings ~= 0 and "  " .. buffer.diagnostics.warnings or ""

          return warnings
        end,
        fg = function(buffer)
          return buffer.diagnostics.warnings ~= 0 and warnings_fg or nil
        end,
        truncation = {priority = 100}
      },
      {
        text = function(buffer)
          local infos = buffer.diagnostics.infos ~= 0 and "  " .. buffer.diagnostics.infos or ""

          return infos
        end,
        fg = function(buffer)
          return buffer.diagnostics.infos ~= 0 and info_fg or nil
        end,
        truncation = {priority = 100}
      },
      {
        text = function(buffer)
          local hints = buffer.diagnostics.hints ~= 0 and "  " .. buffer.diagnostics.hints or ""

          return hints
        end,
        fg = function(buffer)
          return buffer.diagnostics.hints ~= 0 and hint_fg or nil
        end,
        truncation = {priority = 100}
      },
      {
        text = function(buffer)
          local has_diagnostics =
            buffer.diagnostics.errors ~= 0 or buffer.diagnostics.warnings ~= 0 or buffer.diagnostics.infos ~= 0 or
            buffer.diagnostics.hints ~= 0

          local space_before_sign = has_diagnostics and " " or ""
          return space_before_sign .. (buffer.is_modified and "●" or "")
        end,
        fg = function(buffer)
          return buffer.is_modified and green or nil
        end,
        delete_buffer_on_left_click = true,
        truncation = {priority = 1}
      },
      {
        text = "",
        fg = get_hex("ColorColumn", "bg"),
        bg = palette.bg0
      }
    }
  }
)

local keymap = vim.keymap.set
keymap("n", "<leader>bd", ":bdelete<CR>", {silent = true})
keymap("n", "gb", "<Plug>(cokeline-pick-focus)", {silent = true})
keymap("n", "<leader>cb", "<Plug>(cokeline-pick-delete)", {silent = true})
