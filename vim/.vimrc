"------------------------------------
" ------------ Vim-Plug ------------
"------------------------------------
call plug#begin('~/.vim/plugged')

" List of plug-ins
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier'
Plug 'airblade/vim-rooter'

" Syntax highlighting
Plug 'posva/vim-vue'
Plug 'evanleck/vim-svelte'
Plug 'leafgarland/typescript-vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'jparise/vim-graphql'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm install'}

call plug#end()

"------------------------------------
" -------- Plug-In settings --------
"------------------------------------
" -----
"  FZF 
" -----
"let $FZF_DEFAULT_OPTS='--layout=reverse'
let $FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{node_modules/*,.git/*}"'
let g:fzf_preview_window = []
" let g:fzf_layout = {'window': { 'width': 0.6, 'height': 0.6, 'border': 'rounded' }}
let g:fzf_layout = { 'right': '40%' }

" ------------
"  Vim-Rooter 
" ------------
let g:rooter_patterns = ['.git']

" ---------
"  Vim-Vue
" ---------
let g:vue_pre_processors = ['ts', 'scss']

" ---------------------
"  CoC Language Server 
" ---------------------
let g:coc_global_extensions = ['coc-vetur', '@yaegassy/coc-volar', 'coc-yaml', 'coc-yank', 'coc-markdownlint', 'coc-powershell', 'coc-prettier', 'coc-sh', 'coc-stylelint', 'coc-sql', 'coc-svelte', 'coc-svg', 'coc-vimlsp', 'coc-explorer', 'coc-css', 'coc-graphql', 'coc-html', 'coc-lists', 'coc-html-css-support', 'coc-cssmodules', 'coc-eslint', 'coc-tsserver', 'coc-json', 'coc-git']

"------------------------------------
" ------ Import my own PlugIn ------
"------------------------------------
source ~/.vim/own_plugins/register_peek.vim

"------------------------------------
" -------- General settings --------
"------------------------------------
set path+=**
set wildignore+=**/node_modules/**
syntax enable                           " Enable syntax highlighting
set nocompatible                        " Turn off vi-compatible mode and make vim shine
filetype plugin on                      " Turn on builtin plugins
set hidden                              " Make vim able to open new buffer without saving currently open buffer first
set nowrap                              " Dont make lines wrap
set number                              " Enable linenumbers
set norelativenumber                      " Enable relative linenumbers
set ignorecase                          " Ignore case while searching etc.
set timeoutlen=500                      " Timeout for keymappings
set nobackup                            " Don't create any backup files
set nowritebackup                       " Don't create any backup files
set tabstop=4                           " Set length of tabs
set softtabstop=4                       " Set space-count for a tab
set shiftwidth=4
set smartindent                         " Do smart autoindenting when starting a new line
set incsearch                           " Highlight search while typing. Is enabled by default but I wanted to explicitly turn it on
set mouse=a                             " Enable mouse in [a]ll modes
set expandtab                           " Use the appropriate number of spaces to insert a <Tab>
set splitright                          " Make new splits open on the right
set noshowmode                          " Don't show mode when in visual-mode
set signcolumn=number                   " Show sign-column in linenumber-column
set scrolloff=3                         " Minimal number of screen lines to keep above and below the cursor
set completeopt+=menuone,noselect       " Use the popup menu also when there is only one match. Useful when there is additional info. And don't select the first match until the user selects a match.
set cursorline
set numberwidth=6
set laststatus=2

"------------------------------------
" ----------- Functions ------------
"------------------------------------
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

"------------------------------------
" ---------- Key mappings ----------
"------------------------------------
let mapleader=" "

" Esc insert-mode
inoremap jk <Esc>

" Remove highlighting with <Esc>
nnoremap <silent> <Esc> <Esc>:nohl<Cr>

" Open Coc-Explorer
nnoremap <Space>e <Cmd>CocCommand explorer<Cr>

" Add j and k jumps to jump-list
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'

" Jump to buffer
nnoremap <expr> <silent> <Bs> ":b" . v:count . "<Cr>"

" Go to mark
nnoremap <silent> gm `

" Reselect after indentation in visual mode
vnoremap < <gv
vnoremap > >gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Always leave visual mode on first 'v' instead of double tapping 'v' for visual line
vnoremap v <Esc>

" Search by pressing s. It's a simple substition for plugin like 'Easymotion'.
nnoremap s /

" Tigger command-mode
nnoremap <Leader>c :
vnoremap . :

" Highlight word in document without cursor 'jumping' around
nnoremap # mzyiw0k/<C-r>0<Cr>`z

inoremap <expr> <silent> <Space> g:IsCursorWrappedBy('""', "''", '()', '[]', '{}') ? '<Space><Space><Left>' : '<Space>'
inoremap <expr> <silent> <Bs> g:IsCursorWrappedBy('""', "''", '()', '[]', '{}', '  ') ? '<Left><Del><Del>' : '<Bs>'
inoremap <expr> <silent> <Cr> g:IsCursorWrappedBy('{}') ? '<Right><Bs><Cr>}<C-o>O' : '<Cr>'

" Remap gf to get to relative file
nnoremap gf <Esc>yi":e %:h/<C-r>0<Cr>

" Scroll one line with Ctrl+j and Ctrl+k instead of Ctrl+e and Ctrl+y
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

" Move with h,j,k,l in insert-mode instead of arrow-keys
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Trigger abbr
inoremap fj <C-]>

" Toggle between relative line numbers
nnoremap + :set rnu!<Cr>
vnoremap + <Esc>:set rnu!<Cr>gv

" Make writing those pairs and special characters more convenient # test with 'fj' completion
inoremap g0 =
inoremap g1 !
inoremap g2 ""<Left>
inoremap g+ ``<Left>
inoremap g4 $
inoremap g5 []<Left>
inoremap g6 &
inoremap g7 /
inoremap g8 ()<Left>
inoremap g9 {}<Left>
inoremap g# ''<Left>
inoremap g< <><Left>
inoremap gß ?

"------------------------------------
" --------- Abbr / Snippets --------
"------------------------------------
" General JavaScript Snippets
augroup javascript_abbrevs
    autocmd FileType javascript,typescript,svelte,vue :inoreab afunc ()<C-o>ma => {}<C-o>`a
    autocmd FileType javascript,typescript,svelte,vue :inoreab nfunc function ()<C-o>ma {<CR>}<C-o>O//<C-o>`a
    autocmd FileType javascript,typescript,svelte,vue :inoreab meth ()<C-o>ma {<CR>}<C-o>O//<C-o>`a
    autocmd FileType javascript,typescript,svelte,vue :inoreab log console.log("")<Left><Left>
    autocmd FileType javascript,typescript,svelte,vue :inoreab vlog <Bs><Esc>bdeaconsole.log("<C-r>"", <C-r>")
    autocmd FileType javascript,typescript,svelte,vue :inoreab if if ()<C-o>ma {<CR>}<C-o>O//<C-o>`a
    autocmd FileType javascript,typescript,svelte,vue :inoreab else <ESC>/}<CR><C-o>:nohl<Cr>a else {<CR>}<C-o>O
    autocmd FileType javascript,typescript,svelte,vue :inoreab elseif <ESC>/}<CR><C-o>:nohl<Cr>a else if ()<C-o>ma {<CR>}<C-o>O//<C-o>`a
    autocmd FileType javascript,typescript,svelte,vue :inoreab import import {<C-o>mi} from ""<Left>
    autocmd FileType javascript,typescript,svelte,vue :inoreab script <script lang="ts"><Cr></script><C-o>O
    autocmd FileType javascript,typescript,svelte,vue :inoreab style <style lang="scss"><Cr></style><C-o>O
augroup END

" Vue Snippets
augroup vue_abbrevs
    autocmd FileType javascript,typescript,vue :inoreab vcomp <Bs><Esc>bdeaimport Vue from "vue";<CR><CR>interface <C-r>"Data {}<CR><CR>export const <C-r>" = Vue.extend({<CR>});<C-o>Oname: "<C-r>"",<CR>template: "<C-o>mn",<Cr>components: {<C-o>mc},<CR>data(): <C-r>"Data {<CR>return {<C-o>md};<CR>},
    autocmd FileType javascript,typescript,vue :inoreab vimport <Bs><Esc>bdeaimport { <C-r>" } from "/components/<C-r>"<C-o>mi";<ESC>/components:<CR>/{<Cr>:nohl<Cr>a<Cr><C-r>",
augroup END

" Svelte Snippets
augroup svelte_abbrevs
    autocmd FileType svelte :inoreab sif {#if }<C-o>ma<Cr>{/if}<C-o>`a
    autocmd FileType svelte :inoreab selse <C-o>/{\/if}<Cr><C-o>:nohl<Cr><C-o>O{:else}<CR>
    autocmd FileType svelte :inoreab selseif <C-o>/{\(\/\\|:\)\(if\\|else\).<Cr><C-o>:nohl<Cr><C-o>O{:else if }<Left>
    autocmd FileType svelte :inoreab rlog <Bs><ESC>bdea$: console.log("<C-r>"", <C-r>")
augroup END