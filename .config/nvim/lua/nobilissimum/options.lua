vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 1
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.autoindent = true

local move_modes = { "n", "v", "s" }
for _, move_mode in pairs(move_modes) do
    vim.api.nvim_set_keymap(move_mode, "j", "k", { noremap = true, silent = true })
    vim.api.nvim_set_keymap(move_mode, "k", "j", { noremap = true, silent = true })
end

vim.g.have_nerd_font = true

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250

vim.opt.scrolloff = 10

vim.opt.mouse = ""

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
