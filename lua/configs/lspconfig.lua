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
  cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp.dll" },
settings = {
      FormattingOptions = {
        -- Enables support for reading code style, naming convention and analyzer
        -- settings from .editorconfig.
        EnableEditorConfigSupport = true,
        -- Specifies whether 'using' directives should be grouped and sorted during
        -- document formatting.
        OrganizeImports = nil,
      },
      MsBuild = {
        -- If true, MSBuild project system will only load projects for files that
        -- were opened in the editor. This setting is useful for big C# codebases
        -- and allows for faster initialization of code navigation features only
        -- for projects that are relevant to code that is being edited. With this
        -- setting enabled OmniSharp may load fewer projects and may thus display
        -- incomplete reference lists for symbols.
        LoadProjectsOnDemand = nil,
      },
      RoslynExtensionsOptions = {
        -- Enables support for roslyn analyzers, code fixes and rulesets.
        EnableAnalyzersSupport = nil,
        -- Enables support for showing unimported types and unimported extension
        -- methods in completion lists. When committed, the appropriate using
        -- directive will be added at the top of the current file. This option can
        -- have a negative impact on initial completion responsiveness,
        -- particularly for the first few completion sessions after opening a
        -- solution.
        EnableImportCompletion = nil,
        -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
        -- true
        AnalyzeOpenDocumentsOnly = nil,
      },
      Sdk = {
        -- Specifies whether to include preview versions of the .NET SDK when
        -- determining which version to use for project loading.
        IncludePrereleases = true,
      },
    },
  --enable_roslyn_analyzers = true,
  --organize_imports_on_format = true,
}


