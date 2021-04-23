function! g:IsCursorWrappedBy(...) abort
    let l:charBefore = getline('.')[col('.') - 2]
    let l:charAfter = getline('.')[col('.') - 1]

    for arg in a:000
        if l:charBefore == arg[0] && l:charAfter == arg[1]
            return v:true
        endif
    endfor

    return v:false
endfunction

function! g:ConfirmSurroundings() abort
    let l:choice = confirm("?",
        \ "&d \"\"\n" .
        \ "&s ''\n" .
        \ "&p ()\n" .
        \ "&c {}\n" .
        \ "&b []\n" .
        \ "&h <>\n"
    \)

    let l:map = { 1: '""', 2: "''", 3: "()", 4: "{}", 5: "[]", 6: "<>" }
    return l:map[l:choice]
endfunction

function! g:SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
