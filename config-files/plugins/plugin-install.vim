" Autoinstall vim-plug if not installed and run PlugInstall afterwards
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

    " List of Plugins
    Plug 'b3nj5m1n/kommentary'
    Plug 'tpope/vim-surround'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
    Plug 'p00f/nvim-ts-rainbow' " Rainbow parentheses
    Plug 'kyazdani42/nvim-web-devicons' " Nice looking icons
    Plug 'ryanoasis/vim-devicons' " Nice looking icons
    Plug 'liuchengxu/vim-which-key'
    Plug 'kyazdani42/nvim-tree.lua' " File Explorer
    Plug 'sheerun/vim-polyglot' " Better Syntax Support
    Plug 'airblade/vim-gitgutter'
    Plug 'rhysd/git-messenger.vim' " Open commits + messages in popup window
    Plug 'AndrewRadev/tagalong.vim' " Change closing html-tag when opening tag changed
    Plug 'alvan/vim-closetag' " Auto close html-tags
    Plug 'ChristianChiarulli/nvcode-color-schemes.vim' " Nice colorschemes
    Plug 'voldikss/vim-floaterm'
    Plug 'airblade/vim-rooter'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'jremmen/vim-ripgrep'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
    Plug 'junegunn/fzf.vim'
    Plug 'gfanto/fzf-lsp.nvim' " Use fzf to search for symbols
    Plug 'romgrk/barbar.nvim'
    Plug 'prettier/vim-prettier', { 'do': 'npm install' }

    " Intellisense
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe' " Auto-completion
    Plug 'glepnir/lspsaga.nvim'
    Plug 'onsails/lspkind-nvim' " Adds pictograms to auto-completion pop-ups
    Plug 'kabouzeid/nvim-lspinstall'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
