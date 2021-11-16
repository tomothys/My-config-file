------------------------------ HELPER ------------------------------
function string_split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch('(.-)' .. delimiter) do
        table.insert(result, match);
    end
    return result;
end
------------------------------ HELPER ------------------------------

------------------------------ CONFIG ------------------------------
local buffer_peek_buf_name = 'Buffer Peek'
local window_width = 40
------------------------------ CONFIG ------------------------------

------------------------------- VARS -------------------------------
local window_id = -1
------------------------------- VARS -------------------------------

----------------------------- FUNCTIONS ----------------------------
function create_buffer_peek_buf()
    local buffer = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buffer, buffer_peek_buf_name)
    return buffer
end

function create_buffer_peek_win()
    local buffer = create_buffer_peek_buf()
    local ui = vim.api.nvim_list_uis()[1]

    local window = vim.api.nvim_open_win(buffer, false, {
        relative = 'editor',
        width = window_width,
        height = ui.height - 6,
        row = 1,
        col = ui.width - 2,
        anchor = 'NE',
        style = 'minimal',
        border = {'┌', '─', '┐', '│', '┘', '─', '└', '│'}
    })

    window_id = window

    return buffer
end

function set_buffer_peek_headline(buffer, headline)
    local headline_string_list = {
        ' ┌' .. string.rep('─', window_width - 4) .. '┐',
        ' │' .. string.rep(' ', ((window_width - 4) / 2) - (string.len(headline) / 2)) .. headline .. string.rep(' ', ((window_width - 4) / 2) - (string.len(headline) / 2)) .. '│',
        ' └' .. string.rep('─', window_width - 4) .. '┘',
        '',
    }

    vim.api.nvim_buf_set_lines(buffer, 0, table.getn(headline_string_list), false, headline_string_list)
end

function get_buffer_peek_buf_list()
    local bufinfolist = vim.fn.getbufinfo({ bufloaded = true, buflisted = true })
    local buflist = {}
    local cwd = vim.fn.getcwd()

    for key,bufinfo in pairs(bufinfolist) do
        local buf_nr = bufinfo.bufnr
        local buf_path = string.sub(bufinfo.name, string.len(cwd) + 1, -1)
        local buf_path_list = string_split(bufinfo.name, '/')
        local buf_name = buf_path_list[#buf_path_list]

        local padding = 6
        local possible_length_for_buf_name = window_width - padding - string.len(': ') - string.len(tostring(buf_nr))
        if string.len(buf_name) > possible_length_for_buf_name then
            buf_name = '... ' .. string.sub(bufinfo.name, 0 - possible_length_for_buf_name + string.len('... '), -1)
        end

        table.insert(buflist, '   ' .. buf_nr .. ': ' .. buf_name)
    end

    return buflist
end

function render_buffer_peek_buf_list()
    local timer = vim.loop.new_timer()
    timer:start(0, 0, vim.schedule_wrap(function()

        local bufnr = vim.fn.bufnr(buffer_peek_buf_name)
        if bufnr ~= -1 then
            local buflist = get_buffer_peek_buf_list()
            local wininfo = vim.fn.getwininfo(window_id)[1]
            vim.api.nvim_buf_set_lines(bufnr, 4, wininfo.height - 4, false, buflist)
        end

        timer:close()
    end))
end

function open_buffer_peek()
    local buffer = create_buffer_peek_win()
    set_buffer_peek_headline(buffer, 'Buffer')
    render_buffer_peek_buf_list()

    vim.cmd('autocmd! WinClosed <buffer=' .. vim.fn.bufnr(buffer) .. '> lua close_buffer_peek()')
    vim.cmd('autocmd! BufEnter,BufDelete * lua render_buffer_peek_buf_list()')
end

function close_buffer_peek()
    local bufnr = vim.fn.bufnr(buffer_peek_buf_name)
    vim.api.nvim_buf_delete(bufnr, { force = true })
    window_id = -1
end

function toggle_buffer_peek()
    if vim.fn.bufnr(buffer_peek_buf_name) ~= -1 then
        close_buffer_peek()
    else
        open_buffer_peek()
    end
end
----------------------------- FUNCTIONS ----------------------------

vim.cmd('command! ToggleBufferPeek lua toggle_buffer_peek()')
