local status_cmp_ok, cmp = pcall(require, "cmp")
if not status_cmp_ok then
  return
end

local status_luasnip_ok, luasnip = pcall(require, "luasnip")
if not status_luasnip_ok then
  return
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local status_tabnine_ok, tabnine = pcall(require, "cmp_tabnine.config")
if not status_tabnine_ok then
  return
end

tabnine:setup(
  {
    max_lines = 750,
    max_num_results = 10,
    sort = true,
    run_on_every_keystroke = true,
    ignored_file_types = {},
    show_prediction_strength = false
  }
)

cmp.setup(
  {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert(
      {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-y>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({select = true}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end,
          {"i", "s"}
        ),
        ["<S-Tab>"] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
          {"i", "s"}
        )
      }
    ),
    enabled = function()
      return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
    end,
    sources = cmp.config.sources(
      {
        {name = "nvim_lsp"},
        {name = "luasnip", max_item_count = 3},
        {name = "cmp_tabnine", max_item_count = 3},
        {name = "nvim_lsp_signature_help"}
      },
      {
        {name = "dap"},
        {name = "buffer", max_item_count = 2},
        {name = "path", max_item_count = 4},
        {name = "spell", max_item_count = 2}
      },
      {
        {name = "emoji", max_item_count = 4},
        {name = "latex_symbols", max_item_count = 4}
      }
    ),
    formatting = {
      format = require("lspkind").cmp_format(
        {
          with_text = true,
          menu = ({
            buffer = "[Buffer]",
            path = "[Path]",
            spell = "[Spell]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[Latex]",
            cmp_tabnine = "[TabNine]",
            emoji = "[Emoji]"
          })
        }
      )
    }
  }
)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  "/",
  {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      {name = "buffer"}
    }
  }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  ":",
  {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      {
        {name = "path"}
      },
      {
        {name = "cmdline"}
      }
    )
  }
)

-- If you want insert `(` after select function or method item
local is_cmp_autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not is_cmp_autopairs_ok then
  return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({map_char = {tex = ""}}))
