command Open_file_in_code !code %<CR>

function OpenProjectInCode()
    let l:cwd = getcwd()
    execute '!code ' . l:cwd
endfunction
command Open_project_in_code :call OpenProjectInCode()<CR>
