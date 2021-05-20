" #region Functions
function s:getColor(groupname, attr)
    return synIDattr(synIDtrans(hlID(a:groupname)), a:attr)
endfunction
" #endregion

" #region Colors
let s:background = "#0f111a"
let s:black = "#546e7a"
let s:blue = "#88aaff"
let s:darkBlue = "#12181f"
let s:red = "#ff5370"
let s:yellow = "#ffcb6b"
let s:green = "#c3e88d"
" #endregion

" Set colorscheme
color nvcode

" Change background
execute 'highlight Normal guibg=' . s:background
" execute 'highlight CursorLine guibg=' . s:blue
execute 'highlight SignColumn guibg=' . s:getColor("Normal", "bg")

" Overwrites FLoatterm/-Border background- and border-color
highlight Floaterm guibg=#1e1e1e
highlight FloatermBorder guibg=#1e1e1e guifg=#569cd6

" Overwrite Search highlighting.
execute 'hi Search guibg=' . s:blue . ' guifg=' . s:background

" Overwrite Diff colors. I want the sign to be in color.
highlight DiffAdd guifg=#608b4e guibg=NONE gui=bold
highlight DiffChange guifg=#dcdcaa guibg=NONE gui=bold
highlight DiffDelete guifg=#f04123 guibg=NONE gui=bold

" Overwrite Error GUI and remove 'reverse'
highlight Error guifg=#f04123 gui=bold,underline

" Bufferline Highlights
execute 'hi BufferTabpageFill guibg=' . s:background
execute 'hi BufferCurrent guibg=' . s:red . ' guifg=' . s:getColor("BufferTabpageFill", "bg")
execute 'hi BufferCurrentIcon guibg=' . s:red . ' guifg=' . s:green
execute 'hi BufferCurrentMod guibg=' . s:getColor("BufferCurrent", "bg") . ' guifg=white'
hi link BufferCurrentIndex BufferCurrent
hi link BufferCurrentTarget BufferCurrent
execute 'hi BufferCurrentSign guibg=' . s:getColor("BufferCurrent", "bg") . ' guifg=' . s:getColor("BufferCurrent", "bg")
execute 'hi BufferInactive guibg=' . s:background
hi link BufferInactiveIcon BufferInactive
hi clear BufferInactiveMod
hi link BufferInactiveMod BufferInactive
hi link BufferInactiveIndex BufferInactive
hi link BufferInactiveTarget BufferInactive
execute 'hi BufferInactiveSign guibg=' . s:getColor("BufferInactive", "bg") . ' guifg=' . s:getColor("BufferInactive", "bg")

" Custom StatusLine highlights
execute 'hi StatusLineNC guibg=' . s:getColor("StatusLine", "bg")
execute 'hi StatusLineFilePathHead guibg=' . s:getColor("StatusLine", "bg") . ' guifg=' . s:getColor("StatusLineNC", "fg")
execute 'hi StatusLineBgColorOne guibg=' . s:red . ' guifg=' . s:getColor("Normal", "bg")
execute 'hi StatusLineFgColorOne guifg=' . s:red . ' guibg=' . s:getColor("StatusLine", "bg")
execute 'hi StatusLineBgColorTwo guibg=' . s:getColor("StatusLineNC", "fg")
execute 'hi StatusLineFgColorTwo guifg=' . s:getColor("StatusLineNc", "fg") . ' guibg=' . s:getColor("StatusLine", "bg")

" Remove bg for GitGutter symbols
highlight GitGutterAdd guibg=NONE
highlight GitGutterChange guibg=NONE
highlight GitGutterDelete guibg=NONE
