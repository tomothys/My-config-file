let s:buffer_peek_buf_name = 'Buffer Peek'
let s:buffer_peek_winid = -1

function! g:Is_buffer_peek_open() abort
    return s:buffer_peek_winid != -1
endfunc

function! s:create_new_buffer() abort
    let buffer = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_name(buffer, s:buffer_peek_buf_name)
    return buffer
endfunc

function! s:create_floating_window() abort
    let buffer = <SID>create_new_buffer()

    let ui = nvim_list_uis()[0]
    let windowWidth = 50
    let win = nvim_open_win(buffer, 0, {
                \ 'relative': 'editor',
                \ 'width': windowWidth,
                \ 'height': ui.height - 6,
                \ 'row': 1,
                \ 'col': ui.width - 2,
                \ 'anchor': 'NE',
                \ 'style': 'minimal',
                \ 'border': ['┌', '─', '┐', '│', '┘', '─', '└', '│'],
                \ })
    let s:buffer_peek_winid = win

    let headline = 'Buffer'
    let headlineStringList = [
                \ ' ┌' . repeat('─', windowWidth - 4) . '┐',
                \ ' │' . repeat(' ', ((windowWidth - 4) / 2) - (strlen(headline) / 2)) . headline . repeat(' ', ((windowWidth - 4) / 2) - (strlen(headline) / 2)) . '│',
                \ ' └' . repeat('─', windowWidth - 4) . '┘',
                \ ''
                \ ]
    call nvim_buf_set_lines(buffer, 0, len(headlineStringList), v:false, headlineStringList)

    return buffer
endfunc

function! s:get_buf_list() abort
    let bufinfolist = getbufinfo({'bufloaded': 1, 'buflisted': 1})
    let buflist = []

    for item in bufinfolist
        if empty(item.name)
            continue
        endif

        let bufnr = item.bufnr
        let path = strcharpart(item.name, strlen(getcwd()))
        let name = split(item.name, '/')[-1]

        call add(buflist, {'bufnr': bufnr, 'name': name, 'path': path})
    endfor

    return buflist
endfunc

function! s:transform_list_to_string(buflist) abort
    let stringList = []

    for item in a:buflist
        call add(stringList, '   ' . item.bufnr . ': ' . item.path)
    endfor

    return stringList
endfunc

function! s:set_buf_lines() abort
    let buflist = <SID>get_buf_list()
    let bufnr = bufnr(s:buffer_peek_buf_name)
    call nvim_buf_set_lines(bufnr, 4, 60, v:false, <SID>transform_list_to_string(buflist))
endfunc

function! s:open_buffer_peek() abort
    call <SID>create_floating_window()
    call <SID>set_buf_lines()
endfunc

function! s:close_buffer_peek() abort
    if s:buffer_peek_winid != -1
        call nvim_win_close(s:buffer_peek_winid, v:true)

        let bufnr = bufnr(s:buffer_peek_buf_name)
        call nvim_buf_delete(bufnr, { 'force': v:true })

        " echo 'close dat shit ' . bufnr
        echo 'close dat beautiful buffer ' . bufnr

        let s:buffer_peek_winid = -1
    endif
endfunc

function! s:toggle_buffer_peek() abort
    if g:Is_buffer_peek_open()
        call <SID>close_buffer_peek()
    else
        call <SID>open_buffer_peek()
    endif
endfunc

function! g:Rerender_buffer_peek(timer) abort
    if g:Is_buffer_peek_open()
        call <SID>set_buf_lines()
    endif
endfunc

command! ToggleBufferPeek call <SID>toggle_buffer_peek()
command! RerenderBufferPeek call Rerender_buffer_peek(0)

augroup buffer_peek
    autocmd!
    autocmd BufEnter * call Rerender_buffer_peek(0)
    autocmd BufDelete * call timer_start(0, 'Rerender_buffer_peek')
    autocmd BufHidden * call <SID>close_buffer_peek()
augroup END
