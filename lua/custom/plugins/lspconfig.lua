local lspconfig = require("lspconfig")

-- JavaScript/TypeScript/React
lspconfig.ts_ls.setup{}

-- Tailwind
lspconfig.tailwindcss.setup{}

-- C# (.NET)
lspconfig.omnisharp.setup{
  cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
}

-- HTML/CSS
lspconfig.html.setup{}
lspconfig.cssls.setup{}
