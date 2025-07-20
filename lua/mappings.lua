require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local opts = { silent = true, noremap = true }
local gitsigns = require "gitsigns"

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- === LSP (nvim-lspconfig + nvim-cmp) ===
-- Go to definitions, references, hover, etc
map("n", "gd", vim.lsp.buf.definition, { silent = true, noremap = true, desc = "Go to Definition" })
map("n", "gr", vim.lsp.buf.references, { silent = true, noremap = true, desc = "Go to References" })
map("n", "K", vim.lsp.buf.hover, { silent = true, noremap = true, desc = "Hover Documentation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { silent = true, noremap = true, desc = "Rename Symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true, noremap = true, desc = "Code Actions" })

-- Diagnostics
map("n", "<leader>d", vim.diagnostic.open_float, { silent = true, noremap = true, desc = "Open Diagnostics Float" })

-- === Completion (nvim-cmp) ===
-- Usually mapped inside cmp config, but these help:
map("i", "<C-Space>", function()
  require("cmp").complete()
end, { noremap = true, silent = true })

-- === Debugging (nvim-dap + nvim-dap-ui) ===
map("n", "<F5>", function()
  require("dap").continue()
end, { silent = true, noremap = true, desc = "Start/Continue Debugging" })
map("n", "<F10>", function()
  require("dap").step_over()
end, { silent = true, noremap = true, desc = "Step Over" })
map("n", "<F11>", function()
  require("dap").step_into()
end, { silent = true, noremap = true, desc = "Step Into" })
map("n", "<F12>", function()
  require("dap").step_out()
end, { silent = true, noremap = true, desc = "Step Out" })
map("n", "<leader>b", function()
  require("dap").toggle_breakpoint()
end, { silent = true, noremap = true, desc = "Toggle Breakpoint" })
map("n", "<leader>B", function()
  require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { silent = true, noremap = true, desc = "Set Conditional Breakpoint" })
map("n", "<leader>dr", function()
  require("dap").repl.open()
end, { silent = true, noremap = true, desc = "Open Debug REPL" })
map("n", "<leader>du", function()
  require("dapui").toggle()
end, { silent = true, noremap = true, desc = "Toggle Debug UI" })

-- === Git (gitsigns.nvim + fugitive + diffview.nvim + telescope) ===
-- Telescope Git commands
map("n", "<leader>gs", ":Telescope git_status<CR>", opts)
map("n", "<leader>gc", ":Telescope git_commits<CR>", opts)
map("n", "<leader>gb", ":Telescope git_branches<CR>", opts)
map("n", "<leader>gt", ":Telescope git_stash<CR>", opts)

-- Navigation
map("n", "]h", function()
  if vim.wo.diff then
    return "]h"
  end
  vim.schedule(gitsigns.next_hunk)
  return "<Ignore>"
end, { expr = true })

map("n", "[h", function()
  if vim.wo.diff then
    return "[h"
  end
  vim.schedule(gitsigns.prev_hunk)
  return "<Ignore>"
end, { expr = true })

