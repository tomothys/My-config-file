function! g:Submit_register_peek() abort
    let l:selected_register = matchstr(getline('.'), '\%2c.')
    call feedkeys(":bw!\<Cr>\"" . l:selected_register)
endfunc

function! g:Open_register_peek() abort
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

    call feedkeys("Gdd0:6\<Cr>", "n")

    " set this buffer up
    setl nowrap
    setl nonu
    setl nornu
    setl cursorline

    nnoremap <buffer> 0 :bd!<Cr>"0
    nnoremap <buffer> 1 :bd!<Cr>"1
    nnoremap <buffer> 2 :bd!<Cr>"2
    nnoremap <buffer> 3 :bd!<Cr>"3
    nnoremap <buffer> 4 :bd!<Cr>"4
    nnoremap <buffer> 5 :bd!<Cr>"5
    nnoremap <buffer> 6 :bd!<Cr>"6
    nnoremap <buffer> 7 :bd!<Cr>"7
    nnoremap <buffer> 8 :bd!<Cr>"8
    nnoremap <buffer> 9 :bd!<Cr>"9
    nnoremap <buffer> + :bd!<Cr>"+
    nnoremap <buffer> / :bd!<Cr>"/

    nnoremap <buffer> j j0
    nnoremap <buffer> k k0
    nnoremap <buffer> <Esc> :bw!<Cr>
    nnoremap <buffer> <Cr> <cmd>call g:Submit_register_peek()<Cr>
endfunc

nnoremap " <cmd>call g:Submit_register_peek()<Cr>
