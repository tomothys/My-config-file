function! s:open_help_window(args) abort
    let buffer = nvim_create_buf(v:true, v:true)
    let ui = nvim_list_uis()[0]

    let win = nvim_open_win(buffer, 1, {
                \ 'relative': 'editor',
                \ 'width': ui.width - 16,
                \ 'height': ui.height - 8,
                \ 'row': 2,
                \ 'col': 8,
                \ 'anchor': 'NW',
                \ 'style': 'minimal',
                \ 'border': ['┌', '─', '┐', '│', '┘', '─', '└', '│'],
                \})

    setl buftype=help
    setl filetype=help

    execute 'help ' . a:args
endfunc

command! -complete=help -nargs=? H call <SID>open_help_window(<q-args>)
command! -complete=help -nargs=? Help call <SID>open_help_window(<q-args>)
