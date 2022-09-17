local status_telescope_ok, telescope = pcall(require, "telescope")
if not status_telescope_ok then
  return
end

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local telescope_custom_actions = {}

function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = #picker:get_multi_selection()
  if not num_selections or num_selections <= 1 then
    actions.add_selection(prompt_bufnr)
  end
  actions.send_selected_to_qflist(prompt_bufnr)

  local results = vim.fn.getqflist()

  for _, result in ipairs(results) do
    local current_file = vim.fn.bufname()
    local next_file = vim.fn.bufname(result.bufnr)

    if current_file == "" then
      vim.api.nvim_command("edit" .. " " .. next_file)
    else
      vim.api.nvim_command(open_cmd .. " " .. next_file)
    end
  end

  vim.api.nvim_command("cd .")
end

function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
  telescope_custom_actions._multiopen(prompt_bufnr, "vsplit")
end
function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
  telescope_custom_actions._multiopen(prompt_bufnr, "split")
end
function telescope_custom_actions.multi_selection_open_tab(prompt_bufnr)
  telescope_custom_actions._multiopen(prompt_bufnr, "tabe")
end
function telescope_custom_actions.multi_selection_open(prompt_bufnr)
  telescope_custom_actions._multiopen(prompt_bufnr, "edit")
end

telescope.setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case"
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    color_devicons = true,
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        mirror = false
      },
      vertical = {
        mirror = false
      },
      preview_cutoff = 0
    },
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    mappings = {
      i = {
        ["<C-?>"] = actions.which_key,
        ["<C-n>"] = actions.move_selection_previous,
        ["<C-p>"] = actions.move_selection_next,
        ["<C-CR>"] = telescope_custom_actions.multi_selection_open,
        ["<C-V>"] = telescope_custom_actions.multi_selection_open_vsplit,
        ["<C-S>"] = telescope_custom_actions.multi_selection_open_split,
        ["<C-T>"] = telescope_custom_actions.multi_selection_open_tab
      }
    }
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case" -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}
telescope.load_extension("ui-select")
telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("dap")

require("dots1.telescope.mappings")
