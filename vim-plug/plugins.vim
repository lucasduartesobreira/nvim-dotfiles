call plug#begin(stdpath('data'))

"Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
"Plug 'Raimondi/delimitMate'
"Plug 'vim-airline/vim-airline'
Plug 'vim-syntastic/syntastic'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'rafi/awesome-vim-colorschemes'
Plug 'preservim/nerdcommenter'
"Plug 'airblade/vim-gitgutter'
"Plug 'ryanoasis/vim-devicons'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'gotchane/vim-git-commit-prefix'
Plug 'tpope/vim-repeat'

" BufferLine
Plug 'akinsho/nvim-bufferline.lua'

" GitHub Theme
Plug 'projekt0n/github-nvim-theme'

" Lualine
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'


" Format
Plug 'mhartington/formatter.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'

" Compe
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/cmp-emoji'
Plug 'kdheepak/cmp-latex-symbols'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-path'
Plug 'f3fora/cmp-spell'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

"TreeSitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'p00f/nvim-ts-rainbow'
Plug 'lewis6991/spellsitter.nvim'
Plug 'nvim-treesitter/playground'
Plug 'windwp/nvim-ts-autotag'
Plug 'RRethy/nvim-treesitter-textsubjects'
Plug 'RRethy/nvim-treesitter-textobjects'

"Go
"Plug 'fatih/vim-go'

"Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

"Rust
"Plug 'rust-lang/rust.vim'

"Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'

" GitSigns
Plug 'lewis6991/gitsigns.nvim'

" Discord Rich Presence
Plug 'andweeb/presence.nvim'

" LazyGit
Plug 'kdheepak/lazygit.nvim'

" Autopairs
Plug 'windwp/nvim-autopairs'

" DAP
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'

" Tmux
Plug 'aserowy/tmux.nvim'

" LSP ROOTER
Plug 'ahmedkhalf/lsp-rooter.nvim'

" Colorizer
Plug 'norcalli/nvim-colorizer.lua'

" Todo comments
Plug 'folke/todo-comments.nvim'

" WakaTime
Plug 'wakatime/vim-wakatime'

call plug#end()
