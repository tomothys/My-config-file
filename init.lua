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
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'onsails/lspkind-nvim' -- Adds pictograms to auto-completion pop-ups

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
    ]]

-- #endregion

-- #region - General vim settings

    vim.opt.compatible = false
    vim.opt.path:append({ '**' })
    vim.opt.wildmenu = true
    vim.opt.wildignore:append({ '**/node_modules/**' })
    vim.opt.hidden = true
    vim.opt.wrap = false
    vim.opt.encoding = 'utf-8'
    vim.opt.fileencoding = 'utf-8'
    vim.opt.splitbelow = true
    vim.opt.splitright = true
    vim.opt.conceallevel = 0
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 0
    vim.opt.expandtab = true
    vim.opt.autoindent = true
    vim.opt.smartindent = true
    vim.opt.laststatus = 2
    vim.opt.showtabline = 2
    vim.opt.showmode = false
    vim.opt.number = true
    vim.opt.background = 'dark'
    vim.opt.termguicolors = true
    vim.opt.backup = false
    vim.opt.writebackup = false
    vim.opt.signcolumn = 'yes'
    vim.opt.timeoutlen = 300
    vim.opt.scrolloff = 3
    vim.opt.foldmethod = 'marker'
    vim.opt.foldmarker = { '#region', '#endregion' }
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    vim.opt.ignorecase = true
    vim.opt.inccommand = 'split'
    vim.opt.mouse = 'a'

    vim.cmd [[
        filetype plugin on
        runtime macros/matchit.vim

        syntax enable
        autocmd FileType * set formatoptions-=cro
    	set whichwrap+=<,>,[,]
        set shortmess+=c

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
            },
            triggers = { "<leader>" },
            ignore_missing = true,
            registers = false,
        }

    -- #endregion

    -- #region - FZF
        
        vim.cmd [[
            let $FZF_DEFAULT_OPTS='--layout=reverse'
            let $FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{node_modules/*,.git/*}"'
            let g:fzf_preview_window = ['right:50%', '\']
            let g:fzf_layout = {'window': { 'width': 0.8, 'height': 0.6, 'border': 'rounded', 'yoffset': 0.2 }}
        ]]

        wk.register({
            ["<leader>"] = {
                f = {
                    name = "+File",
                    p = { "<cmd>Files<CR>", "File finder" },
                    s = { "<cmd>DocumentSymbols<CR>", "Document Symbol finder" },
                },
                h = {
                    h = { "<cmd>History<CR>", "File history" },
                    c = { "<cmd>History:<CR>", "Command history" },
                    s = { "<cmd>History/<CR>", "Search history" },
                },
                b = { "<cmd>Buffer<CR>", "Buffer finder" },
                ["7"] = { "<cmd>BLines<CR>", "Search in buffer" },
                m = { "<cmd>Marks<CR>", "Mark finder" },
            },
        })

    -- #endregion

    -- #region - GitGutter / Git-Messenger

        vim.api.nvim_set_var('gitgutter_enabled', 1)
        vim.api.nvim_set_var('gitgutter_map_keys', 1)
        vim.api.nvim_set_var('gitgutter_preview_win_floating', 1)

        vim.api.nvim_set_var('gitgutter_sign_allow_clobber', 1)
        vim.api.nvim_set_var('gitgutter_sign_added', '▎')
        vim.api.nvim_set_var('gitgutter_sign_modified', '▎')
        vim.api.nvim_set_var('gitgutter_sign_removed', '契')
        vim.api.nvim_set_var('gitgutter_sign_removed_first_line', '契')
        vim.api.nvim_set_var('gitgutter_sign_modified_removed', '▎')
        vim.api.nvim_set_var('gitgutter_preview_win_floating', 1)

        vim.cmd [[
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
        
        vim.api.nvim_set_var('nvim_tree_git_hl', 1)
        vim.api.nvim_set_var('nvim_tree_indent_markers', 1)

        vim.cmd [[
            let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
            let g:nvim_tree_special_files = { 'README.md': 1, 'package.json': 1, 'init.lua': 1, 'init.vim': 1 }
            let g:nvim_tree_icons = { 'git': { 'unstaged': "[U]", 'staged': "[S]", 'unmerged': "[UM]", 'renamed': "[R]", 'deleted': "[-]", 'untracked': "[+]" } }
        ]]

        wk.register({
            ["<leader>"] = {
                name = "+WhichKey",
                e = { "<cmd>NvimTreeToggle<CR>", "Toggle NvimTree" },
                r = { "<cmd>NvimTreeRefresh<CR>", "Refresh NvimTree" }
            }
        })

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

    -- #endregion

-- #region - Vim-Rooter

    vim.cmd('let g:rooter_patterns = [".git"]')

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

-- #region - Peakaboo

    vim.api.nvim_set_var('peekaboo_window', 'vert bo 80new')

-- #endregion

    -- #region - LspConfig

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
        require'lspconfig'.sqlls.setup{}

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

        --[[ local setKey = vim.api.nvim_set_keymap

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
        setKey('i', '<CR>', 'compe#confirm("<CR>")', { silent=true, expr=true }) ]]
    
    -- #endregion

-- #region - LspKind

    local lspkind = require('lspkind')

-- #endregion

-- #region - Nvim-Cmp - local lspkind must be set at this point!

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
            ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
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

-- #endregion

-- #region - Prettier

    wk.register({
        ["<leader>p"] = { "<cmd>Prettier<CR>", "Run Prettier" },
    })

-- #endregion

    -- #region - Colorscheme

        vim.g.tokyonight_style = 'night'
        tokyonight_sidebars = { "terminal", "NvimTree" }

        vim.cmd [[
            color tokyonight

            hi BufferNoIndicator guifg=white guibg=#292e42
            hi BufferNoIndicatorInverted guifg=#292e42 guibg=#7aa2f7
            hi FolderPath guifg=#e0af68 guibg=#292e42
            hi GitBranch guifg=#f7768e guibg=#292e42
            hi Folded guibg=#1f2335
            hi LineNr guifg=#3b4261 guibg=#1f2335
            hi SignColumn guibg=#1f2335
            hi GitGutterAdd guibg=#1f2335
            hi GitGutterChange guibg=#1f2335
            hi GitGutterDelete guibg=#1f2335
            exec 'hi TabLineSelInverted guifg=' . synIDattr(hlID('TabLineSel'), 'bg') . ' guibg=#292e42'
            exec 'hi FoldedInverted gui=bold guifg=' . synIDattr(hlID('Folded'), 'bg') . ' guibg=' . synIDattr(hlID('Folded'), 'fg')
        ]]

    -- #endregion

-- #endregion

-- #region - Key mappings

    local set_key = vim.api.nvim_set_keymap;

    vim.api.nvim_set_var('mapleader', ' ')   

    -- Escape insert mode
    set_key('i', 'jk', '<ESC>', { noremap = true })

    -- Escape terminal mode
    set_key('t', '<ESC>', '<C-\\><C-n>', { noremap = true })
    
    -- Make navigating windows/splits smooth af
    set_key('n', '<C-j>', '<C-W>j', { noremap = true })
    set_key('n', '<C-k>', '<C-W>k', { noremap = true })
    set_key('n', '<C-l>', '<C-W>l', { noremap = true })
    set_key('n', '<C-h>', '<C-W>h', { noremap = true })

    -- Terminal window navigation
    set_key('t', '<C-h>', '<C-\\><C-N><C-w>h', { noremap = true })
    set_key('t', '<C-j>', '<C-\\><C-N><C-w>j', { noremap = true })
    set_key('t', '<C-k>', '<C-\\><C-N><C-w>k', { noremap = true })
    set_key('t', '<C-l>', '<C-\\><C-N><C-w>l', { noremap = true })

    -- Reselect after indentation in visual mode
    set_key('v', '>', '>gv', { noremap = true })
    set_key('v', '<', '<gv', { noremap = true })
    set_key('v', '<Tab>', '>gv', { noremap = true })
    set_key('v', '<S-Tab>', '<gv', { noremap = true })

    -- Always leave visual mode on first 'v' instead of double tapping 'v' for visual line
    set_key('v', 'v', '<Esc>', { noremap = true });

    -- Toggle between absolute line numbers and relative line numbers
    set_key('n', '+', ':set rnu!<CR>', { noremap = true })
    set_key('v', '+', '<Esc>:set rnu!<CR>gv', { noremap = true })

    -- Remap search and substitute
    set_key('n', 's', '/', { noremap = true })
    set_key('n', 'S', ':%s/', { noremap = true })
    set_key('v', 's', ':s/', { noremap = true })

    -- Trigger command-mode
    set_key('n', '<Leader>c', ':', { noremap = true })
    set_key('v', '<Leader>c', ':', { noremap = true })

    -- Remap motions to clear search highlighting too
    set_key('n', 'j', 'j:nohl<CR>', { silent = true, noremap = true })
    set_key('n', 'k', 'k:nohl<CR>', { silent = true, noremap = true })
    set_key('n', 'l', 'l:nohl<CR>', { silent = true, noremap = true })
    set_key('n', 'h', 'h:nohl<CR>', { silent = true, noremap = true })
    set_key('n', 'w', 'w:nohl<CR>', { silent = true, noremap = true })
    set_key('n', 'e', 'e:nohl<CR>', { silent = true, noremap = true })
    set_key('n', 'b', 'b:nohl<CR>', { silent = true, noremap = true })
    set_key('n', 'i', ':nohl<CR>i', { silent = true, noremap = true })
    set_key('n', 'a', ':nohl<CR>a', { silent = true, noremap = true })

    -- Add to space when cursor is between Parentheses, Curlybraces or Brackets
    set_key('i', ' ', 'g:IsCursorWrappedBy("()", "{}", "[]") ? "<Space><Space><Left>" : "<Space>"', { expr = true, silent = true, noremap = true })

    -- Remove whole pair
    set_key('i', '<BS>', 'g:IsCursorWrappedBy("  ", "{}", "()", "[]", "\'\'", \'""\', "<>") ? "<Left><DEL><DEL>" : "<BS>"', { expr = true, silent = true, noremap = true })

    -- Map Ctrl+j, Ctrl+l, Ctrl+k, Ctrl+h to arrow-keys in insert mode
    set_key('i', '<C-k>', '<Up>', { noremap = true })
    set_key('i', '<C-l>', '<Right>', { noremap = true })
    set_key('i', '<C-j>', '<Down>', { noremap = true })
    set_key('i', '<C-h>', '<Left>', { noremap = true })

    -- To uppercase mapping which doesn't need the the shift-button
    set_key('n', 'guu', 'gU', { noremap = true })
    set_key('v', 'guu', 'gU', { noremap = true })

    -- Highlight word in document without cursor 'jumping' around
    set_key('n', '#', 'mzyiw0k/<C-R>0<CR>`z', { noremap = true })

    set_key('n', '<C-p>', ':call :SynStack()<CR>', { expr = true, silent = true, noremap = true })

    set_key('i', '<CR>', 'g:IsCursorWrappedBy("{}") ? "<Right><BS><CR>}<C-o>O" : "<CR>"', { expr = true, silent = true, noremap = true })

    -- Navigating around while using buffers made ez
    set_key('n', '<BS>', 'v:count ? ":b " . v:count . "<CR>" : "<BS>"', { expr = true, silent = true, noremap = true })
    set_key('n', '<Left>', ':bprev<CR>', { noremap = true })
    set_key('n', '<Right>', ':bnext<CR>', { noremap = true })

    -- Shortcut to paste last search-result into commands
    set_key('c', '##', '<C-R><C-W>/', { noremap = true })

    -- Make writing those pairs and special characters more convenient
    set_key('i', 'g0', '=', { noremap = true })
    set_key('i', 'g1', '!', { noremap = true })
    set_key('i', 'g+', '``<Left>', { noremap = true })
    set_key('i', 'g2', '""<Left>', { noremap = true })
    set_key('i', 'g4', '$', { noremap = true })
    set_key('i', 'g5', '[]<Left>', { noremap = true })
    set_key('i', 'g6', '&', { noremap = true })
    set_key('i', 'g7', '/', { noremap = true })
    set_key('i', 'g8', '()<Left>', { noremap = true })
    set_key('i', 'g9', '{}<Left>', { noremap = true })
    set_key('i', 'g#', "''<Left>", { noremap = true })
    set_key('i', 'g<', '<><Left>', { noremap = true })
    set_key('i', 'gß', '?', { noremap = true })

-- #endregion

-- #region - Snippets / Abbreviations

    vim.cmd [[
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

        augroup vue_abbrevs
            autocmd FileType javascript,typescript,vue :inoreab vcomp <Esc>bdeiimport Vue from "vue";<CR><CR>interface <C-o>pData {}<CR><CR>export const <C-o>p = Vue.extend({<CR>});<C-o>Oname: "<C-o>p",<CR>template: "",<CR>data(): <C-o>pData {<CR>return {};<CR>},<CR>components: {<CR>},<C-o>?"<CR>
            autocmd FileType javascript,typescript,vue :inoreab vimport <Esc>bdeiimport {<C-o>p } from "<ESC>mza/components/<C-o>p";<ESC>/components:<CR>/}<CR>O<C-R>",<ESC>`za
        augroup END

        augroup svelte_abbrevs
            autocmd FileType svelte :inoreab sif {#if <C-o>ma}<CR>{/if}<C-o>`a
            autocmd FileType svelte :inoreab selse <C-o>/{\/if}<CR><C-o>O{:else}<CR>
            autocmd FileType svelte :inoreab rlog <ESC>bdei$: console.log("<C-o>p"= <C-o>p)
        augroup END
    ]]

-- #endregion

-- #region - Tabline

    vim.cmd [[

        " Seperator:    
        " Seperator:    

        function! g:GetCurrentBranch()
            return system('git branch --show-current 2>/dev/null | tr -d "\n"')
        endfunction

        function! g:Tabline()
            setl tabline=

                """"""""""""
                " LEFT SIDE
                """"""""""""
                " Add emote
                setl tabline+=%#TabLineSel#
                setl tabline+=\ \ 
                setl tabline+=
                setl tabline+=\ \ 
                setl tabline+=%#TabLineSelInverted#
                setl tabline+=
                setl tabline+=\ \ 

                " Add file path head if it's not NvimTree/FileTree
                if expand('%t') != 'NvimTree'
                    setl tabline+=%#FolderPath#
                    setl tabline+=
                    setl tabline+=\ \ 
                    setl tabline+=%#CursorColumn#
                    setl tabline+=
                    setl tabline+=\ 
                    setl tabline+=%#FolderPath#
                    setl tabline+=%.60{expand('%:~')}
                    setl tabline+=%#CursorColumn#
                endif

                """""""""""""
                " RIGHT SIDE
                """""""""""""
                " Switch to right side
                setl tabline+=%=

                if GetCurrentBranch() != ""
                    " Add current Git-Branch
                    setl tabline+=\ 
                    setl tabline+=%#GitBranch#
                    setl tabline+=
                    setl tabline+=\ 
                    setl tabline+=%{GetCurrentBranch()}
                    setl tabline+=\ \ 
                endif
        endfunction

        autocmd WinEnter * call g:Tabline()
        autocmd BufEnter * call g:Tabline()

    ]]

-- #endregion

-- #region - Statusline

    vim.cmd [[

        function! g:Statusline(currentBuffer)
            if a:currentBuffer
                setl statusline=%#BufferNoIndicator#
            else
                setl statusline=%#FoldedInverted#
            endif

            if expand('%') != 'NvimTree'
                setl statusline+=\ \ 
                setl statusline+=%{bufnr('%')}
                setl statusline+=\ \ 
            else
                setl statusline+=\ \ 
                setl statusline+=
                setl statusline+=\ \ 
            endif

            if a:currentBuffer
                setl statusline+=%#BufferNoIndicatorInverted#
            else
                setl statusline+=%#Folded#
            endif

            setl statusline+=\ 

            if a:currentBuffer
                setl statusline+=%#TabLineSel#
            endif

            setl statusline+=\ 
            setl statusline+=%t

            if expand('%') != 'NvimTree'
                setl statusline+=\ 
                setl statusline+=%m
                setl statusline+=\ 
            endif
        endfunction

        autocmd WinEnter * call g:Statusline(v:true)
        autocmd WinLeave * call g:Statusline(v:false)
        autocmd BufEnter * call g:Statusline(v:true)
    ]]

-- #endregion

-- #region - Just a hot-fix for that CursorHold error I'm getting way to often

    vim.cmd [[

        autocmd! CursorHold *
        autocmd! CursorHoldI *

    ]]

-- #endregion
