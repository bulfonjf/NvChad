require "nvchad.autocmds"

local toggle_state = {}

function ToggleAdjustWidth()
  local win = vim.api.nvim_get_current_win()
  local win_id = tostring(win)

  -- Restore previous width if toggled back
  if toggle_state[win_id] and toggle_state[win_id].mode == "auto" then
    local previous_width = toggle_state[win_id].previous_width
    if previous_width then
      vim.cmd("vertical resize " .. previous_width)
    end
    toggle_state[win_id] = { mode = "manual" }
    return
  end

  -- Save current width before auto-resizing
  local current_width = vim.api.nvim_win_get_width(win)
  local max_len = 0
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for _, line in ipairs(lines) do
    local len = vim.fn.strdisplaywidth(line)
    if len > max_len then
      max_len = len
    end
  end

  local new_width = math.min(max_len + 2, vim.o.columns)
  vim.cmd("vertical resize " .. new_width)

  toggle_state[win_id] = {
    mode = "auto",
    previous_width = current_width
  }
end

vim.api.nvim_create_user_command("ToggleAdjustWidth", ToggleAdjustWidth, {})
