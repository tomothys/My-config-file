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
    Plug 'easymotion/vim-easymotion'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
    Plug 'p00f/nvim-ts-rainbow' " Rainbow parentheses
    Plug 'kyazdani42/nvim-web-devicons' " Nice looking icons
    Plug 'ryanoasis/vim-devicons' " Nice looking icons
    Plug 'jiangmiao/auto-pairs'
    Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
    Plug 'liuchengxu/vim-which-key'
    Plug 'junegunn/goyo.vim' " Zen mode
    "Plug 'mattn/emmet-vim'
    Plug 'romgrk/barbar.nvim' " Nice tabline
    Plug 'psliwka/vim-smoothie' " Smooth scrolling
    Plug 'brooth/far.vim' " Find and replace
    Plug 'kyazdani42/nvim-tree.lua' " File Explorer
    Plug 'sheerun/vim-polyglot' " Better Syntax Support
    Plug 'airblade/vim-gitgutter'
    Plug 'rhysd/git-messenger.vim' " Open commits + messages in popup window
    Plug 'AndrewRadev/tagalong.vim' " Change closing html-tag when opening tag changed
    Plug 'alvan/vim-closetag' " Auto close html-tags
    Plug 'ChristianChiarulli/nvcode-color-schemes.vim' " Nice colorschemes
    Plug 'voldikss/vim-floaterm'
    Plug 'mhinz/vim-startify' " Startscreen
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

    " Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-media-files.nvim'

    " Intellisense
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe' " Auto-completion
    Plug 'glepnir/lspsaga.nvim'
    Plug 'onsails/lspkind-nvim' " Adds pictograms to auto-completion pop-ups
    Plug 'kosayoda/nvim-lightbulb'
    Plug 'mfussenegger/nvim-jdtls'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
