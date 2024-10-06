return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            sort_case_insensitive = false,

            event_handlers = {
                {
                    event = "file_open_requested",
                    handler = function()
                        require("neo-tree.command").execute({ action = "close" })
                    end,
                },
            },
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
            window = {
                position = "right",
            },
            default_component_configs = {
                git_status = {
                    symbols = {
                        added = "",
                        modified = "",
                        deleted = "󰇾",
                        renamed = "󰁕",

                        untracked = "",
                        ignored = "",
                        unstaged = "",
                        staged = "󰏫",
                        conflict = "",
                    },
                },
            },
        })

        vim.keymap.set("n", "<C-\\>", ":Neotree toggle<CR>", { noremap = true, silent = true })
    end,
}
