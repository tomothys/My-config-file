" Make moving between buffers easier
nnoremap <silent> <Tab> :BufferNext<CR>
nnoremap <silent> <S-Tab> :BufferPrevious<CR>

let g:which_key_map.b = { 'name': '+Buffermenu' }

" Close buffers
let g:which_key_map.b.d = 'Close/Kill buffer'
nnoremap <silent> <Leader>bd :BufferClose<CR>
let g:which_key_map.b.k = 'Close/Kill buffer'
nnoremap <silent> <Leader>bk :BufferClose<CR>
let g:which_key_map.b.a = 'Close all buffer except current'
nnoremap <silent> <Leader>ba :BufferCloseAllButCurrent<CR>

" Jump to buffer
let g:which_key_map.b.b = 'Jump to buffer'
nnoremap <silent> <Leader>bb :BufferPick<CR>

" Sort buffers
let g:which_key_map.b.o = { 'name': '+order' }
let g:which_key_map.b.o.l = 'by language'
nnoremap <silent> <Leader>bol :BufferOrderByLanguage<CR>
let g:which_key_map.b.o.d = 'by directory'
nnoremap <silent> <Leader>bod :BufferOrderByDirectory<CR>

let g:which_key_map.b.m = { 'name': '+move' }
let g:which_key_map.b.m.n = 'to next tab position'
nnoremap <silent> <Leader>bmn :BufferMoveNext<CR>
let g:which_key_map.b.m.p = 'to previous tab position'
nnoremap <silent> <Leader>bmp :BufferMovePrevious<CR>

" Save buffer
let g:which_key_map.b.s = 'Save buffer'
nnoremap <silent> <Leader>bs :w<CR>
