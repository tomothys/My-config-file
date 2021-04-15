let mapleader = ' '

" Settings
set iskeyword+=-
set whichwrap+=<,>,[,],h,l
set noshowmode
set scrolloff=3
set ignorecase

" Keybindings
" Map 'cut' to 'x' so I can use 'd' to delete w/o polluting a register
nnoremap x "+d
nnoremap X "+D
vnoremap x "+d

" Copy/yank to clipboard-register by default
nnoremap y "+y
nnoremap Y "+Y
vnoremap y "+y

" Paste from clipboard-register by default
nnoremap p "+p
nnoremap P "+P
vnoremap p "+p

" Don't touch the any register while deleting stuff
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

nnoremap c "_c
nnoremap C "_C
vnoremap c "_c

" Make moving between windows/panes smoother
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Always leave visual mode on first 'v' instead of double tapping 'v' for visual line
vnoremap v <Esc>

" Remove search-highlight
nnoremap <silent> <Leader>h :nohl<CR>

" Reselect after indentation in visual mode
vnoremap > >gv
vnoremap < <gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Toggle line comment
xmap gc <Plug>VSCodeCommentary
nmap gc <Plug>VSCodeCommentary
omap gc <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" Navigation Tabs
nnoremap <Tab> <cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>
nnoremap <S-Tab> <cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>

" Enter command mode on enter
nnoremap <CR> :

" Remap search and reverse-search
nnoremap s /
nnoremap S ?

" Remove highlight on search end
cnoremap <CR> <CR>:nohl<CR>
