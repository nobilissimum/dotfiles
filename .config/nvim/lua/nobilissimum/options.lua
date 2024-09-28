vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 1
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.api.nvim_set_keymap("n", "j", "k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "k", "j", { noremap = true, silent = true })
