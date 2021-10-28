"------------------------------------
" ------------ Vim-Plug ------------
"------------------------------------
call plug#begin('~/AppData/Local/nvim/plugged')

" List of plug-ins
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'gfanto/fzf-lsp.nvim'
Plug 'prettier/vim-prettier'
Plug 'airblade/vim-rooter'

" Colorscheme
Plug 'folke/tokyonight.nvim'

" Add support for syntax-highlighting
Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'posva/vim-vue'
" Plug 'evanleck/vim-svelte'

" Lsp and auto-complete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'

call plug#end()

"------------------------------------
" -------- Plug-In settings --------
"------------------------------------
" Colorscheme
let g:tokyonight_style="night"
color tokyonight
highlight EndOfBuffer guifg=#565f89
highlight StatusLine guibg=#9ece6a guifg=#1f2335
highlight StatusLineNC guibg=#565f89 guifg=#24283b
highlight LineNr guifg=#ff9e64
highlight VertSplit guifg=#c0caf5

lua << EOF
-- --------------
-- lanuageserver
-- --------------
-- Bash
require'lspconfig'.bashls.setup{}

-- Diagnostics
-- require'lspconfig'.diagnosticls.setup{}

-- Docker
require'lspconfig'.dockerls.setup{}

-- Emmet LS
require'lspconfig'.emmet_ls.setup{}

-- ESLint
require'lspconfig'.eslint.setup{}

-- GraphQL
require'lspconfig'.graphql.setup{}

-- HTML
require'lspconfig'.html.setup{}

-- CSS/SCSS
require'lspconfig'.cssls.setup{}

-- JSON
require'lspconfig'.jsonls.setup {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}

-- SQL
require'lspconfig'.sqls.setup{}

-- Svelte
require'lspconfig'.svelte.setup{}

-- TypeScript
require'lspconfig'.tsserver.setup{}

-- VIM
require'lspconfig'.vimls.setup{}

-- Graphviz
require'lspconfig'.dotls.setup{}

-- Vue 2
require'lspconfig'.vuels.setup{}

-- Vue 3
-- Don't use vuels and volar at the same time
-- With additional configuration you can run volar on Vue 2 projects too
-- -> https://github.com/johnsoncodehk/volar#using
-- require'lspconfig'.volar.setup{}

-- --------
-- LspKind
-- --------
local lspkind = require('lspkind')

-- ---------
-- Nvim-Cmp
-- ---------
local cmp = require'cmp'

cmp.setup {
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'treesitter' },
        { name = 'buffer', opts = {
           get_bufnr = function()
                return vim.api.nvim_list_bufs()
            end,
        }},
        { name = 'path' },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", lspkind.presets.default[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
                nvim_lsp = "",
                nvim_lua = "",
                treesitter = "",
                path = "",
                buffer = "﬘",
                zsh = "ﲵ",
                spell = "暈",
            })[entry.source.name]

            return vim_item
        end
    },
    documentation = {
        border = { '╔', '═', '╗', '║', '╝', '═', '╚', '║' }
    },
}

-- ---------------
--  Treesitter
-- ---------------
require'nvim-treesitter.configs'.setup {
    highlight = {
        ensure_installed = "maintained",
        enable = true,              -- false will disable the whole extension
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}
EOF

"------------------------------------
" ------ Import my own PlugIn ------
"------------------------------------
source ~/AppData/Local/nvim/own_plugins/register_peek.vim

"------------------------------------
" -------- General settings --------
"------------------------------------
set path+=**
set wildignore+=**/node_modules/**
syntax enable                           " Enable syntax highlighting
set nocompatible                        " Turn off vi-compatible mode and make vim shine
filetype plugin on                      " Turn on builtin plugins
runtime macros/matchit.vim              " Jump between pairs like html-tags with %
set hidden                              " Make vim able to open new buffer without saving currently open buffer first
set nowrap                              " Dont make lines wrap
set number                              " Enable linenumbers
set relativenumber                      " Enable relative linenumbers
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

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=300 }
augroup END

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

" Add j and k jumps to jump-list
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'

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
vnoremap <Leader>c :

" Highlight word in document without cursor 'jumping' around
nnoremap # mzyiw0k/<C-r>0<Cr>`z

inoremap <expr> <silent> <Space> g:IsCursorWrappedBy('""', "''", '()', '[]', '{}') ? '<Space><Space><Left>' : '<Space>'
inoremap <expr> <silent> <Bs> g:IsCursorWrappedBy('""', "''", '()', '[]', '{}', '  ') ? '<Left><Del><Del>' : '<Bs>'
inoremap <expr> <silent> <Cr> g:IsCursorWrappedBy('{}') ? '<Right><Bs><Cr>}<C-o>O' : '<Cr>'

" Make writing those pairs and special characters more convenient
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

" Remap gf to get to relative file
inoremap gf <Esc>yi":e %:h/<C-r>0<Cr>

" Scroll one line with Ctrl+j and Ctrl+k instead of Ctrl+e and Ctrl+y
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

" Move with h,j,k,l in insert-mode instead of arrow-keys
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Lsp
nnoremap <Leader>lf <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>lh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>ls <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <Leader>lr <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <Leader>la <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <Leader>ld <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

"------------------------------------
" --------- Abbr / Snippets --------
"------------------------------------
" General JavaScript Snippets
augroup javascript_abbrevs
    autocmd FileType javascript,typescript,svelte,vue :inoreab afunc ()<C-o>ma => {<CR>}<C-o>O
    autocmd FileType javascript,typescript,svelte,vue :inoreab nfunc <ESC>bdeifunction <C-r>"()<C-o>ma {<CR>}<C-o>O
    autocmd FileType javascript,typescript,svelte,vue :inoreab meth ()<C-o>ma {<CR>}<C-o>O
    autocmd FileType javascript,typescript,svelte,vue :inoreab log console.log()<Left>
    autocmd FileType javascript,typescript,svelte,vue :inoreab vlog <ESC>bdeiconsole.log("<C-o>P", <C-o>P)
    autocmd FileType javascript,typescript,svelte,vue :inoreab if if ()<C-o>ma {<CR>}<C-o>O
    autocmd FileType javascript,typescript,svelte,vue :inoreab else <ESC>/}<CR>a else {<CR>}<C-o>O
    autocmd FileType javascript,typescript,svelte,vue :inoreab elseif <ESC>/}<CR>a else if ()<C-o>ma {<CR>}<C-o>O
augroup END

" Vue Snippets
augroup vue_abbrevs
    autocmd FileType javascript,typescript,vue :inoreab vcomp <Esc>bdeiimport Vue from "vue";<CR><CR>interface <C-o>pData {}<CR><CR>export const <C-o>p = Vue.extend({<CR>});<C-o>Oname: "<C-o>p",<CR>template: "",<CR>data(): <C-o>pData {<CR>return {};<CR>},<CR>components: {<CR>},<C-o>?"<CR>
    autocmd FileType javascript,typescript,vue :inoreab vimport <Esc>bdeiimport {<C-o>p } from "<ESC>mza/components/<C-o>p";<ESC>/components:<CR>/}<CR>O<C-R>",<ESC>`za
augroup END

" Svelte Snippets
augroup svelte_abbrevs
    autocmd FileType svelte :inoreab sif {#if <C-o>ma}<CR>{/if}<C-o>`a
    autocmd FileType svelte :inoreab selse <C-o>/{\/if}<CR><C-o>O{:else}<CR>
    autocmd FileType svelte :inoreab rlog <ESC>bdei$: console.log("<C-o>p"= <C-o>p)
augroup END
