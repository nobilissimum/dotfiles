return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
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
    keys = {
        { "<leader>sh", function() require("telescope.builtin").help_tags() end, desc = "[S]earch [H]elp" },
        { "<leader>sk", function() require("telescope.builtin").keymaps() end, desc = "[S]earch [K]eymaps" },
        { "<C-p>", function() require("telescope.builtin").find_files() end, desc = "Search files" },
        {
            "<leader>sp",
            function()
                require("telescope.builtin").find_files({
                    hidden = true,
                    no_ignore = true,
                })
            end,
            desc = "[S]earch files [P]alette",
        },
        { "<leader>ss", function() require("telescope.builtin").builtin() end, desc = "[S]earch [S]elect Telescope" },
        { "<leader>sw", function() require("telescope.builtin").grep_string() end, desc = "[S]earch current [W]ord" },
        { "<leader>sc", function() require("telescope.builtin").git_commits() end, desc = "[S]earch git [C]ommits" },
        { "<C-f>", function() require("telescope.builtin").live_grep() end, desc = "[F]ind live grep" },
        {
            "<leader>sf",
            function()
                require("telescope.builtin").live_grep({
                    additional_args = function()
                        return { "--hidden", "--no-ignore" }
                    end,
                })
            end,
            desc = "[S]earch [F]iles using live grep",
        },
        {
            "<leader>sF",
            function() require("telescope").extensions.live_grep_args.live_grep_args() end,
            desc = "[F]ind live grep with args",
        },
        {
            "<leader>/",
            function() require("telescope.builtin").current_buffer_fuzzy_find() end,
            desc = "Search in current buffer",
        },
        { "<leader>sd", function() require("telescope.builtin").diagnostics() end, desc = "[S]earch [D]iagnostics" },
        { "<leader>sr", function() require("telescope.builtin").resume() end, desc = "[S]earch [R]esume" },
        {
            "<leader>s.",
            function() require("telescope.builtin").oldfiles() end,
            desc = "[S]earch recent files ('.' for repeat)",
        },
        {
            "<C-Space>",
            function() require("telescope.builtin").buffers() end,
            desc = "[ ] Find existing buffers",
        },
        { "<leader>pr", function() require("nobilissimum.telescope").lazy_plugins_picker() end, desc = "[P]lugin [R]eload lazy a plugin" },
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

        local tl_actions = require("telescope.actions")

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

        -- Colors
        vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = Colors.hush.main })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = Colors.hush.main, fg = Colors.bright_black })

        vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = Colors.hush.main })
        vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = Colors.hush.main, fg = Colors.bright_black })

        vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = Colors.hush.main })
        vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = Colors.hush.main, fg = Colors.bright_black })

        vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = Colors.hush.dark, bold = true })
        vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { bg = Colors.hush.dark, bold = true })

        vim.api.nvim_set_hl(0, "TelescopeCustomResultsIdentifier", { fg = Colors.blue, bold = true })
        vim.api.nvim_set_hl(0, "TelescopeCustomResultsIdentifierAlt", { fg = Colors.cyan })
    end,
}
