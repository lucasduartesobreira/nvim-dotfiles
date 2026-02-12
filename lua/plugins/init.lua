return {
  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  -- Basic functionalities
  "tpope/vim-surround",
  "preservim/nerdcommenter",
  "gpanders/editorconfig.nvim",
  "windwp/nvim-autopairs",
  --use 'gotchane/vim-git-commit-prefix' lazyload at vim commits

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    lazy = false,
    dependencies = {
      --{"nvim-treesitter/nvim-treesitter-textobjects", commit = "b00b344c0f5a0a458d6e66eb570cfb347ebf4c38"},
      {"nvim-treesitter/nvim-treesitter-textobjects"},
      {"RRethy/nvim-treesitter-textsubjects"},
      {"nvim-treesitter/playground", lazy = true},
      {"nvim-treesitter/nvim-treesitter-context"}
    }
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup {}
    end
  },
  -- TODO: Make LSPCONFIG and everything of lsp just load when a server is setted up
  -- LSP Plugins
  "neovim/nvim-lspconfig",
  "stevearc/conform.nvim",
  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp"
  },
  "rafamadriz/friendly-snippets",
  -- Theme
  "EdenEast/nightfox.nvim",
  -- Buffer and status line

  -- Markdown preview

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {"nvim-telescope/telescope-fzf-native.nvim", build = "make"},
      {"nvim-telescope/telescope-file-browser.nvim"},
      {"kyazdani42/nvim-web-devicons"},
      {"nvim-telescope/telescope-ui-select.nvim"},
      {"nvim-telescope/telescope-dap.nvim"}
    }
  },
  -- Lines
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {"kyazdani42/nvim-web-devicons"}
  },
  {
    "willothy/nvim-cokeline",
    dependencies = "kyazdani42/nvim-web-devicons" -- If you want devicons
  },
  -- Git shit
  "lewis6991/gitsigns.nvim",
  -- DAP
  {"mfussenegger/nvim-dap"},
  {"rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"}},
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  -- Wakatime
  "wakatime/vim-wakatime",
  -- Neotest
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "rouge8/neotest-rust"
    }
  },
  -- Toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "v2.*",
    opts = {}
  },
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = {"markdown"}
    end,
    ft = {"markdown"}
  },
  {
    "lvimuser/lsp-inlayhints.nvim"
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {}
  },
  {
    "j-hui/fidget.nvim",
    opts = {}
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      {
        "tpope/vim-dadbod",
        lazy = false
        --[[
    [cmd = {
    [  "DBUI",
    [  "DBUIToggle",
    [  "DBUIAddConnection",
    [  "DBUIFindBuffer"
    [}
    ]]
      },
      {"kristijanhusak/vim-dadbod-completion", ft = {"sql", "mysql", "plsql"}, lazy = true} -- Optional
    },
    config = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end
  },
  {
    "pmizio/typescript-tools.nvim",
    enabled = false,
    dependencies = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
  },
  {
    "MagicDuck/grug-far.nvim"
  },
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    dependencies = {"tpope/vim-repeat"}
  },
  {
    "supermaven-inc/supermaven-nvim"
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      {"onsails/lspkind-nvim", commit = "09c4e4d"},
      {"huijiro/blink-cmp-supermaven"},
      {"kyazdani42/nvim-web-devicons"},
      {"mikavilpas/blink-ripgrep.nvim"}
    },
    version = "v1.*"
  },
  {
    "folke/lazydev.nvim",
    opts = {
      library = {
        path = "wezterm-types",
        mods = {"wezterm"}
      }
    },
    dependencies = {
      "DrKJeff16/wezterm-types"
    }
  }
}
