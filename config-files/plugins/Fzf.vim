let $FZF_DEFAULT_OPTS='--layout=reverse'
let $FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{node_modules/*,.git/*}"'
let g:fzf_preview_window = ['right:50%', '\']
let g:fzf_layout = {'window': { 'width': 0.7, 'height': 0.5, 'border': 'rounded', 'yoffset': 0.1 }}

let g:which_key_map.f = { 'name': '+Find' }
let g:which_key_map.f.p = 'File finder'
nnoremap <silent> <Leader>fp :Files<CR>

inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.5, 'height': 0.5 }})
