local is_cmp_ok, cmp = pcall(require, "blink.cmp")
if not is_cmp_ok then
  return
end

cmp.setup {
  keymap = {
    preset = "enter",
    ["<C-space>"] = {"show", "show_documentation", "hide_documentation"},
    ["<C-y>"] = {"hide", "fallback"},
    ["<CR>"] = {"accept", "fallback"},
    ["<C-m>"] = {"accept", "fallback"},
    ["<Tab>"] = {"snippet_forward", "fallback"},
    ["<S-Tab>"] = {"snippet_backward", "fallback"},
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
  accept = {auto_brackets = {enabled = true}},
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
        columns = {{"label", "label_description", gap = 1}, {"kind_icon", "kind"}},
        components = {
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
    default = {"lsp", "path", "supermaven", "snippets", "buffer"},
    per_filetype = {
      sql = {"snippets", "dadbod", "buffer"}
    },
    providers = {
      dadbod = {name = "Dadbod", module = "vim_dadbod_completion.blink"},
      supermaven = {
        name = "supermaven",
        module = "blink-cmp-supermaven",
        async = true
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
