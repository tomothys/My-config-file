let s:register_peek_buf_name = 'Register Peek'

function! g:Is_register_peek_open() abort
    let buffer = bufnr(s:register_peek_buf_name)
    return buffer != -1
endfunc

function! s:close_register_peek() abort
    if g:Is_register_peek_open()
        let bufnr = bufnr(s:register_peek_buf_name)
        call nvim_buf_delete(bufnr, { 'force': v:true })
    endif
endfunc

function! s:submit_register_peek() abort
    let l:selected_register = matchstr(getline('.'), '\%3c.')
    call <SID>close_register_peek()
    call feedkeys("\"" . l:selected_register, "t")
endfunc

function! s:toggle_register_peek() abort
    if g:Is_register_peek_open()
        call <SID>close_register_peek()
    else
        let buffer = nvim_create_buf(v:true, v:true)
        let ui = nvim_list_uis()[0]
        call nvim_buf_set_name(buffer, s:register_peek_buf_name)

        let win = nvim_open_win(buffer, 1, {
                    \ 'relative': 'editor',
                    \ 'width': 100,
                    \ 'height': ui.height - 8,
                    \ 'row': 2,
                    \ 'col': ui.width - 2,
                    \ 'anchor': 'NE',
                    \ 'style': 'minimal',
                    \ 'border': ['┌', '─', '┐', '│', '┘', '─', '└', '│'],
                    \})

        " write the registers content
        call append(0,[
            \ " ┌────────────────────────────────────────────────────────────────────────────────────────────────┐",
            \ " │                                           Register                                             │",
            \ " └────────────────────────────────────────────────────────────────────────────────────────────────┘",
            \ "",
            \ " Numbers:",
            \ "  0: " . getreg("0"),
            \ "  1: " . getreg("1"),
            \ "  2: " . getreg("2"),
            \ "  3: " . getreg("3"),
            \ "  4: " . getreg("4"),
            \ "  5: " . getreg("5"),
            \ "  6: " . getreg("6"),
            \ "  7: " . getreg("7"),
            \ "  8: " . getreg("8"),
            \ "  9: " . getreg("9"),
            \ "",
            \ " Special:",
            \ "  +: " . getreg("+"),
            \ "  /: " . getreg("/"),
        \ ])

        " set this buffer up
        setl nowrap
        setl nonumber
        setl norelativenumber
        setl cursorline
        setl buftype=nofile
        setl bufhidden=hide
        setl noswapfile
        setl nobuflisted

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

        nnoremap <silent> <buffer> j /^  \zs.\ze<Cr>:nohl<Cr>
        nnoremap <silent> <buffer> k ?^  \zs.\ze<Cr>:nohl<Cr>
        nnoremap <buffer> h <Nop>
        nnoremap <buffer> l <Nop>
        nnoremap <silent> <buffer> <Esc> :bw!<Cr>
        nnoremap <silent> <buffer> <Cr> <cmd>call <SID>submit_register_peek()<Cr>

        call cursor(6,3)
    endif
endfunc

command! ToggleRegisterPeek call <SID>toggle_register_peek()
