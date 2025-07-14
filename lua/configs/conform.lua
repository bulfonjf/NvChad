local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    json = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier", stop_after_first = true },
    javascriptreact = { "prettier", stop_after_first = true },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    tsx = { "prettier" },
    jsx = { "prettier" },
    cs = { "csharpier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
