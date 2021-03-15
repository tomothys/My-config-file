luafile ~/.config/nvim/config-files/plugins/LspSaga.lua

" Scroll in those pop-ups
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" Definition and references
nnoremap <silent> <Leader>lf :Lspsaga lsp_finder<CR>

" Code action
nnoremap <silent> <Leader>la :Lspsaga code_action<CR>
vnoremap <silent> <Leader>la :<C-U>Lspsaga range_code_action<CR>

" Hover documentation and signature help
nnoremap <silent> <Leader>lh :Lspsaga hover_doc<CR>

" Signature help
nnoremap <silent> <Leader>ls :Lspsaga signature_help<CR>

" Rename
nnoremap <silent> <Leader>lr :Lspsaga rename<CR>

" Show line diagnostics
nnoremap <silent> <leader>ld :Lspsaga show_line_diagnostics<CR>

" Preview definition
nnoremap <silent> <Leader>lp :Lspsaga preview_definition<CR>
