local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require "cmp"

cmp.setup(
  {
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end
    },
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
      ["<C-p>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
      ["<C-y>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({select = true}),
      ["<Tab>"] = cmp.mapping(
        function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
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
    },
    sources = {
      {name = "nvim_lsp"},
      {
        name = "luasnip",
        max_item_count = 4
      },
      {
        name = "buffer",
        max_item_count = 4
      },
      {name = "path"},
      {
        name = "cmp_tabnine",
        max_item_count = 10
      },
      {
        name = "spell",
        max_item_count = 5
      },
      {
        name = "latex_symbols",
        max_item_count = 10
      },
      {
        name = "emoji",
        max_item_count = 4
      }
    },
    formatting = {
      format = require("lspkind").cmp_format(
        {
          with_text = true,
          menu = ({
            buffer = "[Buffer]",
            path = "[Path]",
            --spell = "[Spell]",
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

vim.opt.spell = true
vim.opt.spelllang = {"en_us"}
