let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0

let g:gitgutter_sign_allow_clobber = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '契'
let g:gitgutter_sign_removed_first_line = '契'
let g:gitgutter_sign_modified_removed = '▎'
let g:gitgutter_preview_win_floating = 1

highlight GitGutterAdd guifg=#587C0C ctermfg=2
highlight GitGutterChange guifg=#FABD2F ctermfg=3
highlight GitGutterDelete guifg=#F04123 ctermfg=1

" 'g' (for git) which-key-group already exists in Floaterm.vim
let g:which_key_map.g.t = 'Enable/Disable GitGutter'
nmap <Leader>gt <Plug>(GitGutterToggle)

let g:which_key_map.g.h = { 'name': '+Hunk' }

let g:which_key_map.g.h.s = 'Show Hunk'
nmap <Leader>ghh <Plug>(GitGutterPreviewHunk)

let g:which_key_map.g.h.n = 'Jump to next Hunk'
nmap <Leader>ghn <Plug>(GitGutterNextHunk)

let g:which_key_map.g.h.p = 'Jump to previous Hunk'
nmap <Leader>ghp <Plug>(GitGutterPrevHunk)

let g:which_key_map.g.h.u = 'Undo Hunk'
nmap <Leader>ghu <Plug>(GitGutterUndoHunk)

let g:which_key_map.g.h.s = 'Stage Hunk'
nmap <Leader>ghs <Plug>(GitGutterStageHunk)
