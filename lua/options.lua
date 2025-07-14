require "nvchad.options"

if vim.fn.has "win32" == 1 then
  vim.opt.clipboard:append "unnamedplus"
end
-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
