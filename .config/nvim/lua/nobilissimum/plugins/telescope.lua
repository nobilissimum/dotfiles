return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    config = function()
        require("telescope.pickers.layout_strategies").nobilissimum_horizontal = function(
            setup,
            max_columns,
            max_lines,
            extra
        )
            local layout = require("telescope.pickers.layout_strategies").horizontal(
                setup,
                max_columns,
                max_lines,
                extra
            )

            layout.prompt.title = false
            layout.results.title = false
            layout.preview.title = false

            return layout
        end

        require("telescope.pickers.layout_strategies").nobilissimum_vertical = function(
            setup,
            max_columns,
            max_lines,
            extra
        )
            local layout = require("telescope.pickers.layout_strategies").vertical(
                setup,
                max_columns,
                max_lines,
                extra
            )

            layout.prompt.title = false
            layout.results.title = false
            layout.preview.title = false

            return layout
        end

        local tl_builtin = require("telescope.builtin")
        local tl_actions = require("telescope.actions")

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
                layout_strategy = "nobilissimum_horizontal",
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
            },
            pickers = {
                buffers = {
                    ignore_current_buffer = true,
                    initial_mode = "normal",
                    sort_mru = true,
                },
                find_files = { hidden = true },
                git_commits = {
                    initial_mode = "normal",
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end,
                },
            },
        })

        require("telescope").load_extension("fzf")

        -- Keymaps
        vim.keymap.set("n", "<leader>sh", tl_builtin.help_tags, { desc = "[S]earch [H]elp" })
        vim.keymap.set("n", "<leader>sk", tl_builtin.keymaps, { desc = "[S]earch [K]eymaps" })
        vim.keymap.set("n", "<C-p>", function()
            local width = vim.api.nvim_win_get_width(0)
            local layout = "nobilissimum_horizontal"
            if width < 120 then
                layout = "nobilissimum_vertical"
            end

            tl_builtin.find_files({ layout_strategy = layout })
        end, { desc = "Search files" })
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
        vim.keymap.set("n", "<leader>sd", tl_builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
        vim.keymap.set("n", "<leader>sr", tl_builtin.resume, { desc = "[S]earch [R]esume" })
        vim.keymap.set("n", "<leader>s.", tl_builtin.oldfiles, { desc = "[S]earch recent files ('.' for repeat)" })

        vim.keymap.set("n", "<leader><leader>", tl_builtin.buffers, { desc = "[ ] Find existing buffers" })

        -- Colors
        vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = Colors.hush.main })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = Colors.hush.main, fg = Colors.bright_black })

        vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = Colors.hush.main })
        vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = Colors.hush.main, fg = Colors.bright_black })

        vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = Colors.hush.main })
        vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = Colors.hush.main, fg = Colors.bright_black })

        vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = Colors.hush.dark, bold = true })
        vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { bg = Colors.hush.dark, bold = true })
    end,
}
