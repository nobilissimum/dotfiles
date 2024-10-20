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
        require("telescope.pickers.layout_strategies").horizontal_merged = function(
            picker,
            max_columns,
            max_lines,
            layout_config
        )
            local layout = require("telescope.pickers.layout_strategies").horizontal(
                picker,
                max_columns,
                max_lines,
                layout_config
            )

            layout.prompt.title = ""
            layout.prompt.borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

            layout.results.title = ""
            layout.results.borderchars = { "─", "│", "─", "│", "├", "┤", "╯", "╰"  }
            layout.results.line = layout.results.line - 1
            layout.results.height = layout.results.height + 1

            layout.preview.title = ""
            layout.preview.borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰"  }

            return layout
        end

        require("telescope").setup({
            defaults = {
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "top",
                },
                layout_strategy = "horizontal_merged",
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            },
            pickers = {
                buffers = {
                    initial_mode = "normal",
                },
                find_files = {
                    hidden = true,
                    no_ignore = true,
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
        local telescope = require("telescope.builtin")
        vim.keymap.set("n", "<leader>sh", telescope.help_tags, { desc = "[S]earch [H]elp" })
        vim.keymap.set("n", "<leader>sk", telescope.keymaps, { desc = "[S]earch [K]eymaps" })
        vim.keymap.set("n", "<C-p>", telescope.find_files, { desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>ss", telescope.builtin, { desc = "[S]earch [S]elect Telescope" })
        vim.keymap.set("n", "<leader>sw", telescope.grep_string, { desc = "[S]earch current [W]ord" })
        vim.keymap.set("n", "<C-f>", telescope.live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sd", telescope.diagnostics, { desc = "[S]earch [D]iagnostics" })
        vim.keymap.set("n", "<leader>sr", telescope.resume, { desc = "[S]earch [R]esume" })
        vim.keymap.set("n", "<leader>s.", telescope.oldfiles, { desc = "[S]earch recent files ('.' for repeat)" })
        vim.keymap.set("n", "<leader><leader>", telescope.buffers, { desc = "[ ] Find existing buffers" })


        -- Colors
        vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = Colors.hush.main })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = Colors.hush.main, fg = Colors.bright_black })

        vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = Colors.hush.main })
        vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = Colors.hush.main , fg = Colors.bright_black })

        vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = Colors.hush.main })
        vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = Colors.hush.main, fg = Colors.bright_black })

        vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = Colors.hush.dark, bold = true })
        vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { bg = Colors.hush.dark, bold = true })
   end,
}
