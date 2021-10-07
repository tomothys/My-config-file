-- #region - VimPlug

    local Plug = vim.fn['plug#']

    vim.call('plug#begin', '~/.config/nvim/plugged')

    -- List of plugins
    Plug 'b3nj5m1n/kommentary'
    Plug 'tpope/vim-surround'
    Plug 'kyazdani42/nvim-web-devicons' -- Nice looking icons
    Plug 'ryanoasis/vim-devicons' -- Nice looking icons
    Plug 'kyazdani42/nvim-tree.lua' -- File Explorer
    Plug 'folke/which-key.nvim'
    Plug 'airblade/vim-gitgutter'
    Plug 'rhysd/git-messenger.vim' -- Open commits + messages in popup window
    Plug 'alvan/vim-closetag' -- Auto close html-tags
    Plug 'airblade/vim-rooter'
    Plug 'jremmen/vim-ripgrep'
    Plug('junegunn/fzf', { ['do'] = function()
        vim.call('fzf#install')
    end })
    Plug 'junegunn/fzf.vim'
    Plug 'gfanto/fzf-lsp.nvim' -- Use fzf to search for symbols
    Plug('prettier/vim-prettier', { ['do'] = function()
        vim.call('npm install')
    end })
    Plug 'editorconfig/editorconfig-vim'
    Plug 'junegunn/vim-peekaboo'
    Plug('folke/tokyonight.nvim', { ['do'] = function()
        vim.cmd('color tokyonight')
    end })
    Plug('nvim-treesitter/nvim-treesitter', { ['do'] = function()
        vim.cmd(':TSUpdate')
    end })

    -- Intellisense
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe' -- Auto-completion
    Plug 'glepnir/lspsaga.nvim'
    -- Plug 'onsails/lspkind-nvim' -- Adds pictograms to auto-completion pop-ups

    vim.call('plug#end')

-- #endregion

-- #region - Functions

    vim.cmd [[
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
            let l:choice = confirm("?", "&d \"\"\n" .  "&s ''\n" .  "&p ()\n" .  "&c {}\n" .  "&b []\n" .  "&h <>\n")
        
            let l:map = { 1: '""', 2: "''", 3: "()", 4: "{}", 5: "[]", 6: "<>" }
            return l:map[l:choice]
        endfunction
        
        function! g:SynStack()
            if !exists("*synstack")
                return
            endif
            echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
        endfunction

       function! g:Eatchar(pat)
          let c = nr2char(getchar(0))
          return (c =~ a:pat) ? '' : c
       endfunc
    ]]

-- #endregion

-- #region - General vim settings

    vim.cmd [[
        syntax enable				        " Enable syntax highlighting
        set iskeyword+=-,32  		        " Treat dash separated words as a word text object
        set formatoptions-=cro			    " Stop newline continution of comments
        autocmd FileType * set formatoptions-=cro
        set hidden				            " Keep multiple buffers open
        set nowrap				            " Don't wrap lines
        set whichwrap+=<,>,[,],h,l		    " Allow specified keys to move to the previous/next line
        set encoding=utf-8			        " Set displayed encoding
        set fileencoding=utf-8			    " The encoding written to file
        set cursorline                      " Highlight current line
        "set cursorcolumn                    " Highlight current column
        set mouse=a				            " Enable mouse
        set splitbelow				        " Horizontal splits will open below
        set splitright				        " Vertical splits will open on the right
        set conceallevel=0			        " To make `` visible in markdown files
        set tabstop=4				        " 1 tab = 4 spaces
        set shiftwidth=0			        " If zero if falls back to tabstop
        set expandtab				        " Converts tabs to spaces
        set autoindent                      " Enable auto indentation
        set smartindent                     " Claims to indent smart
        set laststatus=2                    " Always display status line
        set showtabline=2                   " Show tabs
        set noshowmode                      " Hide mode in statusline
        set number                          " Display line numbers
        set background=dark                 " Set background-color to dark
        set t_Co=256				        " Enable 256 color support
        set termguicolors
        set nobackup                        " Disable backup files
        set nowritebackup                   " Disable backup files
        set shortmess+=c                    " Don't pass messages to |ins-completion-menu|
        set signcolumn=yes                  " Show signcolumn
        set timeoutlen=300                  " Time in milliseconds to wait for a mapped sequence to complete.
        set scrolloff=3                     " Number of lines to keep on edge of editor
        set foldmethod=marker               " Well.. as keyword states: Set foldmethod
        set foldmarker=#region,#endregion
        set completeopt=menuone,noselect    " Compe said to do so.. 👀
        set ignorecase                      " Make search case insensitive
        set inccommand=split                " Make substitution visible while typing

        augroup highlight_yank
            autocmd!
            au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=300 }
        augroup END
    ]]


