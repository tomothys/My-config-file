let g:which_key_centered = 0

" Define prefix dictionary
let g:which_key_map = { 'name': 'Leader key' }

call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <Leader> :WhichKey '<Space>'<CR>

" Window close/split
let g:which_key_map.w = { 'name': '+Window' }
let g:which_key_map.w.k = 'Close/Kill'
nnoremap <silent> <Leader>w :q
let g:which_key_map.w.s = 'Split horizontally'
nnoremap <silent> <Leader>ws :sp
let g:which_key_map.w.s = 'Split vertically'
nnoremap <silent> <Leader>wv :vsp

let g:which_key_map.h = 'Remove search highlight'
nnoremap <silent> <Leader>h :nohl<CR>
