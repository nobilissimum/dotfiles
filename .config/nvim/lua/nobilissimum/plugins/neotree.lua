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

        -- Colors
        vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { bg = Colors.blue, fg = Colors.black, bold = true })

        vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = Colors.hush.dark })
        vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = Colors.hush.dark })
        vim.api.nvim_set_hl(0, "VertSplit", { bg = Colors.hush.dark, fg = Colors.hush.dark })
        vim.api.nvim_set_hl(0, "WinSeparator", { bg = Colors.hush.dark, fg = Colors.hush.dark })

        vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = Colors.black })
        vim.api.nvim_set_hl(0, "NeoTreeFloatNormal", { bg = Colors.hush.light })
        vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { bg = Colors.hush.light, fg = Colors.hush.light })
    end,
}
