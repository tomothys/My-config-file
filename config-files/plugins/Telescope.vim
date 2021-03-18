luafile ~/.config/nvim/config-files/plugins/Telescope.lua

" let g:which_key_map.f = { 'name': '+Find' }
" let g:which_key_map.f.p = 'File finder'
" nnoremap <silent> <Leader>fp :Telescope find_files<CR>

" which_key_map.f declared in Fzf.vim
let g:which_key_map.f.s = 'Find LSP Symbol'
nnoremap <silent> <Leader>fs :Telescope lsp_document_symbols<CR>
