"------------------
" General settings
"------------------
set ignorecase
set timeoutlen=300
set nobackup
set nowritebackup

"------------------
" Key mappings
"------------------
set mapleader=' '

" Make navigating windows/splits smooth af
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Reselect after indentation in visual mode
vnoremap < <gv
vnoremap > >gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Always leave visual mode on first 'v' instead of double tapping 'v' for visual line
vnoremap v <ESC>

" Search by pressing s. It's a simple substition for plugin like 'Easymotion'.
nnoremap s /

" Tigger command-mode
nnoremap <Leader>c :
vnoremap <Leader>c :

" Remap motions to clear search highlighting
nnoremap <silent> j j:nohl<CR>
nnoremap <silent> k k:nohl<CR>
nnoremap <silent> l l:nohl<CR>
nnoremap <silent> h h:nohl<CR>
nnoremap <silent> w w:nohl<CR>
nnoremap <silent> e e:nohl<CR>
nnoremap <silent> b b:nohl<CR>
nnoremap <silent> i :nohl<CR>i<CR>
nnoremap <silent> a :nohl<CR>a<CR>

" Map Ctrl+j, Ctrl+l, Ctrl-k, Ctrl+h to arrow-keys in insert mode
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-h> <Left>

" Highlight word in document without cursor 'jumping' around
nnoremap # mzyiw0k/<C-R>0<CR>`z

" Shortcut to paste last search-result into commands
cnoremap ## <C-R><C-W>/

" Make writing those pairs and special characters more convenient
inoremap g0 =
inoremap g1 !
inoremap g2 ""<Left>
inoremap g+ ``<Left>
inoremap g4 $
inoremap g5 []<Left>
inoremap g6 &
inoremap g7 /
inoremap g8 ()<Left>
inoremap g9 {}<Left>
inoremap g# ''<Left>
inoremap g< <><Left>
inoremap gß ?

