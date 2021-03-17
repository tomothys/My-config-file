syntax enable				        " Enable syntax highlighting
autocmd BufEnter * syntax sync fromstart
set iskeyword+=-			        " Treat dash separated words as a word text object
set formatoptions-=cro			    " Stop newline continution of comments
autocmd FileType * set formatoptions-=cro
set hidden				            " Keep multiple buffers open
set nowrap				            " Don't wrap lines
set whichwrap+=<,>,[,],h,l		    " Allow specified keys to move to the previous/next line
set encoding=utf-8			        " Set displayed encoding
set fileencoding=utf-8			    " The encoding written to file
set cursorline                      " Highlight current line
"set cursorcolumn                    " Highlight current column
set mouse=a				            " Enable mouse
set splitbelow				        " Horizontal splits will open below
set splitright				        " Vertical splits will open on the right
set conceallevel=0			        " To make `` visible in markdown files
set tabstop=4				        " 1 tab = 4 spaces
set shiftwidth=0			        " If zero if falls back to tabstop
set expandtab				        " Converts tabs to spaces
set autoindent                      " Enable auto indentation
set smartindent                     " Claims to indent smart
set laststatus=2                    " Always display status line
set showtabline=2                   " Show tabs
set noshowmode                      " Hide mode in statusline
set number                          " Display line numbers
set background=dark                 " Set background-color to dark
set t_Co=256				        " Enable 256 color support
set termguicolors
set nobackup                        " Disable backup files
set nowritebackup                   " Disable backup files
set shortmess+=c                    " Don't pass messages to |ins-completion-menu|
set signcolumn=yes                  " Show signcolumn
set timeoutlen=300                  " Time in milliseconds to wait for a mapped sequence to complete.
set scrolloff=3                     " Number of lines to keep on edge of editor
set foldmethod=indent               " Well.. as keyword states: Set foldmethod
set foldlevel=100                   " Keep all folds open at first
set completeopt=menuone,noselect    " Compe said to do so.. 👀

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END
