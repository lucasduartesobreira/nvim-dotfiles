local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end
  }
}

-- Install your plugins here
return packer.startup(
  function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

    -- Basic functionalities
    use "tpope/vim-surround"
    use "preservim/nerdcommenter"
    use "gpanders/editorconfig.nvim"
    use "windwp/nvim-autopairs"
    --use 'gotchane/vim-git-commit-prefix' lazyload at vim commits

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      requires = {
        { "p00f/nvim-ts-rainbow" },
        { "lewis6991/spellsitter.nvim" },
        { "nvim-treesitter/playground" },
        { "windwp/nvim-ts-autotag" },
        { "RRethy/nvim-treesitter-textsubjects" },
        { "RRethy/nvim-treesitter-textobjects" }
      }
    }

    -- TODO: Make LSPCONFIG and everything of lsp just load when a server is setted up
    -- LSP Plugins
    use "neovim/nvim-lspconfig"
    use "lukas-reineke/lsp-format.nvim"

    -- Nvim Compe
    use {
      "hrsh7th/nvim-cmp",
      as = 'cmp',
      requires = {
        { "hrsh7th/cmp-emoji", opt = true },
        { "kdheepak/cmp-latex-symbols", opt = true, ft = "tex" },
        { "onsails/lspkind-nvim" },
        { "hrsh7th/cmp-nvim-lsp", requires = { 'neovim/nvim-lspconfig' } },
        { "hrsh7th/cmp-buffer" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-path" },
        { "f3fora/cmp-spell" },
        { "hrsh7th/cmp-nvim-lsp-signature-help" },
        { "tzachar/cmp-tabnine", run = "./install.sh" }
      }
    }
    -- Theme
    use "EdenEast/nightfox.nvim"

    -- Buffer and status line
    use { "akinsho/nvim-bufferline.lua", requires = { "kyazdani42/nvim-web-devicons" } }
    use { "hoob3rt/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } }


    -- Snippets
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"


    -- Markdown preview
    use { "iamcco/markdown-preview.nvim", run = "cd app && yarn install", cmd = "MarkdownPreview" }

    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "nvim-telescope/telescope-file-browser.nvim" }
      }
    }

    -- Git shit
    use "lewis6991/gitsigns.nvim"
    use "kdheepak/lazygit.nvim"

    -- Test and Debugging
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"
    use "theHamsta/nvim-dap-virtual-text"
    use "vim-test/vim-test"
    use { "rcarriga/vim-ultest", run = ":UpdateRemotePlugins" }

    -- Wakatime
    use "wakatime/vim-wakatime"

    -- Colorizer
    use "norcalli/nvim-colorizer.lua"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end
)
