" Seperator:    
" Seperator:    

function g:GetCurrentBranch()
    return system('git branch --show-current 2>/dev/null | tr -d "\n"')
endfunction

function g:StatusLine(isCurrentBuffer = v:false)
    setl statusline=

    if a:isCurrentBuffer
        " LEFT SIDE [BEGIN]
        " Add emote
        setl statusline+=%#StatusLineBgColorOne#\ Nvim\ %#StatusLineFgColorOne#%#StatusLine#\ 

        " Add file path head if it's not NvimTree/FileTree
        if expand('%t') != 'NvimTree'
            setl statusline+=%#StatusLineFilePathHead#%.40{expand('%:h')}/
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
        setl statusline+=%=%#StatusLineFgColorOne#
        " Add current Git-Branch
        setl statusline+=%#StatusLineBgColorOne#\ %{GetCurrentBranch()}\ 
        " RIGHT SIDE [END]
    else
        " LEFT SIDE [BEGIN]
        " Add emote
        setl statusline+=%#StatusLineBgColorTwo#\ 👾\ %#StatusLineFgColorTwo#%#StatusLineNC#\ 
        " Add file name
        setl statusline+=%t
        " LEFT SIDE [END]

        " RIGHT SIDE [BEGIN]
        " Switch to rightside
        setl statusline+=%=
        " RIGHT SIDE [END]

    endif
endfunction

autocmd WinEnter * call g:StatusLine(v:true)
autocmd WinLeave * call g:StatusLine()
autocmd FileType * call g:StatusLine(v:true)
