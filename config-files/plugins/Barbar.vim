" Make moving between buffers easier
nnoremap <silent> <Tab> :BufferNext<CR>
nnoremap <silent> <S-Tab> :BufferPrevious<CR>

" Close buffers
nnoremap <silent> <Leader>bd :BufferClose<CR>
nnoremap <silent> <Leader>ba :BufferCloseAllButCurrent<CR>

" Jump to buffer
nnoremap <silent> <Leader>bb :BufferPick<CR>

" Sort buffers
nnoremap <silent> <Leader>bol :BufferOrderByLanguage<CR>
nnoremap <silent> <Leader>bod :BufferOrderByDirectory<CR>
nnoremap <silent> <Leader>bmn :BufferMoveNext<CR>
nnoremap <silent> <Leader>bmp :BufferMovePrevious<CR>
