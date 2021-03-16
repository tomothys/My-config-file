let g:floaterm_title = " Terminal "
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:floaterm_borderchars = "─│─│╭╮╯╰"
let g:floaterm_autoclose = 1

function! Open_lazygit()
    let g:floaterm_title = " LazyGit "
    execute "FloatermNew lazygit"
endfunction

function! Toggle_terminal()
    let g:floaterm_title = " Terminal "
    execute "FloatermToggle"
endfunction

let g:which_key_map.t = { 'name': '+Terminal' }
let g:which_key_map.t.t = 'Open Terminal'
nnoremap <silent> <Leader>tt :call Toggle_terminal()<CR>
tnoremap <silent> <Leader>tt <C-\><C-n>:FloatermToggle<CR>


let g:which_key_map.g = { 'name': '+Git' }
let g:which_key_map.g.g = 'Lazygit'
nnoremap <silent> <Leader>gg :call Open_lazygit()<CR>
