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
        require("telescope").setup({
            defaults = {
                mappings = {
                    n = {
                        ["j"] = require("telescope.actions").move_selection_previous,
                        ["k"] = require("telescope.actions").move_selection_next,
                    },
                },
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
                find_files = {
                    hidden = true,
                },
            },
        })

        require("telescope").load_extension("fzf")

        local telescope = require("telescope.builtin")
        vim.keymap.set("n", "<C-p>", telescope.find_files, { noremap = true, silent = true })
        vim.keymap.set("n", "<C-f>", telescope.live_grep, { noremap = true, silent = true })
    end,
}