-- Harpoon
local harpoon = require "harpoon"
map("n", "<leader>th", "<cmd>Telescope harpoon marks<CR>", { desc = "Telescope Harpoon Marks" })
map("n", "<leader>a", function()
  harpoon:list():add()
end, { desc = "Harpoon add file" })
map("n", "<leader>ho", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon toggle menu " })
map("n", "<leader>1", function()
  harpoon:list():select(1)
end, { desc = "Harpoon select 1" })
map("n", "<leader>2", function()
  harpoon:list():select(2)
end, { desc = "Harpoon select 2" })
map("n", "<leader>3", function()
  harpoon:list():select(3)
end, { desc = "Harpoon select 3" })
map("n", "<leader>4", function()
  harpoon:list():select(4)
end, { desc = "Harpoon select 4" })
map("n", "<leader>hp", function()
  harpoon:list():prev()
end, { desc = "Harpoon select prev" })
map("n", "<leader>hn", function()
  harpoon:list():next()
end, { desc = "Harpoon  select next" })

-- Hunk actions
map("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", opts)
map("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", opts)
map("n", "<leader>hS", ":Gitsigns stage_buffer<CR>", opts)
map("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", opts)
map("n", "<leader>hR", ":Gitsigns reset_buffer<CR>", opts)
map("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", opts)
map("n", "<leader>hb", function()
  blame_line { full = true }
end, { silent = true, noremap = true, desc = "Git Blame Line" })
map("n", "<leader>hD", ":Gitsigns diffthis<CR>", opts)
map("n", "<leader>hF", function()
  gitsigns.diffthis "~"
end, { silent = true, noremap = true, desc = "Git Diff with HEAD" })

map("n", "<leader>cc", function()
  local message = vim.fn.input("Commit message: ", "")
  if message ~= nil and message ~= "" then
    vim.cmd("silent !git commit -m '" .. vim.fn.escape(message, "'") .. "'")
  else
    print "Commit aborted: No message provided."
  end
end, { noremap = true, silent = true, desc = "Git Commit with Message" })

-- Toggles
map(
  "n",
  "<leader>tb",
  gitsigns.toggle_current_line_blame,
  { silent = true, noremap = true, desc = "Toggle Line Git Blame" }
)
map("n", "<leader>td", gitsigns.toggle_deleted, { silent = true, noremap = true, desc = "Toggle Deleted Lines" })
map("n", "<leader>ts", gitsigns.toggle_signs, { silent = true, noremap = true, desc = "Toggle Git Signs" })

-- Visual mode mappings
map("v", "<leader>hs", function()
  gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { silent = true, noremap = true, desc = "Stage Visual Hunk" })

map("v", "<leader>hr", function()
  gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { silent = true, noremap = true, desc = "Reset Visual Hunk" })

-- === Diffview ===
map("n", "<leader>gd", ":DiffviewOpen<CR>", opts)
map("n", "<leader>gD", ":DiffviewClose<CR>", opts)

-- === Trouble ===
map(
  "n",
  "<leader>xx",
  "<cmd>Trouble diagnostics toggle <cr>",
  { silent = true, noremap = true, desc = "Diagnostics (Trouble) All" }
)

map(
  "n",
  "<leader>xX",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { silent = true, noremap = true, desc = "Diagnostics (Trouble) - Current Buffers" }
)

map(
  "n",
  "<leader>cs",
  "<cmd>Trouble symbols toggle focus=false win.size=0.4<cr>",
  { silent = true, noremap = true, desc = "Symbols (Trouble)" }
)

map(
  "n",
  "<leader>cl",
  "<cmd>Trouble lsp toggle focus=true win.position=right win.size=0.4 <cr>",
  { silent = true, noremap = true, desc = "LSP (Trouble)" }
)

map(
  "n",
  "<leader>xL",
  "<cmd>Trouble loclist toggle<cr>",
  { silent = true, noremap = true, desc = "Location List (Trouble)" }
)

map(
  "n",
  "<leader>xQ",
  "<cmd>Trouble qflist toggle<cr>",
  { silent = true, noremap = true, desc = "Quickfix List (Trouble)" }
)

-- === Buffers ===
map(
  "n",
  "<leader>bc",
  ":%bd!|e#|bd!#<CR>",
  { silent = true, noremap = true, desc = "Close all buffers except current" }
)
map("n", "<leader>rb", ":ToggleAdjustWidth<CR>", { silent = true, noremap = true, desc = "Adjust Buffer Width" })

-- === AI assistant (codeium.nvim) ===

-- === Misc ===
-- Toggle NvimTree (if you use it)
--map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
--

-- Global toggle variable
vim.g.diagnostics_visible = true

-- Toggle function
function _G.toggle_diagnostics()
  vim.g.diagnostics_visible = not vim.g.diagnostics_visible
  if vim.g.diagnostics_visible then
    vim.diagnostic.show()
    print "Diagnostics: ON"
  else
    vim.diagnostic.hide()
    print "Diagnostics: OFF"
  end
end

-- Example mapping: <leader>td to toggle diagnostics
map("n", "<leader>tx", toggle_diagnostics, { silent = true, noremap = true, desc = "Toggle Diagnostics" })

-- Quick save
map("n", "<leader>w", ":w<CR>", { silent = true, noremap = true, desc = "Save File" })
map("n", "<leader>q", ":q<CR>", { silent = true, noremap = true, desc = "Quit" })

-- NvChad Mappings
map("n", "<C-Left>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-Right>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-Down>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-Up>", "<C-w>k", { desc = "switch window up" })

-- Unmap NvChad default window navigation
vim.schedule(function()
  pcall(vim.keymap.del, "n", "<C-h>")
  pcall(vim.keymap.del, "n", "<C-j>")
  pcall(vim.keymap.del, "n", "<C-k>")
  pcall(vim.keymap.del, "n", "<C-l>")
  pcall(vim.keymap.del, "n", "<leader>h")
  pcall(vim.keymap.del, "n", "<leader>v")
end)
