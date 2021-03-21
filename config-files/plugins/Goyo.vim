let s:is_in_zen_mode = 0
let s:was_nvim_tree_open = 0

function! Toggle_zen_mode()
    if s:is_in_zen_mode
        execute "Goyo!"
        let s:is_in_zen_mode = 0

        if s:was_nvim_tree_open
            execute "NvimTreeToggle"
            " Need that 1 millisecond sleep so cursor jumps back to the right window and position
            sleep 1m
            execute "wincmd p"
        endif

        " StatusLine somehow loses highlighting/styles. Just resourcing styles.
        source ~/.config/nvim/config-files/general/colorscheme-overwrites.vim
    else
        let s:was_nvim_tree_open = bufexists("NvimTree")

        if s:was_nvim_tree_open
            execute "NvimTreeClose"
        endif

        execute "Goyo 70%x80%"
        let s:is_in_zen_mode = 1
    endif
endfunction

let g:which_key_map.z = 'Toggle zen mode'
nnoremap <silent> <Leader>z :call Toggle_zen_mode()<CR>
