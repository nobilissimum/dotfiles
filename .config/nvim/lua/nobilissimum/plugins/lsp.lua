return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            -- Vim options
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = true,
            })

            -- Mason
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

            -- LSP configuration
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            local server_configurations = {
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

            -- LSP installation
            local ensure_installed = vim.tbl_keys(server_configurations or {})

            -- Mason LSP config
            require("mason-lspconfig").setup({
                ensure_installed = ensure_installed,
                handlers = {
                    function(language_server_name)
                        local server_configuration = server_configurations[language_server_name] or {}
                        server_configuration.capabilities = vim.tbl_deep_extend(
                            "force",
                            {},
                            capabilities,
                            server_configuration.capabilities or {}
                        )
                        require("lspconfig")[language_server_name].setup(server_configuration)
                    end,
                },
            })
        end,
    },
}
