require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local opts = { silent = true, noremap = true }
local gitsigns = require "gitsigns"

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- === LSP (nvim-lspconfig + nvim-cmp) ===
-- Go to definitions, references, hover, etc
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gr", vim.lsp.buf.references, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

-- Diagnostics
map("n", "<leader>d", vim.diagnostic.open_float, opts)

-- === Completion (nvim-cmp) ===
-- Usually mapped inside cmp config, but these help:
map("i", "<C-Space>", function()
  require("cmp").complete()
end, { noremap = true, silent = true })

-- === Debugging (nvim-dap + nvim-dap-ui) ===
map("n", "<F5>", function()
  require("dap").continue()
end, opts)
map("n", "<F10>", function()
  require("dap").step_over()
end, opts)
map("n", "<F11>", function()
  require("dap").step_into()
end, opts)
map("n", "<F12>", function()
  require("dap").step_out()
end, opts)
map("n", "<leader>b", function()
  require("dap").toggle_breakpoint()
end, opts)
map("n", "<leader>B", function()
  require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
end, opts)
map("n", "<leader>dr", function()
  require("dap").repl.open()
end, opts)
map("n", "<leader>du", function()
  require("dapui").toggle()
end, opts)

-- === Git (gitsigns.nvim + fugitive + diffview.nvim + git-conflict.nvim) ===
-- Navigation
map("n", "]c", function()
  if vim.wo.diff then
    return "]c"
  end
  vim.schedule(gitsigns.next_hunk)
  return "<Ignore>"
end, { expr = true })

map("n", "[c", function()
  if vim.wo.diff then
    return "[c"
  end
  vim.schedule(gitsigns.prev_hunk)
  return "<Ignore>"
end, { expr = true })

-- Hunk actions
--map("n", "<leader>hl", gitsigns.stage_hunk, opts)
map("n", "<leader>hs", gitsigns.stage_hunk, opts)
map("n", "<leader>hr", gitsigns.reset_hunk, opts)
map("n", "<leader>hS", gitsigns.stage_buffer, opts)
map("n", "<leader>hu", gitsigns.undo_stage_hunk, opts)
map("n", "<leader>hR", gitsigns.reset_buffer, opts)
map("n", "<leader>hp", gitsigns.preview_hunk, opts)
map("n", "<leader>hb", function()
  gitsigns.blame_line { full = true }
end, opts)
map("n", "<leader>hD", gitsigns.diffthis, opts)
map("n", "<leader>hF", function()
  gitsigns.diffthis "~"
end, opts)

map("n", "<leader>cc", function()
  local message = vim.fn.input("Commit message: ", "")
  if message ~= nil and message ~= "" then
    vim.cmd("silent !git commit -m '" .. vim.fn.escape(message, "'") .. "'")
  else
    print "Commit aborted: No message provided."
  end
end, { noremap = true, silent = true, desc = "Git Commit with Message" })

-- Toggles
map("n", "<leader>tb", gitsigns.toggle_current_line_blame, opts)
map("n", "<leader>td", gitsigns.toggle_deleted, opts)

-- Visual mode mappings
map("v", "<leader>hs", function()
  gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
end, opts)

map("v", "<leader>hr", function()
  gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
end, opts)

-- === Diffview ===
map("n", "<leader>gd", ":DiffviewOpen<CR>", opts)
map("n", "<leader>gD", ":DiffviewClose<CR>", opts)

-- === GitConflict ===
map("n", "<leader>gc", ":GitConflictListQf<CR>", opts)
map("n", "<leader>gh", ":GitConflictChooseHunk<CR>", opts)

-- === Trouble ===
map(
  "n",
  "<leader>xx",
  "<cmd>Trouble diagnostics toggle <cr>",
  vim.tbl_deep_extend("force", opts, { desc = "Diagnostics (Trouble)" })
)

map(
  "n",
  "<leader>xX",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  vim.tbl_deep_extend("force", opts, { desc = "Buffer Diagnostics (Trouble)" })
)

map(
  "n",
  "<leader>cs",
  "<cmd>Trouble symbols toggle focus=false win.size=0.4<cr>",
  vim.tbl_deep_extend("force", opts, { desc = "Symbols (Trouble)" })
)

map(
  "n",
  "<leader>cl",
  "<cmd>Trouble lsp toggle focus=true win.position=right win.size=0.4 <cr>",
  vim.tbl_deep_extend("force", opts, { desc = "LSP Definitions / references / ... (Trouble)" })
)

map(
  "n",
  "<leader>xL",
  "<cmd>Trouble loclist toggle<cr>",
  vim.tbl_deep_extend("force", opts, { desc = "Location List (Trouble)" })
)

map(
  "n",
  "<leader>xQ",
  "<cmd>Trouble qflist toggle<cr>",
  vim.tbl_deep_extend("force", opts, { desc = "Quickfix List (Trouble)" })
)

-- === Buffers ===
map("n", "<leader>bc", ":%bd!|e#|bd!#<CR>", opts)

-- === AI assistant (codeium.nvim) ===

-- === Misc ===
-- Toggle NvimTree (if you use it)
--map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Quick save
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
