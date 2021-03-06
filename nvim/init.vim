"------------------------------------
" ------------ Vim-Plug ------------
"------------------------------------
if has('win32')
    call plug#begin('~/AppData/Local/nvim/plugged')
else
    call plug#begin('~/.config/nvim/plugged')
endif

" List of plug-ins
Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier'
Plug 'airblade/vim-rooter'
Plug 'mbbill/undotree'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'hoschi/yode-nvim'

" Colorscheme
Plug 'folke/tokyonight.nvim'

" Add support for syntax-highlighting
Plug 'nvim-treesitter/nvim-treesitter'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
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
highlight VertSplit guifg=#1f2335
highlight CursorLine guibg=#1f2335
highlight CursorLineNr guibg=#ff9e64 guifg=#000000

lua << EOF
-- --------------
-- lanuageserver
-- --------------
-- Bash
require'lspconfig'.bashls.setup{}

-- GraphQL
require'lspconfig'.graphql.setup{}

-- Docker
require'lspconfig'.dockerls.setup{}

-- SQL
require'lspconfig'.sqls.setup{}

-- Svelte
require'lspconfig'.svelte.setup{}

-- TypeScript
require'lspconfig'.tsserver.setup{
    cmd = { 'typescript-language-server', '--stdio' }
}

-- VIM
require'lspconfig'.vimls.setup{
    cmd = { 'vim-language-server', '--stdio' }
}

-- Graphviz
require'lspconfig'.dotls.setup{}

-- Vue 2
require'lspconfig'.vuels.setup{}

-- Vue 3
-- Don't use vuels and volar at the same time
-- With additional configuration you can run volar on Vue 2 projects too
-- -> https://github.com/johnsoncodehk/volar#using
-- require'lspconfig'.volar.setup{}

-- HTML, CSS, ESLint, JSON
local json_commands = {
    Format = {
        function()
            vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
    }
}

require'lspconfig'.html.setup {}
require'lspconfig'.cssls.setup {}
require'lspconfig'.eslint.setup {}
require'lspconfig'.jsonls.setup {
    commands = json_commands
}


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
        { name = 'buffer', option = {
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
                nvim_lsp = "???",
                nvim_lua = "???",
                treesitter = "???",
                path = "???",
                buffer = "???",
                zsh = "???",
                spell = "???",
            })[entry.source.name]

            return vim_item
        end
    },
    documentation = {
        border = { '???', '???', '???', '???', '???', '???', '???', '???' }
    },
}

