let g:which_key_centered = 0

" Define prefix dictionary
let g:which_key_map = { 'name': 'Leader key' }

call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <Leader> :WhichKey '<Space>'<CR>

" Save and close files faster/easier
let g:which_key_map.w = 'Save file'
nnoremap <Leader>w :w<CR>
let g:which_key_map.q = 'Quit window'
nnoremap <silent> <Leader>q :q!<CR>

let g:which_key_map.h = 'Remove search highlight'
nnoremap <silent> <Leader>h :nohl<CR>
