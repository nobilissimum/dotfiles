return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
        },
        {
            "nvim-telescope/telescope-live-grep-args.nvim" ,
            version = "^1.1.0",
        },
    },
    config = function()
        require("telescope.pickers.layout_strategies").clean_flex = function(...)
            local layout = require("telescope.pickers.layout_strategies").flex(...)

            layout.prompt.title = false
            layout.results.title = false

            if layout.preview then
                layout.preview.title = false
            end

            return layout
        end

        local tl_builtin = require("telescope.builtin")
        local tl_actions = require("telescope.actions")

        local tl_lga = require("telescope").extensions.live_grep_args
        local tl_lga_actions = require("telescope-live-grep-args.actions")


        require("telescope").setup({
            defaults = {
                layout_config = {
                    prompt_position = "top",
                    width = function(_, max_columns)
                        return max_columns
                    end,
                    height = function(_, max_lines)
                        return max_lines
                    end,
                },
                layout_strategy = "clean_flex",
                sorting_strategy = "ascending",

                border = true,

                entry_prefix = "    ",
                prompt_prefix = " ",
                selection_caret = "  • ",

                mappings = {
                    i = {
                        ["<C-d>"] = tl_actions.delete_buffer,
                    },
                    n = {
                        ["<C-d>"] = tl_actions.delete_buffer,
                        ["dd"] = tl_actions.delete_buffer,
                        ["y"] = function()
                            local selection = require("telescope.actions.state").get_selected_entry()
                            if selection then
                                vim.fn.setreg('"', selection.value)
                                vim.notify("Copied commit hash to default register")
                            end
                        end,
                        ['"+y'] = function()
                            local selection = require("telescope.actions.state").get_selected_entry()
                            if selection then
                                vim.fn.setreg("+", selection.value)
                                vim.notify("Copied commit hash to OS clipboard")
                            end
                        end,
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                live_grep_args = {
                    auto_quoting = true,
                    mappings = {
                        i = {
                            ["<C-k>"] = tl_lga_actions.quote_prompt(),
                            ["<C-i>"] = tl_lga_actions.quote_prompt({ postfix = " --iglob " }),
                        },
                    },
                    vimgrep_arguments = {
                        "rg",
                        "-uu",
                        -- "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    additional_args = function()
                        return { "--hidden" }
                    end,
                },
            },
            pickers = {
                buffers = {
                    ignore_current_buffer = true,
                    sort_mru = true,
                },
                find_files = { hidden = true },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end,
                },
            },
        })

        require("telescope").load_extension("fzf")
        require("telescope").load_extension("live_grep_args")

        -- Keymaps
        vim.keymap.set("n", "<leader>sh", tl_builtin.help_tags, { desc = "[S]earch [H]elp" })
        vim.keymap.set("n", "<leader>sk", tl_builtin.keymaps, { desc = "[S]earch [K]eymaps" })
        vim.keymap.set("n", "<C-p>", tl_builtin.find_files, { desc = "Search files" })
        vim.keymap.set("n", "<leader>sp", function()
            tl_builtin.find_files({
                hidden = true,
                no_ignore = true,
            })
        end, { desc = "[S]earch files [P]alette", noremap = true, silent = true })
        vim.keymap.set("n", "<leader>ss", tl_builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
        vim.keymap.set("n", "<leader>sw", tl_builtin.grep_string, { desc = "[S]earch current [W]ord" })
        vim.keymap.set("n", "<leader>sc", tl_builtin.git_commits, { desc = "[S]earch git [C]ommits" })
        vim.keymap.set("n", "<C-f>", tl_builtin.live_grep, { desc = "[F]ind live grep" })
        vim.keymap.set("n", "<leader>sf", function()
            tl_builtin.live_grep({
                additional_args = function()
                    return { "--hidden", "--no-ignore" }
                end,
            })
        end, { desc = "[S]earch [F]iles using live grep", noremap = true })
        vim.keymap.set("n", "<leader>sF", tl_lga.live_grep_args, { desc = "[F]ind live grep with args" })
        vim.keymap.set("n", "<leader>/", tl_builtin.current_buffer_fuzzy_find, { desc = "Search in current buffer" })
        vim.keymap.set("n", "<leader>sd", tl_builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
        vim.keymap.set("n", "<leader>sr", tl_builtin.resume, { desc = "[S]earch [R]esume" })
        vim.keymap.set("n", "<leader>s.", tl_builtin.oldfiles, { desc = "[S]earch recent files ('.' for repeat)" })

        vim.keymap.set("n", "<C-Space>", tl_builtin.buffers, { desc = "[ ] Find existing buffers" })

        -- Colors
        vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = Colors.hush.main })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = Colors.hush.main, fg = Colors.bright_black })

        vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = Colors.hush.main })
        vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = Colors.hush.main, fg = Colors.bright_black })

        vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = Colors.hush.main })
        vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = Colors.hush.main, fg = Colors.bright_black })

        vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = Colors.hush.dark, bold = true })
        vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { bg = Colors.hush.dark, bold = true })

        -- Custom commands
        local tl_pickers = require("telescope.pickers")
        local tl_finders = require("telescope.finders")
        local tl_actions_state = require("telescope.actions.state")
        local tl_conf = require("telescope.config").values

        local function lazy_plugins_picker(opts)
            opts = opts or {}

            local lazy = require("lazy")
            local plugins = lazy.plugins()

            -- Convert plugins to a simpler format for display
            local plugin_list = {}
            for _, plugin in ipairs(plugins) do
                table.insert(plugin_list, plugin.name)
            end
            table.sort(plugin_list)

            tl_pickers.new(opts, {
                prompt_title = "Plugins",
                finder = tl_finders.new_table({results = plugin_list}),
                previewer = false,
                sorter = tl_conf.generic_sorter(opts),
                attach_mappings = function(prompt_bufnr)
                    tl_actions.select_default:replace(function()
                        local selection = tl_actions_state.get_selected_entry()
                        tl_actions.close(prompt_bufnr)

                        local plugin_name = selection[1]
                        vim.cmd("Lazy reload " .. plugin_name)
                    end)

                    return true
                end,
            }):find()
        end

        vim.keymap.set(
            "n",
            "<leader>pr",
            function() lazy_plugins_picker() end,
            { desc = "[P]lugin [R]eload lazy a plugin" }
        )
    end,
}
