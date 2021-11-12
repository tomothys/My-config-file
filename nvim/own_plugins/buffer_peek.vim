function! s:open_buffer_list() abort
    echo "Hello World. Buffer list."
endfunc

command! ToggleBufferList call <SID>open_buffer_list()
