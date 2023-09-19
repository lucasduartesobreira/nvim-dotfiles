require "nvim-treesitter.configs".setup {
  -- A list of parser names, or "all"
  ensure_installed = {"javascript", "typescript", "lua", "rust"},
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true
  },
  indent = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner"
      }
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner"
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner"
      }
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]b"] = "@block.outer"
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]B"] = "@block.outer"
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[b"] = "@block.outer"
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["[B"] = "@block.outer"
      }
    }
  },
  textsubjects = {
    enable = true,
    prev_selection = ",", -- (Optional) keymap to select the previous selection
    keymaps = {
      ["."] = "textsubjects-smart"
    }
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?"
    }
  },
  --[[
     [autotag = {
     [  enable = true
     [},
     ]]
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}

require("dots1.treesitter.context")()
