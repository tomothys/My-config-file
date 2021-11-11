function! s:submit_register_peek() abort
    let l:selected_register = matchstr(getline('.'), '\%2c.')
    call feedkeys(":bw!\<Cr>\"" . l:selected_register, "t")
endfunc

function! s:open_register_peek() abort
    " open a new split
    vert 60new \"Register\"

    " write the registers content
    call append(0,[
        \ "\" ----------",
        \ "\"  Register",
        \ "\" ----------",
        \ "",
        \ "Numbers:",
        \ " 0: " . getreg("0"),
        \ " 1: " . getreg("1"),
        \ " 2: " . getreg("2"),
        \ " 3: " . getreg("3"),
        \ " 4: " . getreg("4"),
        \ " 5: " . getreg("5"),
        \ " 6: " . getreg("6"),
        \ " 7: " . getreg("7"),
        \ " 8: " . getreg("8"),
        \ " 9: " . getreg("9"),
        \ "",
        \ "Special:",
        \ " +: " . getreg("+"),
        \ " /: " . getreg("/"),
    \ ])

    " set this buffer up
    setl nowrap
    setl nonu
    setl nornu
    setl cursorline

    nnoremap <buffer> 0 :bw!<Cr>"0
    nnoremap <buffer> 1 :bw!<Cr>"1
    nnoremap <buffer> 2 :bw!<Cr>"2
    nnoremap <buffer> 3 :bw!<Cr>"3
    nnoremap <buffer> 4 :bw!<Cr>"4
    nnoremap <buffer> 5 :bw!<Cr>"5
    nnoremap <buffer> 6 :bw!<Cr>"6
    nnoremap <buffer> 7 :bw!<Cr>"7
    nnoremap <buffer> 8 :bw!<Cr>"8
    nnoremap <buffer> 9 :bw!<Cr>"9
    nnoremap <buffer> + :bw!<Cr>"+
    nnoremap <buffer> / :bw!<Cr>"/

    nnoremap <buffer> j j^
    nnoremap <buffer> k k^
    nnoremap <buffer> <Esc> :bw!<Cr>
    nnoremap <buffer> <Cr> <cmd>call <SID>submit_register_peek()<Cr>

    call cursor(6,2)
endfunc

nnoremap " <cmd>call <SID>open_register_peek()<Cr>
