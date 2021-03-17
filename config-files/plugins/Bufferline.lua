require'bufferline'.setup{
    options = {
        view = "multiwindow",
        numbers = "ordinal",
        number_style = "",
        mappings = true,
        buffer_close_icon= "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 30,
        max_prefix_length = 15, -- prefix used when a buffer is deduplicated
        tab_size = 25,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
            return "("..count..")"
        end,
        show_buffer_close_icons = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        -- separator_style = "slant" | "thick" | "thin" | { '▊', '▊' }
        separator_style = "",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = "directory",
    }
}
