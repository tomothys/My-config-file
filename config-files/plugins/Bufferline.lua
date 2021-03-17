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
