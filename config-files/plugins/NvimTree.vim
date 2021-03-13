let g:nvim_tree_auto_close = 1                                      " Close tree when it's the last window
let g:nvim_tree_follow = 1                                          " Follow current buffer
let g:nvim_tree_git_hl = 1                                          " Enable file highlight for git stuff
let g:nvim_tree_width = 40
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]

let g:nvim_tree_icons = {
            \ 'git': {
            \   'unstaged': "柳",
            \   'staged': "✓ ",
            \   'unmerged': " ",
            \   'renamed': "➜ ",
            \   'untracked': " "
            \   },
            \ }

nnoremap <silent> <Leader>e :NvimTreeToggle<CR>
