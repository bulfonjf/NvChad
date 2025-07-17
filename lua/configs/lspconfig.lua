local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").oninit
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "tailwindcss", "lua_ls" }
--local util = require "lspconfig/util"
vim.lsp.enable(servers)

-- Typescript
lspconfig.ts_ls.setup {
  on_init = on_init,
  capabilities = capabilities,
  on_attach = on_attach,
  -- on_attach = function(_, bufnr)
  --   -- Set up formatting or organize imports on save
  --   vim.api.nvim_create_autocmd("BufWritePre", {
  --     buffer = bufnr,
  --     callback = function()
  --       vim.lsp.buf.code_action {
  --         context = {
  --           only = { "source.removeUnusedImports" },
  --           diagnostics = {},
  --         },
  --         apply = true,
  --       }
  --
  --       vim.cmd "sleep 300m" -- Sleep for 300 milliseconds
  --
  --       vim.lsp.buf.code_action {
  --         context = {
  --           only = { "source.organizeImports" },
  --           diagnostics = {},
  --         },
  --         apply = true,
  --       }
  --     end,
  --   })
  -- end,
}

-- Eslint-lsp
lspconfig.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "typescriptreact", "typescript", "javascriptreact", "javascript" },
}

-- C# (.NET)
lspconfig.omnisharp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
}
