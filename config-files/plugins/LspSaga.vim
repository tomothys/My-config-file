luafile ~/.config/nvim/config-files/plugins/LspSaga.lua

" Scroll in those pop-ups
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

let g:which_key_map.l = { 'name': '+LSP' }

" Definition and references
let g:which_key_map.l.f = 'Definition and references'
nnoremap <silent> <Leader>lf :Lspsaga lsp_finder<CR>

" Code action
let g:which_key_map.l.a = 'Code action'
nnoremap <silent> <Leader>la :Lspsaga code_action<CR>
vnoremap <silent> <Leader>la :<C-U>Lspsaga range_code_action<CR>

" Hover documentation and signature help
let g:which_key_map.l.h = 'Hover documentation'
nnoremap <silent> <Leader>lh :Lspsaga hover_doc<CR>

" Signature help
let g:which_key_map.l.s = 'Signature help'
nnoremap <silent> <Leader>ls :Lspsaga signature_help<CR>

" Rename
let g:which_key_map.l.r = 'Rename under cursor'
nnoremap <silent> <Leader>lr :Lspsaga rename<CR>

" Show line diagnostics
let g:which_key_map.l.d = 'Line diagnostics'
nnoremap <silent> <leader>ld :Lspsaga show_line_diagnostics<CR>

" Preview definition
let g:which_key_map.l.p = 'Definition preview'
nnoremap <silent> <Leader>lp :Lspsaga preview_definition<CR>
