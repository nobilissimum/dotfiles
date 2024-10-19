-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "


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


-- Diagnostics keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })


-- Clipboard
vim.g.clipboard = {
    name = "xclip",
    copy = {
        ["+"] = "xclip -selection clipboard",
        ["*"] = "xclip -selection clipboard",
    },
    paste = {
        ["+"] = "xclip -selection clipboard -o",
        ["*"] = "xclip -selection clipboard -o",
    },
    cache_enabled = 0,
}
