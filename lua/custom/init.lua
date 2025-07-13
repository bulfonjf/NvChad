-- Enable clipboard support on Windows
if vim.fn.has "win32" == 1 then
  vim.opt.clipboard:append "unnamedplus"
end
