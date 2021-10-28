function! s:press_enter() abort
    let l:selected_register = matchstr(getline('.'), '\%1c.')
    call feedkeys(":bw!\<CR>\"" . l:selected_register)
endfunc

function! g:Open_register_peek() abort
    " open a new split
    11new "register"

    " write the registers content
    call append(0,[
        \ "0: " . getreg("0"),
        \ "1: " . getreg("1"),
        \ "2: " . getreg("2"),
        \ "3: " . getreg("3"),
        \ "4: " . getreg("4"),
        \ "5: " . getreg("5"),
        \ "6: " . getreg("6"),
        \ "7: " . getreg("7"),
        \ "8: " . getreg("8"),
        \ "9: " . getreg("9"),
        \ "+: " . getreg("+"),
    \ ])

    call feedkeys("Gdd0:0\<CR>", "n")

    " set this buffer up
    setl nowrap
    setl nonu
    setl cursorline

    nnoremap <buffer> 0 :bd!<CR>"0
    nnoremap <buffer> 1 :bd!<CR>"1
    nnoremap <buffer> 2 :bd!<CR>"2
    nnoremap <buffer> 3 :bd!<CR>"3
    nnoremap <buffer> 4 :bd!<CR>"4
    nnoremap <buffer> 5 :bd!<CR>"5
    nnoremap <buffer> 6 :bd!<CR>"6
    nnoremap <buffer> 7 :bd!<CR>"7
    nnoremap <buffer> 8 :bd!<CR>"8
    nnoremap <buffer> 9 :bd!<CR>"9
    nnoremap <buffer> + :bd!<CR>"+

    nnoremap <buffer> j j0
    nnoremap <buffer> k k0
    nnoremap <buffer> <ESC> :bw!<CR>
    nnoremap <buffer> <Enter> <cmd>call <SID>s:press_enter()<CR>
endfunc

nnoremap " <cmd>call g:Open_register_peek()<CR>
inoremap <C-r> <Esc><cmd>call g:Open_register_peek()<CR>
