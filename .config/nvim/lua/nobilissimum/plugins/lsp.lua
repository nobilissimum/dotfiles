return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- LSP
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Code suggestion
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            -- Vim diagnostic
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
            local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()

            -- CMP configuration
            local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

            local capabilities = vim.tbl_deep_extend("force", lsp_capabilities, cmp_capabilities)

            local server_configurations = {
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
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
            vim.list_extend(ensure_installed, { "stylua" })
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

            -- Mason LSP config
            require("mason-lspconfig").setup({
                -- ensure_installed = ensure_installed,
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
