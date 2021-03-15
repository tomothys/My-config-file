local lsp = require('lspconfig')
local servers = { "html", "cssls", "tsserver", "jsonls", "vimls", "yamlls" }

for i = 1, table.getn(servers) do
    lsp[servers[i]].setup{}
end
