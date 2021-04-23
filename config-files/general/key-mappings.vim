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
inoremap <silent> <C-k> <C-O>:move -2<CR>
inoremap <silent> <C-j> <C-O>:move +1<CR>
nnoremap <silent> <C-k> :move -2<CR>
nnoremap <silent> <C-j> :move +1<CR>
xnoremap <silent> <C-k> :move '<-2<CR>gv-gv
xnoremap <silent> <C-j> :move '>+1<CR>gv-gv

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
nnoremap S :s/
vnoremap s :s/

" Repeat last edit on searched item (with count)
nnoremap Q @='n.'<CR>

" Map o to <CR> only in quick-fix lists
nnoremap <expr> o &buftype ==# 'quickfix' ? '\<CR>' : 'o'
nnoremap <CR> :
" Write Quotes, Braces, Parentheses and Curlybraces with shortcuts
" 
nnoremap <M-x> :

" Remap motions to clear search highlighting too
nnoremap <silent> j j:nohl<CR>
nnoremap <silent> k k:nohl<CR>
nnoremap <silent> l l:nohl<CR>
nnoremap <silent> h h:nohl<CR>
nnoremap <silent> w w:nohl<CR>
nnoremap <silent> e e:nohl<CR>
nnoremap <silent> b b:nohl<CR>
nnoremap <silent> i :nohl<CR>i
nnoremap <silent> a :nohl<CR>a

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

" To uppercase mapping which doesn't need the the shift-button
nnoremap guu gU
vnoremap guu gU
