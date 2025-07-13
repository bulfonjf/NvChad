require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.prettier,
    require("null-ls").builtins.diagnostics.eslint,
    require("null-ls").builtins.code_actions.eslint,
    require("null-ls").builtins.formatting.eslint_d,
  },
})

require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    tsx = {"prettier"},
    jsx = {"prettier"},
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    json = { "prettier" },
    cs = { "csharpier" },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.cs" },
  callback = function()
    -- Use conform if you want conform formatters, otherwise null-ls formatter
    require("conform").format({ async = false })
  end,
})
