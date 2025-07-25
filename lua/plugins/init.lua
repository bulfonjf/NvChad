return {
  -- Colorscheme
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup {
        -- ...
      }

      vim.cmd "colorscheme github_dark"
    end,
  },
  -- Navigation

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        side = "right",
        width = 30,
        preserve_window_proportions = true,
      },
      renderer = {
        full_name = true,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "harpoon2",
    opts = {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    },
    config = function()
      local harpoon = require "harpoon"
      harpoon.setup()
      -- basic telescope configuration
      --local conf = require("telescope.config").values
      -- local function toggle_telescope(harpoon_files)
      --   local file_paths = {}
      --   for _, item in ipairs(harpoon_files.items) do
      --     table.insert(file_paths, item.value)
      --   end
      --
      --   require("telescope.pickers")
      --     .new({}, {
      --       prompt_title = "Harpoon",
      --       finder = require("telescope.finders").new_table {
      --         results = file_paths,
      --       },
      --       previewer = conf.file_previewer {},
      --       sorter = conf.generic_sorter {},
      --     })
      --     :find()
      -- end

      -- harpoon:extend {
      --   UI_CREATE = function(cx)
      --     vim.keymap.set("n", "<leader>v", function()
      --       harpoon.ui:select_menu_item { vsplit = true }
      --     end, { buffer = cx.bufnr, silent = true, noremap = true, desc = "Harpoon select vsplit" })
      --
      --     vim.keymap.set("n", "<leader>s", function()
      --       harpoon.ui:select_menu_item { split = true }
      --     end, { buffer = cx.bufnr, silent = true, noremap = true, desc = "Harpoon select split" })
      --   end,
      -- }
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "ThePrimeagen/harpoon",
        config = function()
          require("harpoon").setup()
          require("telescope").load_extension "harpoon"
        end,
      },
    },
  },

  -- Commands
  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    config = function()
      local wilder = require "wilder"
      wilder.setup { modes = { ":", "/", "?" } }
      wilder.set_option(
        "renderer",
        wilder.renderer_mux {
          [":"] = wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
            highlights = {
              border = "Normal", -- highlight to use for the border
            },
            left = { " ", wilder.popupmenu_devicons() },
            right = { " ", wilder.popupmenu_scrollbar() },
            -- 'single', 'double', 'rounded' or 'solid'
            -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
            border = "rounded",
          }),
          ["/"] = wilder.wildmenu_renderer {
            highlighter = wilder.basic_highlighter(),
          },
        }
      )
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    enable = false,
    lazy = true,
    config = function()
      vim.o.foldcolumn = "1" -- show fold column
      vim.o.foldlevel = 99
      vim.o.foldenable = true
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"

      require("ufo").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Mason for managing LSPs/formatters
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "jayp0521/mason-nvim-dap.nvim" },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "json",
        "javascript",
        "typescript",
        "tsx",
        "c_sharp",
      },
      highlight = { enable = true },
    },
  },

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
      require("diffview").setup {
        enhanced_diff_hl = true,
        
      }
    end,
  },

  -- Formatting and Linting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  { "nvimtools/none-ls.nvim" },
  --{ "mfussenegger/nvim-lint" },

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
    enabled = false,
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      --
      -- All of these are just the defaults
      --
      enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
      trigger_events = { -- See :h events
        immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
        defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
        cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
      },
      -- function that takes the buffer handle and determines whether to save the current buffer or not
      -- return true: if buffer is ok to be saved
      -- return false: if it's not ok to be saved
      -- if set to `nil` then no specific condition is applied
      condition = nil,
      write_all_buffers = false, -- write all buffers when the current one meets `condition`
      -- Do not execute autocmds when saving
      -- This is what fixed the issues with undo/redo that I had
      -- https://github.com/okuuva/auto-save.nvim/issues/55
      noautocmd = false,
      lockmarks = false, -- lock marks when saving, see `:h lockmarks` for more details
      -- delay after which a pending save is executed (default 1000)
      debounce_delay = 2000,
      -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
      debug = false,
    },
  },
}
