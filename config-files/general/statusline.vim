" Seperator:    
" Seperator:    

let g:StatusLineSeperatorLeft=''
let g:StatusLineSeperatorRight=''

function g:GetCurrentBranch()
    return system('git branch --show-current 2>/dev/null | tr -d "\n"')
endfunction

function g:StatusLine(isCurrentBuffer = v:false)
    if a:isCurrentBuffer
        " LEFT SIDE [BEGIN]
        " Add left seperator
        setl statusline=%#StatusLineTransparent#\ %#StatusLineColorOneSeperatorTransparentBg#%{StatusLineSeperatorLeft}
        " Add emote
        setl statusline+=%#StatusLineColorOne#\ 👺\ 
        " Add right seperator
        setl statusline+=%#StatusLineColorOneSeperator#%{StatusLineSeperatorRight}
        " Add right sub seperator
        setl statusline+=%#StatusLineSubSeperator#%{StatusLineSeperatorRight}%#StatusLine#\ 

        " Add file path head if it's not NvimTree/FileTree
        if expand('%t') != 'NvimTree'
            setl statusline+=%#StatusLineFilePathHead#%.25{expand('%:h')}/
        endif

        " Add file name
        setl statusline+=%#StatusLine#%t

        if expand('%t') != 'NvimTree'
            " Is file modified
            setl statusline+=\ %m
        endif
        " LEFT SIDE [END]

        " RIGHT SIDE [BEGIN]
        " Switch to right side
        setl statusline+=%=
        " Add left sub seperator
        setl statusline+=%#StatusLineSubSeperator#%{StatusLineSeperatorLeft}
        " Add left seperator
        setl statusline+=%#StatusLineColorOneSeperator#%{StatusLineSeperatorLeft}
        " Add current Git-Branch
        setl statusline+=%#StatusLineColorOne#\ %{GetCurrentBranch()}\ 
        " Add right seperator
        setl statusline+=%#StatusLineColorOneSeperatorTransparentBg#%{StatusLineSeperatorRight}%#StatusLineTransparent#\ 
        " RIGHT SIDE [END]
    else
        " LEFT SIDE [BEGIN]
        " Add left seperator
        setl statusline=%#StatusLineTransparent#\ %#StatusLineColorTwoSeperatorTransparantBg#%{StatusLineSeperatorLeft}
        " Add emote
        setl statusline+=%#StatusLineColorTwo#\ 👾\ 
        " Add right seperator
        setl statusline+=%#StatusLineColorTwoSeperator#%{StatusLineSeperatorRight}\ 
        " Add file name
        setl statusline+=%#StatusLineNC#%t
        " LEFT SIDE [END]

        " RIGHT SIDE [BEGIN]
        " Switch to rightside
        setl statusline+=%=
        " Add right seperator
        setl statusline+=%#StatusLineNCEnd#%{StatusLineSeperatorRight}\ 
        " RIGHT SIDE [END]

    endif
endfunction

autocmd WinEnter * call g:StatusLine(v:true)
autocmd WinLeave * call g:StatusLine()
autocmd FileType * call g:StatusLine(v:true)
