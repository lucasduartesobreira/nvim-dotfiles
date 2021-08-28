require("bufferline").setup {
  options = {
    numbers = "none",
    close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = "▎",
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diagnostics_dict, _)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number)
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "" then
        return true
      end
      -- filter out by buffer name
      if vim.bo[buf_number].filetype ~= "dap-repl" then
        return true
      end
      if vim.fn.bufname(buf_number) ~= "dap-repl" then
        return true
      end
    end,
    offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center"}},
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = false,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "thick",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = "id",
    custom_areas = {
      right = function()
        local result = {}
        local error = vim.lsp.diagnostic.get_count(0, [[Error]])
        local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
        local info = vim.lsp.diagnostic.get_count(0, [[Information]])
        local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])

        if error ~= 0 then
          table.insert(result, {text = "  " .. error, guifg = "#EC5241"})
        end

        if warning ~= 0 then
          table.insert(result, {text = "  " .. warning, guifg = "#EFB839"})
        end

        if hint ~= 0 then
          table.insert(result, {text = "  " .. hint, guifg = "#A3BA5E"})
        end

        if info ~= 0 then
          table.insert(result, {text = "  " .. info, guifg = "#7EA9A7"})
        end
        return result
      end
    }
  }
}

-- Keybinds
vim.api.nvim_set_keymap("n", "[b", ":BufferLineCycleNext<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "]b", ":BufferLineCyclePrev<CR>", {silent = true})

vim.api.nvim_set_keymap("n", "<A-.>", ":BufferLineMoveNext<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<A-,>", ":BufferLineMovePrev<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>bse", ":BufferLineSortByExtension<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>bsd", ":BufferLineSortByDirectory<CR>", {silent = true})
vim.api.nvim_set_keymap(
  "n",
  "<leader>bsi",
  ":lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>",
  {silent = true}
)
vim.api.nvim_set_keymap("n", "<leader>bd", ":bdelete<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "gb", ":BufferLinePick<CR>", {silent = true})
