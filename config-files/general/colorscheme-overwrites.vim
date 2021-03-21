" Functions [BEGIN]
function s:getColor(groupname, attr)
    return synIDattr(synIDtrans(hlID(a:groupname)), a:attr)
endfunction
" Functions [END]

" Set colorscheme
color nvcode

" Overwrites FLoattermBorder background- and border-color
highlight FloatermBorder guibg=#1E1E1E guifg=#569CD6

" Overwrite Search highlighting.
" I wanna keep it but it's super ugly by default
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

" Custom StatusLine highlights
execute 'hi StatusLineTransparent guibg=' . s:getColor("Normal", "bg")
execute 'hi StatusLineFilePathHead guibg=' . s:getColor("StatusLine", "bg") . ' guifg=' . s:getColor("StatusLineNC", "fg")
hi StatusLineColorOne guibg=#f04123 guifg=white
execute 'hi StatusLineSeperatorColorOne guibg=' . s:getColor("StatusLineNC", "fg") . ' guifg=#f04123'
execute 'hi StatusLineColorTwo guibg=' . s:getColor("StatusLineNC", "fg")
execute 'hi StatusLineColorTwoSeperator guifg=' . s:getColor("StatusLineNC", "fg")
execute 'hi StatusLineSubSeperator guibg=' . s:getColor("StatusLine", "bg") . ' guifg=' . s:getColor("StatusLineNC", "fg")
execute 'hi StatusLineSubSeperatorTransparentBg guibg=' . s:getColor("Normal", "bg") . ' guifg=' . s:getColor("StatusLineNC", "fg")
hi StatusLineSeperatorTransparentBg guifg=#f04123
