source $HOME/.config/nvim/general/keybinds.vim
source $HOME/.config/nvim/general/windows.vim
source $HOME/.config/nvim/general/configs.vim
"source $HOME/.config/nvim/plug-config/polyglot.vim
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/plug-config/nerd-commenter.vim
"source $HOME/.config/nvim/themes/airline.vim
"source $HOME/.config/nvim/themes/theme.vim
source $HOME/.config/nvim/plug-config/syntastic.vim
source $HOME/.config/nvim/plug-config/vim-devicons.vim
source $HOME/.config/nvim/plug-config/editorconfig.vim
source $HOME/.config/nvim/custom-snippets/yankandpaste.vim
source $HOME/.config/nvim/custom-snippets/basic.vim
"source $HOME/.config/nvim/plug-config/vim-go.vim
source $HOME/.config/nvim/plug-config/markdown-preview.vim
source $HOME/.config/nvim/plug-config/telescope.vim

" Theme
luafile $HOME/.config/nvim/lua/theme/github-theme.lua

"Format
luafile $HOME/.config/nvim/plug-config/formatter.lua

"TreeSitter
luafile $HOME/.config/nvim/plug-config/nvim-treesitter.lua

"LSP
source $HOME/.config/nvim/plug-config/lsp-config.vim
source $HOME/.config/nvim/lsp-servers/setup-all.vim

"Compe
luafile $HOME/.config/nvim/plug-config/compe-config.lua
luafile $HOME/.config/nvim/lua/plug-config/luasnip-config.lua
