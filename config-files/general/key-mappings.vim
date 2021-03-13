let mapleader = ' '
nnoremap <Space> <Nop>

" Exit insert mode
inoremap jk <ESC>

" Save and close files faster/easier
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q!<CR>

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

" Don't touch the any register while deleting stuff
nnoremap d "_d
nnoremap D "_D

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

" Remove highlighting after '/'-search
nnoremap <silent> <Leader>h :nohl<CR>

" Move text up and down in visual mode
xnoremap <silent> K :move '<-2<CR>gv-gv
xnoremap <silent> J :move '>+1<CR>gv-gv

" tab completion
inoremap <expr> <TAB> pumvisible() ? '<C-n>' : '<TAB>'

" Terminal window navigation
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
tnoremap <Esc> <C-\><C-n>

" Reselect after indentation in visual mode
vnoremap > >gv
vnoremap < <gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Always leave visual mode on first 'v' instead of double tapping 'v' for visual line
vnoremap v <Esc>

" Unmap Esc because it's needed for CLI-Tools like lazygit
tnoremap <Esc> <Nop>
" Leave terminal-insert-mode with Ctrl-t instead Esc
tnoremap <C-t> <C-\><C-N>
