local is_cmp_ok, cmp = pcall(require, "blink.cmp")
if not is_cmp_ok then
  return
end

local kind_texts = {
  CmdLine = "[CMD]",
  Path = "[PATH]",
  File = "[FILE]",
  Buffer = "[BUF]",
  LSP = "[LSP]",
  Snippets = "[Snip]",
  supermaven = "[SuperMaven]",
  Ripgrep = "[RG]"
}

cmp.setup {
  cmdline = {
    enabled = true
  },
  keymap = {
    preset = "enter",
    ["<C-space>"] = {"show", "show_documentation", "hide_documentation"},
    ["<C-y>"] = {"hide", "fallback"},
    ["<CR>"] = {"accept", "fallback"},
    ["<C-m>"] = {"accept", "fallback"},
    ["<Tab>"] = {"fallback"},
    ["<S-Tab>"] = {"fallback"},
    ["<Up>"] = {"select_prev", "fallback"},
    ["<Down>"] = {"select_next", "fallback"},
    ["<C-p>"] = {"select_prev", "fallback_to_mappings"},
    ["<C-n>"] = {"select_next", "fallback_to_mappings"},
    ["<C-u>"] = {"scroll_documentation_up", "fallback"},
    ["<C-d>"] = {"scroll_documentation_down", "fallback"},
    ["<C-k>"] = {"show_signature", "hide_signature", "fallback"}
  },
  signature = {enabled = true, window = {border = "rounded"}},
  snippets = {
    preset = "luasnip"
  },
  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = "normal"
  },
  -- (Default) Only show the documentation popup when manually triggered
  completion = {
    documentation = {auto_show = true, window = {border = "rounded"}},
    menu = {
      auto_show = true,
      border = "rounded",
      draw = {
        columns = {{"label", "label_description", gap = 1}, {"kind_icon", "source_name"}},
        components = {
          source_name = {
            text = function(ctx)
              return kind_texts[ctx.source_name] or ctx.source_name
            end
          },
          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              if vim.tbl_contains({"Path"}, ctx.source_name) then
                local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then
                  icon = dev_icon
                end
              else
                icon =
                  require("lspkind").symbolic(
                  ctx.kind,
                  {
                    mode = "symbol"
                  }
                )
              end

              return icon .. ctx.icon_gap
            end,
            -- Optionally, use the highlight groups from nvim-web-devicons
            -- You can also add the same function for `kind.highlight` if you want to
            -- keep the highlight groups in sync with the icons.
            highlight = function(ctx)
              local hl = ctx.kind_hl
              if vim.tbl_contains({"Path"}, ctx.source_name) then
                local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then
                  hl = dev_hl
                end
              end
              return hl
            end
          }
        }
      }
    },
    ghost_text = {enabled = true, show_with_menu = false},
    keyword = {range = "full"},
    trigger = {show_on_trigger_character = true},
    list = {selection = {preselect = true, auto_insert = true}}
  },
  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = {"lazydev", "lsp", "path", "supermaven", "snippets", "buffer", "ripgrep"},
    per_filetype = {
      sql = {"snippets", "dadbod", "buffer"}
    },
    providers = {
      dadbod = {name = "Dadbod", module = "vim_dadbod_completion.blink"},
      ripgrep = {
        module = "blink-ripgrep",
        name = "Ripgrep",
        -- the options below are optional, some default values are shown
        ---@module "blink-ripgrep"
        ---@type blink-ripgrep.Options
        opts = {
          -- For many options, see `rg --help` for an exact description of
          -- the values that ripgrep expects.

          -- the minimum length of the current word to start searching
          -- (if the word is shorter than this, the search will not start)
          prefix_min_len = 3,
          -- The number of lines to show around each match in the preview
          -- (documentation) window. For example, 5 means to show 5 lines
          -- before, then the match, and another 5 lines after the match.
          context_size = 5,
          -- The maximum file size of a file that ripgrep should include in
          -- its search. Useful when your project contains large files that
          -- might cause performance issues.
          -- Examples:
          -- "1024" (bytes by default), "200K", "1M", "1G", which will
          -- exclude files larger than that size.
          max_filesize = "1M",
          -- Specifies how to find the root of the project where the ripgrep
          -- search will start from. Accepts the same options as the marker
          -- given to `:h vim.fs.root()` which offers many possibilities for
          -- configuration. If none can be found, defaults to Neovim's cwd.
          --
          -- Examples:
          -- - ".git" (default)
          -- - { ".git", "package.json", ".root" }
          project_root_marker = ".git",
          -- Enable fallback to neovim cwd if project_root_marker is not
          -- found. Default: `true`, which means to use the cwd.
          project_root_fallback = true,
          -- The casing to use for the search in a format that ripgrep
          -- accepts. Defaults to "--ignore-case". See `rg --help` for all the
          -- available options ripgrep supports, but you can try
          -- "--case-sensitive" or "--smart-case".
          search_casing = "--ignore-case",
          -- (advanced) Any additional options you want to give to ripgrep.
          -- See `rg -h` for a list of all available options. Might be
          -- helpful in adjusting performance in specific situations.
          -- If you have an idea for a default, please open an issue!
          --
          -- Not everything will work (obviously).
          additional_rg_options = {},
          -- When a result is found for a file whose filetype does not have a
          -- treesitter parser installed, fall back to regex based highlighting
          -- that is bundled in Neovim.
          fallback_to_regex_highlighting = true,
          -- Absolute root paths where the rg command will not be executed.
          -- Usually you want to exclude paths using gitignore files or
          -- ripgrep specific ignore files, but this can be used to only
          -- ignore the paths in blink-ripgrep.nvim, maintaining the ability
          -- to use ripgrep for those paths on the command line. If you need
          -- to find out where the searches are executed, enable `debug` and
          -- look at `:messages`.
          ignore_paths = {},
          -- Any additional paths to search in, in addition to the project
          -- root. This can be useful if you want to include dictionary files
          -- (/usr/share/dict/words), framework documentation, or any other
          -- reference material that is not available within the project
          -- root.
          additional_paths = {},
          -- Keymaps to toggle features on/off. This can be used to alter
          -- the behavior of the plugin without restarting Neovim. Nothing
          -- is enabled by default. Requires folke/snacks.nvim.
          toggles = {
            -- The keymap to toggle the plugin on and off from blink
            -- completion results. Example: "<leader>tg"
            on_off = nil
          },
          -- Features that are not yet stable and might change in the future.
          -- You can enable these to try them out beforehand, but be aware
          -- that they might change. Nothing is enabled by default.
          future_features = {
            backend = {
              -- The backend to use for searching. Defaults to "ripgrep".
              -- Available options:
              -- - "ripgrep", always use ripgrep
              -- - "gitgrep", always use git grep
              -- - "gitgrep-or-ripgrep", use git grep if possible, otherwise
              --   ripgrep
              use = "ripgrep"
            }
          },
          -- Show debug information in `:messages` that can help in
          -- diagnosing issues with the plugin.
          debug = false
        }
      },
      supermaven = {
        name = "supermaven",
        module = "blink-cmp-supermaven",
        async = true
      },
      lazydev = {
        name = "lazydev",
        module = "lazydev.integrations.blink"
      }
    }
  },
  -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
  -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
  -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
  --
  -- See the fuzzy documentation for more information
  fuzzy = {implementation = "prefer_rust_with_warning"}
}
