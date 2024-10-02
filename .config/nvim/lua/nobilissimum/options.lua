-- Number line
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes"

-- Indentions
vim.opt.tabstop = 4
vim.opt.softtabstop = 1
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.breakindent = true

vim.g.have_nerd_font = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 250

vim.opt.scrolloff = 10

vim.opt.mouse = ""

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Movement keymaps
local move_modes = { "n", "v", "s" }
for _, move_mode in pairs(move_modes) do
    vim.keymap.set(move_mode, "j", "k", { noremap = true, silent = true })
    vim.keymap.set(move_mode, "k", "j", { noremap = true, silent = true })
end


-- Diagnostics keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
