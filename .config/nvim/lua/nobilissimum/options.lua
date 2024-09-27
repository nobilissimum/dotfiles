vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#121c26" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#121c26", fg = "#eeeeee" })

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

vim.opt.listchars = {
    eol = vim_eol,
    nbsp = "+",
    space = "·",
    tab = ">·",
    trail = "·",
}
vim.opt.list = true
