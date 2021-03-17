let g:signify_sign_add = '▊'
let g:signify_sign_delete = '契'
let g:signify_sign_delete_first_line = '契'
let g:signify_sign_change = '▊'
let g:signify_sign_change_delete = g:signify_sign_change . g:signify_sign_delete_first_line

let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1

" Functions [BEGIN]
let s:are_git_signs_enabled = 1
function! Toggle_git_signs()
    exe "SignifyToggle"

    if s:are_git_signs_enabled
        echo 'Git Signs disabled'
    else
        echo 'Git Signs enabled'
    endif

    let s:are_git_signs_enabled = !s:are_git_signs_enabled
endfunction
" Functions [END]

" 'g' (for git) which-key-group already exists in Floaterm.vim
let g:which_key_map.g.t = 'Enable/Disable Git Signs'
nnoremap <silent> <Leader>gt :call Toggle_git_signs()<CR>

let g:which_key_map.g.h = { 'name': '+Hunk' }

let g:which_key_map.g.h.s = 'Show Hunk Diff'
nnoremap <silent> <Leader>ghh :SignifyHunkDiff<CR>

let g:which_key_map.g.h.s = 'Show Diff'
nnoremap <silent> <Leader>ghd :SignifyDiff<CR>

let g:which_key_map.g.h.n = 'Jump to next Hunk'
nmap <Leader>ghn <Plug>(signify-next-hunk)

let g:which_key_map.g.h.p = 'Jump to previous Hunk'
nmap <Leader>ghp <Plug>(signify-prev-hunk)

let g:which_key_map.g.h.u = 'Undo Hunk'
nnoremap <silent> <Leader>ghu :SignifyHunkUndo<CR>
