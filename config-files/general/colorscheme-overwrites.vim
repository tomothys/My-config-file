" #region Functions
function s:getColor(groupname, attr)
    return synIDattr(synIDtrans(hlID(a:groupname)), a:attr)
endfunction
" #endregion

" #region Colors
let s:black = "#546e7a"
let s:blue = "#88aaff"
let s:darkBlue = "#12181f"
" #endregion

" Set colorscheme
color nvcode

" Overwrites FLoatterm/-Border background- and border-color
highlight Floaterm guibg=#1e1e1e
highlight FloatermBorder guibg=#1e1e1e guifg=#569cd6

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
execute 'hi StatusLineNC guibg=' . s:getColor("StatusLine", "bg")
execute 'hi StatusLineFilePathHead guibg=' . s:getColor("StatusLine", "bg") . ' guifg=' . s:getColor("StatusLineNC", "fg")
execute 'hi StatusLineBgColorOne guibg=' . s:blue . ' guifg=black'
execute 'hi StatusLineFgColorOne guifg=' . s:blue . ' guibg=' s:getColor("StatusLine", "bg")
execute 'hi StatusLineBgColorTwo guibg=' . s:getColor("StatusLineNC", "fg")
execute 'hi StatusLineFgColorTwo guifg=' . s:getColor("StatusLineNc", "fg") . ' guibg=' s:getColor("StatusLine", "bg")

" Change background
execute 'highlight Normal guibg=' . s:darkBlue
" execute 'highlight CursorLine guibg=' . s:blue
execute 'highlight SignColumn guibg=' . s:darkBlue

" Remove bg for GitGutter symbols
highlight GitGutterAdd guibg=NONE
highlight GitGutterChange guibg=NONE
highlight GitGutterDelete guibg=NONE
