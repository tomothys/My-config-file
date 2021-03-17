luafile ~/.config/nvim/config-files/plugins/Bufferline.lua

" Make moving between buffers a nicer experience
nnoremap <silent> <Tab> :BufferLineCycleNext<CR>
nnoremap <silent> <S-Tab> :BufferLineCyclePrev<CR>

let g:which_key_map.b = { 'name': '+Buffermenu' }

" Jump to buffer
let g:which_key_map.b.b = 'Jump to buffer'
nnoremap <silent> <Leader>bb :BufferLinePick<CR>

" Close buffers
let g:which_key_map.b.d = 'Close buffer'
nnoremap <silent> <Leader>bd :bd!<CR>
let g:which_key_map.b.a = 'Close all buffer except current'
nnoremap <silent> <Leader>ba :BufferCloseAllButCurrent<CR>

" Sort buffers
let g:which_key_map.b.o = { 'name': '+order' }
let g:which_key_map.b.o.l = 'by language'
nnoremap <silent> <Leader>bol :BufferLineSortByExtension<CR>
let g:which_key_map.b.o.d = 'by directory'
nnoremap <silent> <Leader>bod :BufferLineSortByDirectory<CR>

" Move buffers
let g:which_key_map.b.m = { 'name': '+move' }
let g:which_key_map.b.m.n = 'to next tab position'
nnoremap <silent> <Leader>bmn :BufferLineMoveNext<CR>
let g:which_key_map.b.m.p = 'to previous tab position'
nnoremap <silent> <Leader>bmp :BufferLineMovePrev<CR>
