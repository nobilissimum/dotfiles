return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local padding = "     "

        local gitsigns = require("gitsigns")
        gitsigns.setup({
            signs = {
                add = { text = "▌" },
                change = { text = "▌" },
            },
            signs_staged = {
                add = { text = "▌" },
                change = { text = "▌" },
            },
            culhl = true,
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 0,
                ignore_whitespace = true,
                use_focus = true,
            },
            current_line_blame_formatter_nc = padding .. "Uncommitted change",
            current_line_blame_formatter = padding .. "<abbrev_sha> • <author> • <author_time:%R> - <author_time:%Y%m%d:%H%M%S> • <summary>",

            on_attach = function(bufnr)
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal { "]c", bang = true }
                    else
                        gitsigns.nav_hunk "next"
                    end
                end, { desc = "Jump to next git [c]hange" })

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal { "[c", bang = true }
                    else
                        gitsigns.nav_hunk "prev"
                    end
                end, { desc = "Jump to previous git [c]hange" })

                -- Actions
                map("v", "<leader>hs", function()
                    gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
                end, { desc = "stage git hunk" })
                map("v", "<leader>hr", function()
                    gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
                end, { desc = "reset git hunk" })

                map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git [s]tage hunk" })
                map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git [r]eset hunk" })
                map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Git [S]tage buffer" })
                map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Git [u]ndo stage hunk" })
                map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Git [R]eset buffer" })
                map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git [p]review hunk" })
                map("n", "<leader>hb", gitsigns.blame_line, { desc = "Git [b]lame line" })
                map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git [d]iff against index" })
                map(
                    "n",
                    "<leader>hD",
                    function()
                        gitsigns.diffthis "@"
                    end,
                    { desc = "git [D]iff against last commit" }
                )

                map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
                map("n", "<leader>tD", gitsigns.toggle_deleted, { desc = "[T]oggle git show [D]eleted" })
            end,
        })

        local add_color = "#65a884"
        vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = add_color, bold = true })
        vim.api.nvim_set_hl(0, "GitSignsAddCul", { fg = add_color, bg = NumberLineColor, bold = true })

        local change_color = "#74add2"
        vim.api.nvim_set_hl(0, "GitSignsChange", { fg = change_color, bold = true })
        vim.api.nvim_set_hl(0, "GitSignsChangeCul", { fg = change_color, bg = NumberLineColor, bold = true })

        local delete_color = "#f77172"
        vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = delete_color, bold = true })
        vim.api.nvim_set_hl(0, "GitSignsDeleteCul", { fg = delete_color, bg = NumberLineColor, bold = true })

        vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = GhostCharacterColor })
    end,
}
