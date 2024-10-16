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


-- Fonts
vim.g.have_nerd_font = true

-- Modes
vim.opt.showmode = false


-- Utilities
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.mouse = ""


-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true


-- Scrolling
vim.opt.scrolloff = 10


-- Other keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Disable arrow keys in normal mode
-- vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set("n", "<up>", '<cmd>echo "Use j to move!!"<CR>')
-- vim.keymap.set("n", "<down>", '<cmd>echo "Use k to move!!"<CR>')


-- Diagnostics keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
