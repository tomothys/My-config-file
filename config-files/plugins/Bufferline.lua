local setKey = vim.api.nvim_set_keymap

require'bufferline'.setup{
    options = {
        view = "default",
        numbers = "ordinal",
        number_style = "",
        mappings = false,
        buffer_close_icon= "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 40,
        max_prefix_length = 15, -- prefix used when a buffer is deduplicated
        tab_size = 20,
        diagnostics = false,
        diagnostics_indicator = function(count, level)
            return "("..count..")"
        end,
        show_buffer_close_icons = false,
        show_tab_indicators = true,
        persist_buffer_sort = false,
        -- separator_style = "slant" | "thick" | "thin" | { '▊', '▊' }
        separator_style = "",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = "",
    }
}

-- Make moving between buffers a nicer experience
setKey('n', '<Tab>', ':BufferLineCycleNext<CR>', {silent = true})
setKey('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', {silent = true})

vim.cmd('let g:which_key_map.b = { "name": "+Buffermenu" }')

-- Jump to buffer
vim.cmd('let g:which_key_map.b.b = "Jump to buffer"')
setKey('n', '<Leader>bb', ':BufferLinePick<CR>', {silent = true})

-- Close buffers
vim.cmd('let g:which_key_map.b.d = "Close buffers"')
setKey('n', '<Leader>bd', ':bd!<CR>', {silent = true})

-- Sort buffers
vim.cmd('let g:which_key_map.b.o = { "name": "+order" }')
vim.cmd('let g:which_key_map.b.o.l = "by language"')
setKey('n', '<Leader>bol', ':BufferLineSortByExtension!<CR>', {silent = true})
vim.cmd('let g:which_key_map.b.o.d = "by directory"')
setKey('n', '<Leader>bod', ':BufferLineSortByDirectory!<CR>', {silent = true})

-- Move buffers
vim.cmd('let g:which_key_map.b.m = { "name": "+move" }')
vim.cmd('let g:which_key_map.b.m.n = "to next tab position"')
setKey('n', '<Leader>bmn', ':BufferLineMoveNext<CR>', {silent = true})
vim.cmd('let g:which_key_map.b.m.p = "to previous tab position"')
setKey('n', '<Leader>bmp', ':BufferLineMovePrev<CR>', {silent = true})
