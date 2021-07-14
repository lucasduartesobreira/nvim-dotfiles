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
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-rooter'
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
Plug 'hrsh7th/nvim-compe'
Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

"TreeSitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'p00f/nvim-ts-rainbow'
Plug 'lewis6991/spellsitter.nvim'
Plug 'nvim-treesitter/playground'

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

call plug#end()
