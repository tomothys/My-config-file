let mapleader = ' '

" Exit insert mode
inoremap jk <ESC>

" Map 'cut' to 'x' so I can use 'd' to delete w/o polluting a register
nnoremap x d
nnoremap X D
vnoremap x d

" Don't touch the any register while deleting stuff
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

nnoremap c "_c
nnoremap C "_C
vnoremap c "_c

" I need a shortcut to revive my syntax-highlighting. Sad but true.
" Remap Ctrl+l because I'm using Ctrl+l to switch windows
nnoremap <S-l> <C-l>

" Make moving between windows/panes smoother
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Make window resizing smoother
nnoremap <silent> <S-Down> :resize +2<CR>
nnoremap <silent> <S-Up> :resize -2<CR>
nnoremap <silent> <S-Left> :vertical resize +2<CR>
nnoremap <silent> <S-Right> :vertical resize -2<CR>

" Move line up and down
inoremap <silent> <M-k> <C-O>:move -2<CR>
inoremap <silent> <M-j> <C-O>:move +1<CR>
nnoremap <silent> <M-k> :move -2<CR>
nnoremap <silent> <M-j> :move +1<CR>
xnoremap <silent> <M-k> :move '<-2<CR>gv-gv
xnoremap <silent> <M-j> :move '>+1<CR>gv-gv

" Unindent line in insert-mode
inoremap <S-Tab> <C-O><<<C-O>^

" Terminal window navigation
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

" Leave terminal-insert-mode with Ctrl-t instead Esc
tnoremap <C-e> <C-\><C-N>
" Map Esc to just Esc because it's needed for CLI-Tools like lazygit
tnoremap <Esc> <Esc>

" Reselect after indentation in visual mode
vnoremap > >gv
vnoremap < <gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Always leave visual mode on first 'v' instead of double tapping 'v' for visual line
vnoremap v <Esc>

" Toggle between absolute line numbers and relative line numbers
nnoremap + :set rnu!<CR>
vnoremap + <Esc>:set rnu!<CR>gv

" Remap search and backward search
nnoremap s /
nnoremap S ?

" Map o to <CR> only in quick-fix lists
nnoremap <expr> o &buftype ==# 'quickfix' ? '\<CR>' : 'o'
nnoremap <CR> :

" Remap Enter in command-mode to remove search-highlighting
cnoremap <silent> <CR> <CR>:nohl<CR>

" Write Quotes, Braces, Parentheses and Curlybraces with shortcuts
" 

" Add to space when cursor is between Parentheses, Curlybraces or Brackets
inoremap <expr> <Space> g:IsCursorWrappedBy("()", "{}", "[]") ? "<Space><Space><Left>" : '<Space>'

" Remove whole pair
inoremap <expr> <BS> g:IsCursorWrappedBy("  ", "{}", "()", "[]", "''", '""', "<>") ? "<Left><DEL><DEL>" : "<BS>"

" Map Ctrl+j, Ctrl+l, Ctrl+k, Ctrl+h to arrow-keys in insert mode
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-h> <Left>

inoremap <C-u> <C-R>=g:ConfirmSurroundings()<CR><Left>

nnoremap gul gu
nnoremap guu gU
