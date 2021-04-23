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
-- setKey('i', '<C-e>', 'compe#close("<C-e>")', { silent=true, expr=true })
