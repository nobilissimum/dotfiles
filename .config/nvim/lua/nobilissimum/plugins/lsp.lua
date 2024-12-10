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

            -- Navigation
            "nvim-telescope/telescope.nvim",

            -- Formatting
            "stevearc/conform.nvim"
        },
        config = function()
            -- Vim diagnostic
            vim.diagnostic.config({
                virtual_text = true,
                signs = false,
                underline = true,
                update_in_insert = true,
            })

            -- LSP keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("nobilissimum-lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                        local highlight_augroup = vim.api.nvim_create_augroup("nobilissimum-lsp-highlight", { clear = false })
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = vim.api.nvim_create_augroup("nobilissimum-lsp-detach", { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({ group = "nobilissimum-lsp-highlight", buffer = event2.buf })
                            end,
                        })
                    end

                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                        map(
                            "<leader>th",
                            function()
                                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                            end,
                            "[T]oggle Inlay [H]ints"
                        )
                    end
                end,
            })

            -- LSP configurations
            local python = require("nobilissimum.lsp.python")
            python.setup()

            -- Mason
            require("mason").setup({
                ui = {
                    icons = {
                        package_pending = " ",
                        package_installed = " ",
                        package_uninstalled = " ",
                    },
                },
            })

            -- LSP configuration
            local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()

            -- CMP configuration
            local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

            local capabilities = vim.tbl_deep_extend("force", lsp_capabilities, cmp_capabilities)

            local server_configurations = {
                -- Lua
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

                -- Python
                pyright = {
                    settings = {
                        pyright = {
                            disableOrganizeImports = true,
                        },
                        python = {
                            analysis = {
                                ignore = { "*" },
                            },
                        },
                    },
                },
                ruff = {
                    cmd = python.get_ruff_cmd(),
                    on_attach = function(client)
                        vim.notify("Attached ruff: " .. vim.inspect(client.config.cmd), vim.log.levels.DEBUG)
                    end,
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
            require("mason-tool-installer").setup({
                ensured_installed = vim.tbl_deep_extend(
                    "force",
                    ensure_installed,
                    {
                        "stylua",
                    }
                ),
            })

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

            -- Formatting
            local conform = require("conform")
            local mason_registry = require("mason-registry")

            local formatters_by_ft = {}
            for _, package in ipairs(mason_registry.get_installed_packages()) do
                if not StringInTable("Formatter", package.spec.categories) then
                    goto continue
                end

                for _, language in ipairs(package.spec.languages) do
                    Upsert(string.lower(language), package.name, formatters_by_ft)
                end

                ::continue::
            end

            conform.setup({
                cmd = "ConformInfo",
                default_format_opts = {
                    lsp_format = "fallback",
                },
                formatters_by_ft = formatters_by_ft,
            })

            vim.api.nvim_create_user_command("FormatBuf", function(opts)
                local formatter = opts.args
                if formatter ~= "" then
                    conform.format({ formatters = { formatter } })
                else
                    conform.format()
                end
            end, {
                nargs = "?",
                complete = function()
                    return conform.list_formatters_for_buffer()
                end,
            })

            vim.keymap.set("n", "<leader>f", conform.format, { desc = "[F]ormat" })
        end,
    },
}
