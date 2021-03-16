" Set colorscheme
color nvcode

" Overwrites FLoattermBorder background- and border-color
hi FloatermBorder guibg=#1E1E1E guifg=#569CD6

" Overwrite Search highlighting.
" I wanna keep it but it's super ugly as it is rn
hi Search guibg=NONE guifg=NONE gui=bold

" Overwrite Diff colors. I want the sign to be in color.
highlight DiffAdd guifg=#608b4e guibg=NONE gui=bold
highlight DiffChange guifg=#dcdcaa guibg=NONE gui=bold
highlight DiffDelete guifg=#f04123 guibg=NONE gui=bold
