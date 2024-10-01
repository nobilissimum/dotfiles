return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_pending = " ",
                        package_installed = " ",
                        package_uninstalled = " ",
                    },
                    keymaps = {
                        ["j"] = "k",
                        ["k"] = "j",
                    },
                },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = true,
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- Lua
                    "lua_ls",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })

            if lspconfig.ruff_lsp then
                lspconfig.ruff_lsp.setup({
                    init_options = {
                        settings = {
                            enable = true,
                            organizeImports = true,
                            fixAll = true,
                            lint = {
                                enable = true,
                                run = "onType",
                            },
                        },
                    },
                })
            end
        end,
    },
}
