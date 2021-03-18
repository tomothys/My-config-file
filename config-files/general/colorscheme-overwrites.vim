" Set colorscheme
color nvcode

" Overwrites FLoattermBorder background- and border-color
highlight FloatermBorder guibg=#1E1E1E guifg=#569CD6

" Overwrite Search highlighting.
" I wanna keep it but it's super ugly as it is rn
highlight Search guibg=NONE guifg=red

" Overwrite Diff colors. I want the sign to be in color.
highlight DiffAdd guifg=#608b4e guibg=NONE gui=bold
highlight DiffChange guifg=#dcdcaa guibg=NONE gui=bold
highlight DiffDelete guifg=#f04123 guibg=NONE gui=bold

" Overwrite Error GUI and remove 'reverse'
highlight Error guifg=#f04123 gui=bold,underline

" Highlights
highlight BufferLineBufferSelected guifg=white
highlight BufferLineModified guifg=#F04123
highlight BufferLineModifiedVisible guifg=#F04123
highlight BufferLineModifiedSelected guifg=#F04123
highlight BufferLineFill guibg=#363535
highlight BufferLineSeperator guibg=#363535
highlight BufferLineSeperatorVisible guibg=#363535