-- #endregion

-- #region - PlugIn settings

    -- #region - WhichKey

        local wk = require("which-key")

        wk.setup {
            window = {
                border = "double",
                position = "bottom"
            }
        }

    -- #endregion

    -- #region - FZF
        
        vim.cmd [[
            let $FZF_DEFAULT_OPTS='--layout=reverse'
            let $FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{node_modules/*,.git/*}"'
            let g:fzf_preview_window = ['right:60%', '\']
            let g:fzf_layout = {'window': { 'width': 0.7, 'height': 0.5, 'border': 'rounded', 'yoffset': 0.1 }}
        ]]

        wk.register({
            ["<leader>f"] = {
                name = "+File",
                p = { "<cmd>Files<CR>", "File finder" },
                s = { "<cmd>DocumentSymbols<CR>", "Document Symbol finder" }
            },
        })

    -- #endregion

    -- #region - GitGutter / Git-Messenger

        vim.cmd [[
            let g:gitgutter_enabled = 0
            let g:gitgutter_map_keys = 0
            let g:gitgutter_preview_win_floating = 0

            let g:gitgutter_sign_allow_clobber = 1
            let g:gitgutter_sign_added = '▎'
            let g:gitgutter_sign_modified = '▎'
            let g:gitgutter_sign_removed = '契'
            let g:gitgutter_sign_removed_first_line = '契'
            let g:gitgutter_sign_modified_removed = '▎'
            let g:gitgutter_preview_win_floating = 1

            if g:gitgutter_enabled
                highlight GitGutterAdd guifg=#587C0C ctermfg=2
                highlight GitGutterChange guifg=#FABD2F ctermfg=3
                highlight GitGutterDelete guifg=#F04123 ctermfg=1
            endif
        ]]

        wk.register({
            ["<leader>g"] = {
                name = "+Git",
                m = { "<cmd>GitMessenger<CR>", "Show Message" },
                t = { "<cmd>GitGutterToggle<CR>", "Toggle GitGutter" },
                h = {
                    name = "+Hunk",
                    h = { "<cmd>GitGutterPreviewHunk<CR>", "Preview Hunk" },
                    n = { "<cmd>GitGutterNextHunk<CR>", "Next Hunk" },
                    p = { "<cmd>GitGutterPrevHunk<CR>", "Previous Hunk" },
                    u = { "<cmd>GitGutterUndoHunk<CR>", "Undo Hunk" },
                    s = { "<cmd>GitGutterStageHunk<CR>", "Stage Hunk" }
                }
            }
        })

    -- #endregion
    
    -- #region - NvimTree
        
        vim.cmd [[
            let g:nvim_tree_git_hl = 1                  " Enable file highlight for git stuff
            let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
            let g:nvim_tree_special_files = { 'README.md': 1, 'package.json': 1, 'init.lua': 1, 'init.vim': 1 }
            let g:nvim_tree_icons = { 'git': { 'unstaged': "[U]", 'staged': "[S]", 'unmerged': "[UM]", 'renamed': "[R]", 'deleted': "[-]", 'untracked': "[+]" } }

            nnoremap <silent> <Leader>e :NvimTreeToggle<CR>
            nnoremap <silent> <Leader>r :NvimTreeRefresh<CR>
        ]]

        wk.register({
            ["<leader>"] = {
                name = "+WhichKey",
                e = { "<cmd>NvimTreeToggle<CR>", "Toggle NvimTree" },
                r = { "<cmd>NvimTreeRefresh<CR>", "Refresh NvimTree" }
            }
        })

        require'nvim-tree'.setup {
            disable_netrw = true,
            hijack_netrw = true,
            open_on_setup = false,
            ignore_ft_on_setup = {},
            auto_close = false,
            open_on_tab = false,
            update_cwd = false,
            lsp_diagnostics = false,
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

    -- #endregion

-- #region - Vim-Rooter

    vim.cmd('let g:rooter_patterns = [".git"]')

-- #endregion

-- #region - Svelte PlugIn
    
    vim.cmd [[
        let g:svelte_preprocessors = ['typescript', 'scss']
    ]]

-- #endregion

-- #region - Nvim-Treesitter

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

-- #endregion

    -- #region - LspConfig

        -- Docker
        require'lspconfig'.dockerls.setup{}

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

        -- Svelte
        require'lspconfig'.svelte.setup{}

        -- TypeScript
        require'lspconfig'.tsserver.setup{}

        -- VIM
        require'lspconfig'.vimls.setup{}

        -- Vue 2
        require'lspconfig'.vuels.setup{}

        -- Vue 3
        -- Don't use vuels and volar at the same time
        -- With additional configuration you can run volar on Vue 2 projects too
        -- -> https://github.com/johnsoncodehk/volar#using
        -- require'lspconfig'.volar.setup{}
    
    -- #endregion

    -- #region - LspSaga

        require 'lspsaga'.init_lsp_saga()
    
        vim.cmd [[
            " Scroll in those pop-ups
            nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
            nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
        ]]

        wk.register({
            ["<leader>l"] = {
                name = "+LSP",
                f = { "<cmd>Lspsaga lsp_finder<CR>", "Finder" },
                a = { "<cmd>Lspsaga code_action<CR>", "Code action" },
                h = { "<cmd>Lspsaga hover_doc<CR>", "Hover doc" },
                s = { "<cmd>Lspsaga signature_help<CR>", "Signature help" },
                r = { "<cmd>Lspsaga rename<CR>", "Rename" },
                d = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Diagnostics" },
                p = { "<cmd>Lspsaga preview_definition<CR>", "Preview definition" }
            }
        })

    -- #endregion

    -- #region - Compe

        local setKey = vim.api.nvim_set_keymap

        require'compe'.setup {
            enabled = true;
            autocomplete = true;
            debug = false;
            min_length = 1;
            preselect = 'enable';
            throttle_time = 80;
            source_timeout = 200;
            incomplete_delay = 400;
            max_abbr_width = 100;
            max_kind_width = 100;
            max_menu_width = 100;
            documentation = true;
        
            source = {
                path = true;
                buffer = true;
                calc = true;
                vsnip = false;
                nvim_lsp = true;
                nvim_lua = true;
                spell = false;
                tags = true;
                snippets_nvim = true;
                treesitter = false;
            };
        }
        
        setKey('i', '<C-Space>', 'compe#complete()', { silent=true, expr=true })
        setKey('i', '<CR>', 'compe#confirm("<CR>")', { silent=true, expr=true })
    
    -- #endregion

-- #region - Prettier

    wk.register({
        ["<leader>p"] = { "<cmd>Prettier<CR>", "Run Prettier" },
    })

-- #endregion

    -- #region - Colorscheme

        vim.cmd('color tokyonight')

    -- #endregion

-- #endregion

-- #region - Key mappings

    vim.cmd [[
        let mapleader = ' '

        " Exit insert mode
        inoremap jk <ESC>

        " Make moving between windows/panes smoother
        nnoremap <C-j> <C-w>j
        nnoremap <C-k> <C-w>k
        nnoremap <C-l> <C-w>l
        nnoremap <C-h> <C-w>h

        " Terminal window navigation
        tnoremap <C-h> <C-\><C-N><C-w>h
        tnoremap <C-j> <C-\><C-N><C-w>j
        tnoremap <C-k> <C-\><C-N><C-w>k
        tnoremap <C-l> <C-\><C-N><C-w>l

        " Reselect after indentation in visual mode
        vnoremap > >gv
        vnoremap < <gv
        vnoremap <Tab> >gv
        vnoremap <S-Tab> <gv

        " Always leave visual mode on first 'v' instead of double tapping 'v' for visual line
        vnoremap v <Esc>

        " Toggle between absolute line numbers and relative line numbers
        nnoremap + :set rnu!<CR>
        vnoremap + <Esc>:set rnu!<CR>gv

        " Remap search and substitute
        nnoremap s /
        nnoremap S :s/
        vnoremap s :s/

        " Repeat last edit on searched item (with count)
        nnoremap Q @='n.'<CR>

        nnoremap <M-x> :

        " Remap motions to clear search highlighting too
        nnoremap <silent> j j:nohl<CR>
        nnoremap <silent> k k:nohl<CR>
        nnoremap <silent> l l:nohl<CR>
        nnoremap <silent> h h:nohl<CR>
        nnoremap <silent> w w:nohl<CR>
        nnoremap <silent> e e:nohl<CR>
        nnoremap <silent> b b:nohl<CR>
        nnoremap <silent> i :nohl<CR>i
        nnoremap <silent> a :nohl<CR>a

        " Add to space when cursor is between Parentheses, Curlybraces or Brackets
        inoremap <expr> <Space> g:IsCursorWrappedBy("()", "{}", "[]") ? "<Space><Space><Left>" : '<Space>'

        " Remove whole pair
        inoremap <expr> <BS> g:IsCursorWrappedBy("  ", "{}", "()", "[]", "''", '""', "<>") ? "<Left><DEL><DEL>" : "<BS>"

        " Map Ctrl+j, Ctrl+l, Ctrl+k, Ctrl+h to arrow-keys in insert mode
        inoremap <C-k> <Up>
        inoremap <C-l> <Right>
        inoremap <C-j> <Down>
        inoremap <C-h> <Left>

        inoremap <C-e> =
        inoremap <C-u> <C-R>=g:ConfirmSurroundings()<CR><Left>

        " To uppercase mapping which doesn't need the the shift-button
        nnoremap guu gU
        vnoremap guu gU

        " highlight word and every other occassion of that word in document
        nnoremap # *N

        nnoremap <C-p> :call g:SynStack()<CR>

        inoremap <expr> <CR> g:IsCursorWrappedBy("{}") ? "<CR><C-o>O" : "<CR>"

        " Navigating around while using buffers made ez
        nnoremap <expr> <BS> v:count ? ":b " . v:count . "<CR>" : "<BS>"
        nnoremap <Left> :bprev<CR>
        nnoremap <Right> :bnext<CR>

    ]]

-- #endregion

-- #region - Snippets / Abbreviations

    vim.cmd [[
        augroup javascript_abbrevs
            autocmd FileType javascript,typescript,svelte,vue :inoreab afunc@ () => {}<ESC>i<CR><C-o>O<C-R>=g:Eatchar('@')<CR>
            autocmd FileType javascript,typescript,svelte,vue :inoreab nfunc@ function () {}<ESC>i<CR><C-o>?(<CR><C-R>=g:Eatchar('@')<CR>
            autocmd FileType javascript,typescript,svelte,vue :inoreab meth@ () {}<ESC>i<CR><C-o>?(<CR><C-R>=g:Eatchar('@')<CR>
            autocmd FileType javascript,typescript,svelte,vue :inoreab log@ console.log()<Left><C-R>=g:Eatchar('@')<CR>
            autocmd FileType javascript,typescript,svelte,vue :inoreab vlog@ <ESC>^d$aconsole.log("<C-o>p<BS>", <C-o>p<BS>)<C-R>=g:Eatchar('@')<CR>
            autocmd FileType javascript,typescript,svelte,vue :inoreab if@ if() {}<ESC>i<CR><C-o>?)<CR><C-R>=g:Eatchar('@')<CR>
            autocmd FileType javascript,typescript,svelte,vue :inoreab else@ <C-o>/}<CR><Right> else {}<Left><CR><C-o>O<C-R>=g:Eatchar('@')<CR>
            autocmd FileType javascript,typescript,svelte,vue :inoreab elseif@ <C-o>/}<CR><Right> else if() {}<Left><CR><C-o>?)<CR><C-R>=g:Eatchar('@')<CR>
        augroup END

        augroup vue_abbrevs
            autocmd FileType typescript,vue :inoreab vcomp@ <Esc>bdeiimport Vue from "vue";<CR><CR>interface <C-o>pData {}<CR><CR>export const <C-o>p = Vue.extend({<CR>});<C-o>Oname: "<C-o>p",<CR>template: "",<CR>data() {<CR>return {} as <C-o>pData;<CR>},<CR>components: {<CR>},<C-o>?"<CR><C-R>=g:Eatchar('@')<CR>
            autocmd FileType typescript,vue :inoreab vimport@ <Esc>bdeiimport {<C-o>p } from "<ESC>mza/components/<C-o>p";<ESC>/components:<CR>/}<CR>O<C-R>",<ESC>`za<C-R>=g:Eatchar('@')<CR>
        augroup END

        augroup svelte_abbrevs
            autocmd FileType svelte :inoreab sif@ {#if}<CR>{/if}<Esc>?#if}<CR>f}i <C-R>=g:Eatchar('@')<CR>
            autocmd FileType svelte :inoreab selse@ <Esc>/{/if}<CR>O{:else}<CR><C-R>=g:Eatchar('@')<CR>
            autocmd FileType svelte :inoreab rlog@ <ESC>^d$a$: console.log("<C-o>p<BS>", <C-o>p<BS>)<C-R>=g:Eatchar('@')<CR>
        augroup END
    ]]

-- #endregion

-- #region - Statusline

    vim.cmd [[
        
        " Seperator:    
        " Seperator:    

        function! g:GetCurrentBranch()
            return system('git branch --show-current 2>/dev/null | tr -d "\n"')
        endfunction

        function! g:StatusLine(isCurrentBuffer = v:false)
            setl statusline=

            if a:isCurrentBuffer
                " #region - LEFT SIDE
                " Add emote
                setl statusline+=\ Nvim\ \ \ 

                " Add file path head if it's not NvimTree/FileTree
                if expand('%t') != 'NvimTree'
                    setl statusline+=%.40{expand('%:h')}/
                endif

                " Add file name
                " setl statusline+=%#StatusLine#%t
                setl statusline+=%t

                if expand('%t') != 'NvimTree'
                    " Is file modified
                    setl statusline+=\ %m
                endif
                " #endregion

                " #region - RIGHT SIDE
                " Switch to right side
                setl statusline+=%=\ 
                " Add current Git-Branch
                setl statusline+=\ %{GetCurrentBranch()}\ 
                " #endregion
            else
                " #region - LEFT SIDE
                " Add emote
                setl statusline+=\ 👾\ \ \ 
                " Add file name
                setl statusline+=%t
                " #endregion

                " #region - RIGHT SIDE
                " Switch to rightside
                setl statusline+=%=
                " #endregion
            endif
        endfunction

        autocmd WinEnter * call g:StatusLine(v:true)
        autocmd WinLeave * call g:StatusLine()
        autocmd FileType * call g:StatusLine(v:true)

    ]]

-- #endregion

-- #region - Tabline (made to Bufferline)

    vim.cmd [[

        function! g:Bufferline()
            let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && !empty(bufname(v:val))')
            let num = '"%#TabLineSel# " . v:val . '
            let hi = '(v:val == bufnr("%") ? " %#Special# " : " %#TabLine# ") . '
            let bufname = 'fnamemodify(bufname(v:val), ":t") . '
            let mod = '(getbufvar(v:val, "&modified") ? " [+] " : " ")'
            let bufline = join(map(buffers, num . hi . bufname . mod))

            return bufline
        endfunction

        set tabline=%!g:Bufferline()

    ]]

-- #endregion
