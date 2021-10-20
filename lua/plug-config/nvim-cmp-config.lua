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
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      --["<CR>"] = cmp.mapping.confirm({select = true}), removed because of autopairs
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
      {name = "luasnip"},
      {name = "buffer"},
      {name = "path"},
      {
        name = "cmp_tabnine"
        --opts = {}
      },
      {name = "spell"},
      {name = "latex_symbols"},
      {name = "emoji"}
    },
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

vim.opt.spell = true
vim.opt.spelllang = {"en_us"}