-- ----------
--  NvimTree 
-- ----------
require'nvim-tree'.setup {
    diagnostics = {
        enable = false,
    },
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    auto_close = false,
    open_on_tab = false,
    update_cwd = false,
    update_focused_file = {
        enable = true,
        ignore_list = {}
    },
    view = {
        width = 40,
        side = 'left',
        mappings = {
            list = {}
        }
    }
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

" -----
"  FZF 
" -----
let $FZF_DEFAULT_OPTS='--layout=reverse'
let $FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{node_modules/*,.git/*}"'
let g:fzf_preview_window = []
let g:fzf_layout = {'window': { 'width': 0.6, 'height': 0.6, 'border': 'rounded' }}

" ------------
"  Vim-Rooter 
" ------------
let g:rooter_patterns = ['.git']

" -----------
"  Yode-Nvim
" -----------
lua require('yode-nvim').setup({})

" Commands
command! -range FocusBuffer vsp | <line1>,<line2>YodeCreateSeditorReplace

"------------------------------------
" ------ Import my own PlugIn ------
"------------------------------------
if has('win32')
    source ~/AppData/Local/nvim/own_plugins/register_peek.vim
    luafile ~/AppData/Local/nvim/own_plugins/buffer_peek.lua
else
    source ~/.config/nvim/own_plugins/register_peek.vim
    luafile ~/.config/nvim/own_plugins/buffer_peek.lua
endif

"------------------------------------
" -------- General settings --------
"------------------------------------
set path+=**
set wildignore+=**/node_modules/**
syntax enable                           " Enable syntax highlighting
set nocompatible                        " Turn off vi-compatible mode and make vim shine
filetype on
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
set signcolumn=yes                      " Show sign-column in linenumber-column
set scrolloff=3                         " Minimal number of screen lines to keep above and below the cursor
set completeopt+=menuone,noselect       " Use the popup menu also when there is only one match. Useful when there is additional info. And don't select the first match until the user selects a match.
set cursorline
set numberwidth=6
set laststatus=2
set modelines=0
set list
set listchars=tab:???\ ,

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=300 }
augroup END

"--------------------------------
" -------- GUI settings --------
"--------------------------------
if exists('g:GuiLoaded') == 1
    set guifont=FiraCode_NF:h10
endif

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
inoremap fk <C-]>

" Enter command-mode
nnoremap <Leader>c :

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
inoremap g?? ?

" vim-fugitive mappings (fugitive needed)
nnoremap <Leader>gs :G<Cr>
nnoremap <Leader>gc :G commit<Cr>
nnoremap <Leader>gp :G push<Cr>
nnoremap <Leader>gl :G pull<Cr>

" Open register_peek window
nnoremap <Leader>sr <cmd>ToggleRegisterPeek<Cr>

" Open buffer_peek window
nnoremap <Leader>bb <cmd>ToggleBufferPeek<Cr>
" Wipe buffer
nnoremap <silent> <Leader>bw :bw!<Cr>

" Open fuzzy file search window
nnoremap <Leader>fp <cmd>Files<Cr>
nnoremap <C-p> <cmd>Files<Cr>

" Open File tree window
nnoremap <Leader>e <Cmd>NvimTreeToggle<Cr>
nnoremap <Leader>r <Cmd>NvimTreeRefresh<Cr>

" Lsp
nnoremap <Leader>ld <cmd>lua vim.lsp.buf.definition()<Cr>
nnoremap <Leader>lh <cmd>lua vim.lsp.buf.hover()<Cr>
nnoremap <Leader>ls <cmd>lua vim.lsp.buf.signature_help()<Cr>
nnoremap <Leader>lr <cmd>lua vim.lsp.buf.rename()<Cr>
nnoremap <Leader>la <cmd>lua vim.lsp.buf.code_action()<Cr>
nnoremap <Leader>ll <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<Cr>
nnoremap <Leader>lf <cmd>lua vim.lsp.buf.references()<Cr>

"------------------------------------
" --------- Abbr / Snippets --------
"------------------------------------
" General JavaScript Snippets
augroup javascript_abbrevs
    autocmd!
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
    autocmd!
    autocmd FileType javascript,typescript,vue :inoreab vcomp <Bs><Esc>bdeaimport Vue from "vue";<CR><CR>interface <C-r>"Data {}<CR><CR>export const <C-r>" = Vue.extend({<CR>});<C-o>Oname: "<C-r>"",<CR>template: "<C-o>mn",<Cr>components: {<C-o>mc},<CR>data(): <C-r>"Data {<CR>return {<C-o>md};<CR>},
    autocmd FileType javascript,typescript,vue :inoreab vimport <Bs><Esc>bdeaimport { <C-r>" } from "/components/<C-r>"<C-o>mi";<ESC>/components:<CR>/{<Cr>:nohl<Cr>a<Cr><C-r>",
augroup END

" Svelte Snippets
augroup svelte_abbrevs
    autocmd!
    autocmd FileType svelte :inoreab sif {#if }<C-o>ma<Cr>{/if}<C-o>`a
    autocmd FileType svelte :inoreab selse <C-o>/{\/if}<Cr><C-o>:nohl<Cr><C-o>O{:else}<CR>
    autocmd FileType svelte :inoreab selseif <C-o>/{\(\/\\|:\)\(if\\|else\).<Cr><C-o>:nohl<Cr><C-o>O{:else if }<Left>
    autocmd FileType svelte :inoreab rlog <Bs><ESC>bdea$: console.log("<C-r>"", <C-r>")
augroup END
