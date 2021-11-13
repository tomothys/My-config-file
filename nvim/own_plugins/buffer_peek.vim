let s:buffer_peek_buf_name = 'Buffer Peek'

function! g:Is_buffer_peek_buf_open() abort
    return bufexists(s:buffer_peek_buf_name)
endfunc

function! s:close_buffer_peek() abort
    if g:Is_buffer_peek_buf_open()
        let bufnr = bufnr(s:buffer_peek_buf_name)
        return nvim_buf_delete(bufnr, { 'force': v:true })
    endif
endfunc

function! s:get_buf_list() abort
    let bufinfolist = getbufinfo({'bufloaded': 1, 'buflisted': 1})
    let buflist = []

    for item in bufinfolist
        if empty(item.name)
            continue
        endif

        let bufnr = item.bufnr
        let path = trim(item.name, getcwd(), 1)
        let name = split(item.name, '/')[-1]

        call add(buflist, {'bufnr': bufnr, 'name': name, 'path': path})
    endfor

    return buflist
endfunc

function! s:create_floating_window() abort
    let buffer = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_name(buffer, s:buffer_peek_buf_name)
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

function! s:transform_list_to_string(buflist) abort
    let stringList = []

    for item in a:buflist
        call add(stringList, '   ' . item.bufnr . ': ' . item.path)
    endfor

    return stringList
endfunc

function! s:set_buf_lines() abort
    let buflist = <SID>get_buf_list()

    if g:Is_buffer_peek_buf_open()
        let bufnr = bufnr(s:buffer_peek_buf_name)
        call nvim_buf_set_lines(bufnr, 4, 60, v:false, <SID>transform_list_to_string(buflist))
    endif
endfunc

function! s:toggle_buffer_peek() abort
    if g:Is_buffer_peek_buf_open()
        call <SID>close_buffer_peek()
    else
        call <SID>create_floating_window()
        call <SID>set_buf_lines()
    endif
endfunc

function! g:Rerender_buffer_peek(timer) abort
    " Since autocmd BufEnter resets buf lines
    " this will reset the buffer peek list
    " simple BufDelete autocmd is not doing the job
    execute 'wincmd w | wincmd p'
endfunc

command! ToggleBufferPeek call <SID>toggle_buffer_peek()
command! RerenderBufferPeek call Rerender_buffer_peek()

augroup buffer_peek
    autocmd!
    autocmd BufEnter * call <SID>set_buf_lines()
    autocmd BufDelete * call timer_start(0, 'Rerender_buffer_peek')
augroup END
