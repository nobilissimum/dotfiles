return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- LSP
            { "mason-org/mason.nvim", config = true },
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Completion
            "saghen/blink.cmp",

            -- Navigation
            "nvim-telescope/telescope.nvim",

            -- Formatting
            "stevearc/conform.nvim",
        },
        config = function()
            -- Vim diagnostic
            vim.diagnostic.config({
                virtual_text = {
                    source = false,
                    prefix = "● ",
                    format = function(diagnostic)
                        local source = diagnostic.source
                        if source then
                            source = "(" .. source .. ") "
                        end

                        local code = diagnostic.code
                        if code then
                            code = code .. " • "
                        end

                        return string.format("%s%s%s", source, code, diagnostic.message)
                    end,
                },
                float = {
                    source = true,
                    border = "rounded",
                },
                signs = false,
                underline = true,
                update_in_insert = true,
            })

            -- LSP keymaps
            vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", { desc = "[L]SP [R]estart" })

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

                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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

                    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
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

            local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
            local cmp_capabilities = require("blink.cmp").get_lsp_capabilities()
            local capabilities = vim.tbl_deep_extend("force", lsp_capabilities, cmp_capabilities)

            local server_configurations = {
                -- JavaScript
                biome = {},

                -- Lua
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                },
                vimls = {},

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
                    { "stylua" }
                ),
            })

            -- Mason LSP config
            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup({
                automatic_installation = true,
                ensure_installed = ensure_installed,
                automatic_enable = ensure_installed,
            })

            local lspconfig = require("lspconfig")
            local installed_servers = mason_lspconfig.get_installed_servers()
            for _, language_server_name in pairs(installed_servers) do
                local server_configuration = server_configurations[language_server_name] or {}
                server_configuration.capabilities = vim.tbl_deep_extend(
                    "force",
                    {},
                    capabilities,
                    server_configuration.capabilities or {}
                )
                lspconfig[language_server_name].setup(server_configuration)
            end

            -- Formatting
            local conform = require("conform")
            local mason_registry = require("mason-registry")

            local formatters_prioritization = {
                typescriptreact = { "biome" },
                javascriptreact = { "biome" },
                typescript = { "biome" },
                javascript = { "biome" },
                json = { "biome" },
                go = { "goimports-reviser" },
                python = { "ruff" },
            }
            local formatter_keys = {}
            for _, tbl in pairs(formatters_prioritization) do
                for _, key in pairs(tbl) do
                    table.insert(formatter_keys, key)
                end
            end

            local installed_packages = {}
            local formatters_by_ft = {}
            for _, package in ipairs(mason_registry.get_installed_packages()) do
                if not F.is_string_in_table("Formatter", package.spec.categories) then
                    goto outer_continue
                end

                table.insert(installed_packages, package.name)
                for _, language in ipairs(package.spec.languages) do
                    local fmt_language = string.lower(language)
                    local priorities = formatters_prioritization[fmt_language]
                    if priorities and F.is_string_in_table(package.name, priorities) then
                        break
                    end

                    F.upsert(fmt_language, package.name, formatters_by_ft)

                    local aliases = LspAlias[fmt_language]
                    if not aliases then
                        goto inner_continue
                    end

                    for _, alias in ipairs(aliases) do
                        F.upsert(alias, package.name, formatters_by_ft)
                    end

                    ::inner_continue::
                end

                ::outer_continue::
            end
            for formatter, packages in pairs(formatters_by_ft) do
                local priorities = formatters_prioritization[formatter]
                if not priorities then
                    goto continue
                end

                local formatters = formatters_by_ft[formatter]
                for _, priority in ipairs(priorities) do
                    if F.is_string_in_table(priority, installed_packages) then
                        table.insert(packages, priority)
                    end
                end
                formatters_by_ft[formatter] = formatters

                ::continue::
            end

            conform.setup({
                cmd = "ConformInfo",
                default_format_opts = {
                    async = true,
                    lsp_format = "fallback",
                    timeout_ms = 20000,
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
    {
        "mfussenegger/nvim-lint",
        opts = {
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        },
        config = function(_, opts)
            N = {}

            local mason_registry = require("mason-registry")

            local linters_by_ft = {}
            for _, package in ipairs(mason_registry.get_installed_packages()) do
                if not F.is_string_in_table("Linter", package.spec.categories) then
                    goto continue_package
                end

                for _, language in ipairs(package.spec.languages) do
                    local lint_language = string.lower(language)
                    F.upsert(lint_language, package.name, linters_by_ft)

                    local aliases = LspAlias[lint_language]
                    if not aliases then
                        goto continue_language
                    end

                    for _, alias in ipairs(aliases) do
                        F.upsert(alias, package.name, linters_by_ft)
                    end

                    ::continue_language::
                end

                ::continue_package::
            end

            local lint = require("lint")
            lint.linters_by_ft = linters_by_ft

            function N.debounce(ms, fn)
                local timer = vim.uv.new_timer()
                return function(...)
                    local argv = { ... }
                    timer:start(ms, 0, function()
                        timer:stop()
                        vim.schedule_wrap(fn)(F.unpack(argv))
                    end)
                end
            end

            function N.lint()
                local linters = lint._resolve_linter_by_ft(vim.bo.filetype)
                linters = vim.list_extend({}, linters)

                if #linters == 0 then
                  vim.list_extend(linters, lint.linters_by_ft["_"] or {})
                end

                vim.list_extend(linters, lint.linters_by_ft["*"] or {})

                local ctx = { filename = vim.api.nvim_buf_get_name(0) }
                ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
                linters = vim.tbl_filter(function(name)
                    local linter = lint.linters[name]
                    -- if not linter then
                    --     vim.notify("Linter " .. name .. " not found", vim.log.levels.WARN, { title = "nvim-lint" })
                    -- end

                     return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
                end, linters)

                if #linters > 0 then
                    -- vim.notify("Linting using " .. vim.inspect(linters), vim.log.levels.INFO, { title = "nvim-lint" })
                    lint.try_lint(linters)
                end
            end

            vim.api.nvim_create_autocmd(opts.events, {
                group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
                callback = N.debounce(100, N.lint),
            })
        end,
    },
    {
        "j-hui/fidget.nvim",
        opts = {
            notification = {
                window = {
                    normal_hl = "FidgetComment",
                    winblend = 0,
                },
            },
        },
    },
    {
        "Exafunction/windsurf.vim",
        event = "BufEnter",
        config = function()
            vim.g.codeium_disable_bindings = 1

            local keymaps = {
                prev_comp =  "<M-]>",
                next_comp = "<M-[>",
                trigger = "<M-Bslash>",
                accept_word = "<M-l>",
                accept_line = "<M-j>",
            }
            local uname = F.get_uname()
            if uname == "Darwin" then
                keymaps["prev_comp"] = "‘"
                keymaps["next_comp"] = "“"
                keymaps["trigger"] = "«"
                keymaps["accept_word"] = "¬"
                keymaps["accept_line"] = "∆"
            end

            vim.keymap.set(
                "i",
                "<C-]>",
                function () return vim.fn['codeium#Clear']() end,
                { expr = true, silent = true }
            )
            vim.keymap.set(
                "i",
                keymaps.prev_comp,
                function () return vim.fn['codeium#CycleCompletions'](1) end,
                { expr = true, silent = true }
            )
            vim.keymap.set(
                "i",
                keymaps.next_comp,
                function () return vim.fn['codeium#CycleCompletions'](-1) end,
                { expr = true, silent = true }
            )

            vim.keymap.set(
                "i",
                "<C-g>",
                function () return vim.fn['codeium#Accept']() end,
                { expr = true, silent = true }
            )
            vim.keymap.set(
                "i",
                keymaps.trigger,
                function () return vim.fn['codeium#Complete']() end,
                { expr = true, silent = true }
            )

            vim.keymap.set(
                "i",
                keymaps.accept_word,
                function () return vim.fn['codeium#AcceptNextWord']() end,
                { expr = true, silent = true }
            )
            vim.keymap.set(
                "i",
                keymaps.accept_line,
                function () return vim.fn['codeium#AcceptNextLine']() end,
                { expr = true, silent = true }
            )
        end,
    },
    {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
        event = "LspAttach",
        config = function()
            local tiny_code_action = require("tiny-code-action")
            require("telescope.pickers.layout_strategies").clean_vertical = function(...)
                local layout = require("telescope.pickers.layout_strategies").vertical(...)

                layout.prompt.title = false
                layout.results.title = false
                layout.preview.title = false

                return layout
            end


            tiny_code_action.setup({
                picker = {
                    "telescope",
                    opts = {
                        layout_strategy = "clean_vertical",
                        layout_config = {},
                    },
                },

            })

            vim.keymap.set({ "n", "x" }, "<leader>ca", tiny_code_action.code_action, { desc = "[C]ode [A]ction" })
        end,
    }
}
