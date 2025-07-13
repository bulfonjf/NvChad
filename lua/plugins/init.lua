return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- DAP Support
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },

  -- Mason for managing LSPs/formatters
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "jayp0521/mason-null-ls.nvim" },
  { "jayp0521/mason-nvim-dap.nvim" },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- Completion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },

  -- QuickFix
  {
    "yorickpeterse/nvim-pqf",
    config = function()
      require("pqf").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {
      focus = true,
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },

  -- Git tools
  { "lewis6991/gitsigns.nvim", opts = {} },
  {
    "sindrets/diffview.nvim",
    lazy = false,
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("diffview").setup()
    end,
  },
  { "tpope/vim-fugitive", event = { "CmdlineEnter *Git*", "DirChanged" } },
  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("pqf").setup {}
    end,
  },

  -- Formatting and Linting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  { "nvimtools/none-ls.nvim" },
  { "mfussenegger/nvim-lint" },

  -- IA assistance
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    lazy = false,
    opts = {
      suggestion = {
        auto_trigger = true,
        debounce = 200,
        keymap = {
          accept = "<S-n>",
          next = "<S-e>",
          prev = "<S-m>",
          dismiss = "<S-h>",
        },
      },
      panel = {
        auto_refresh = true,
      },
      filetypes = {
        ["*"] = true,
        gitcommit = false,
        markdown = false,
      },
    },
    config = function(_, opts)
      local copilot = require "copilot"
      copilot.setup(opts)

      -- Toggle Copilot with <leader>cp
      vim.keymap.set("n", "<leader>cp", function()
        local enabled = not vim.g.copilot_enabled
        vim.g.copilot_enabled = enabled
        if enabled then
          copilot.setup(opts)
          vim.cmd "Copilot enable"
          vim.notify("Copilot enabled", vim.log.levels.INFO)
        else
          vim.cmd "Copilot disable"
          vim.notify("Copilot disabled", vim.log.levels.WARN)
        end
      end, { desc = "Toggle Copilot" })
    end,
  },
  {
    "kiddos/gemini.nvim",
    enabled = true,
    lazy = false,
    opts = {
      completion = { enabled = false },
    },
  },

  -- Auto save
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- Optional: for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- Optional: for lazy loading on trigger events
    opts = {
      -- Your custom configuration for auto-save goes here
      enabled = true, -- Enable autosave on startup
      -- You can customize trigger events, debounce delay, exclusions, etc.
      -- Refer to the plugin's GitHub page for all options:
      -- https://github.com/okuuva/auto-save.nvim#configuration
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
        defer_save = { "TextChanged" },
      },
      condition = function(buf)
        local fn = vim.fn
        local utils = require "auto-save.utils.data"
        -- Don't save for unmodifiable buffers or specific filetypes (e.g., git commit messages)
        if
          fn.getbufvar(buf, "&modifiable") == 1
          and utils.not_in(fn.getbufvar(buf, "&filetype"), { "gitcommit", "NvimTree" })
        then
          return true -- met condition(s), can save
        end
        return false -- can't save
      end,
      debounce_delay = 1000, -- Saves the file at most every 135 milliseconds
      -- Add other options as needed
    },
  },
}
