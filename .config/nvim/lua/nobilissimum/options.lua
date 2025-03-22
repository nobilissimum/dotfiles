-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.lazy_lock_disabled = true


-- Number line
vim.opt.number = true
vim.opt.relativenumber = true
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
vim.keymap.set(
    "n",
    "<Esc>",
    function()
        vim.cmd("stopinsert")
        vim.cmd("nohlsearch")
    end
)


-- Diagnostics keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })


-- Copy keymaps
vim.keymap.set(
    "n",
    "<leader>yb",
    function()
        local relative_path = vim.fn.expand("%")
        if relative_path == "" then
            vim.notify("Buffer is empty", vim.log.levels.WARN)
            return
        end

        vim.fn.setreg("+", relative_path)
        vim.notify("Copied relative path of current buffer", vim.log.levels.INFO)
    end,
    { desc = "[Y]ank [B]uffer filename" }
)


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
