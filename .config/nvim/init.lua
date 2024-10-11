Colors = {
    black = "#000000",

    hush = {
        light = "#202733",
        main = "#1d232e",
        dark = "#121c26",
    },

    bright_black = "#535b68",
    bright_black2 = "#393c4d",
    bright_black3 = "#1f2a35",

    red = "#f77172",
    green = "#65a884",
    yellow = "#cec999",
    blue = "#74add2",
    magenta = "#a980c4",
    cyan = "#2d949f",

    white = "#ffffff",
}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath
    })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("nobilissimum.core")
