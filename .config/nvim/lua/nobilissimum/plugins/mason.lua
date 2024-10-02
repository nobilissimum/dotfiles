return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
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

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = true,
            })

            local language_server_configurations = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                },
                ruff_lsp = {
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
                },
            }

            require("mason-lspconfig").setup({
                handlers = {
                    function(language_server_name)
                        local server_configuration = language_server_configurations[language_server_name]
                        if not server_configuration then
                            return
                        end
                        require("lspconfig")[language_server_name].setup(server_configuration)
                    end,
                },
            })
        end,
    },
}
