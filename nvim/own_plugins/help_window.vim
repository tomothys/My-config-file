let s:help_window_buf_name = 'Floating help-window'

function! g:Is_help_window_open() abort
    let bufnr = bufnr(s:help_window_buf_name)
    return bufnr != -1
endfunc

function! s:close_help_window() abort
    if g:Is_help_window_open()
        let bufnr = bufnr(s:help_window_buf_name)
        call nvim_buf_delete(bufnr, { 'force': v:true })
    endif
endfunc

function! s:open_help_window(args) abort
    if g:Is_help_window_open()
        echo g:Is_help_window_open()
        call <SID>close_help_window()
    endif

    let buffer = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_name(buffer, s:help_window_buf_name)
    let ui = nvim_list_uis()[0]

    call nvim_buf_set_option(buffer, 'buftype', 'help')

    let win = nvim_open_win(buffer, 1, {
                \ 'relative': 'editor',
                \ 'width': ui.width - 16,
                \ 'height': ui.height - 8,
                \ 'row': 2,
                \ 'col': 8,
                \ 'anchor': 'NW',
                \ 'style': 'minimal',
                \ 'border': ['┌', '─', '┐', '│', '┘', '─', '└', '│'],
                \ })

    execute 'help ' . a:args
endfunc

command! -complete=help -nargs=? H call <SID>open_help_window(<q-args>)
command! -complete=help -nargs=? Help call <SID>open_help_window(<q-args>)
