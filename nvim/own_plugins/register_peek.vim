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
        let buffer = nvim_create_buf(v:false, v:true)
        call nvim_buf_set_name(buffer, s:register_peek_buf_name)
        let ui = nvim_list_uis()[0]

        let windowWidth = 100
        let win = nvim_open_win(buffer, 1, {
                    \ 'relative': 'editor',
                    \ 'width': windowWidth,
                    \ 'height': ui.height - 6,
                    \ 'row': 1,
                    \ 'col': ui.width - 2,
                    \ 'anchor': 'NE',
                    \ 'style': 'minimal',
                    \ 'border': ['┌', '─', '┐', '│', '┘', '─', '└', '│'],
                    \ })

        " write the registers content
        let stringList = [
                    \ " ┌" . repeat("─", windowWidth - 4) . "┐",
                    \ " │" . repeat(" ", ((windowWidth - 4) / 2) - 4) . "Register" . repeat(" ", ((windowWidth - 4) / 2) - 4) . "│",
                    \ " └" . repeat("─", windowWidth - 4) . "┘",
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
                    \ ]

        call nvim_buf_set_lines(buffer, 0, len(stringList), 0, stringList)

        " set this buffer up
        call nvim_buf_set_option(buffer, 'buftype', 'nofile')

        call nvim_buf_set_keymap(buffer, 'n', '0', ':bw!<Cr>"0', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', '1', ':bw!<Cr>"1', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', '2', ':bw!<Cr>"2', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', '3', ':bw!<Cr>"3', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', '4', ':bw!<Cr>"4', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', '5', ':bw!<Cr>"5', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', '6', ':bw!<Cr>"6', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', '7', ':bw!<Cr>"7', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', '8', ':bw!<Cr>"8', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', '9', ':bw!<Cr>"9', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', '+', ':bw!<Cr>"+', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', '/', ':bw!<Cr>"/', { 'noremap': v:true, 'silent': v:true })

        call nvim_buf_set_keymap(buffer, 'n', 'j', '/^  \zs.\ze<Cr>:nohl<Cr>', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', 'k', '?^  \zs.\ze<Cr>:nohl<Cr>', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', 'h', '', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', 'l', '', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', '<Esc>', ':bw!<Cr>', { 'noremap': v:true, 'silent': v:true })
        call nvim_buf_set_keymap(buffer, 'n', '<Cr>', '<cmd>call <SID>submit_register_peek()<Cr>', { 'noremap': v:true, 'silent': v:true })

        call cursor(6,3)
    endif
endfunc

command! ToggleRegisterPeek call <SID>toggle_register_peek()
