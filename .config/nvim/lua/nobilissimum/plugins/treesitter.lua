return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",  -- "main" is a rewrite that needs nvim 0.12+ and has no nvim-treesitter.configs
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "c",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "rust",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
            ignore_install = {},
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
        })
    end,
}
