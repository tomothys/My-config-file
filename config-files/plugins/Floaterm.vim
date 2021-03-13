let g:floaterm_title = " Terminal "
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:floaterm_borderchars = "─│─│╭╮╯╰"

nnoremap <silent> <Leader>tt :FloatermToggle<CR>
tnoremap <silent> <Leader>tt <C-\><C-n>:FloatermToggle<CR>
nnoremap <silent> <Leader>tg :FloatermNew lazygit<CR>
