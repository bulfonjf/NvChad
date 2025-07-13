require("nvchad.configs.lspconfig").defaults()
require("custom.plugins.lspconfig")

local servers = { "html", "cssls","typescript","javascript","typescriptreact","javascriptreact","cs" }

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
