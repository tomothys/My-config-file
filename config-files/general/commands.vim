command OpenFileInCode !code %<CR>

function OpenProjectInCode()
    let l:cwd = getcwd()
    execute '!code ' . l:cwd
endfunction
command OpenProjectInCode :call OpenProjectInCode()<CR>
