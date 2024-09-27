vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 1
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.autoindent = true

local vim_eol = ""
local file_format = vim.bo.fileformat
if file_format == "dos" then
    vim_eol = ""
else
    vim_eol = "↓"
end

print(vim_eol)
vim.opt.listchars = {
    eol = vim_eol,
    nbsp = "+",
    space = "·",
    tab = ">·",
    trail = "·",
}
vim.opt.list = true
