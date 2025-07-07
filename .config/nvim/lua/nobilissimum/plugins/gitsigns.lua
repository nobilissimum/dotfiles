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
            current_line_blame_formatter_nc = function()
                return {
                    { padding },
                    { "", "GitSignsCurrentLineBlameBg" },
                    { " ● ", "GitSignsCurrentLineBlame" },
                    { "Uncommited change", "GitSignsCurrentLineBlame" },
                    { " ", "GitSignsCurrentLineBlame" },
                    { "", "GitSignsCurrentLineBlameBg" },
                }
            end,
            current_line_blame_formatter = function(_, blame_info)
                local time = os.date("%Y%m%d:%H%M%S", blame_info.author_time)
                return {
                    { padding },
                    { "", "GitSignsCurrentLineBlameBg" },
                    { " ● ", "GitSignsCurrentLineBlame" },
                    { blame_info.abbrev_sha, "GitSignsCurrentLineBlameEmp" },
                    {
                        " • " .. blame_info.committer .. " • " .. time .. " • " .. blame_info.summary,
                        "GitSignsCurrentLineBlame",
                    },
                    { " ", "GitSignsCurrentLineBlame" },
                    { "", "GitSignsCurrentLineBlameBg" },
                }
            end,

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

                map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git [p]review hunk" })

                map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Git [S]tage buffer" })
                map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git [s]tage hunk" })

                map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Git [R]eset buffer" })
                map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git [r]eset hunk" })

                map(
                    "n",
                    "<leader>hD",
                    function()
                        gitsigns.diffthis "@"
                    end,
                    { desc = "git [D]iff against last commit" }
                )

                map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
                map("n", "<leader>tD", gitsigns.preview_hunk_inline, { desc = "[T]oggle git show [D]eleted" })
            end,
        })

        local copy_line_commit_hash = function()
            local line = vim.api.nvim_win_get_cursor(0)[1]


            local blame_cmd = string.format("git blame -l %s -L %d,%d | awk '{print $1}'", vim.fn.expand('%:p'), line, line)
            local result = vim.fn.systemlist(blame_cmd)

            if #result > 0 then
                local commit_hash = result[1]
                if commit_hash then
                    vim.fn.setreg('+', commit_hash)
                    vim.notify('Copied commit hash: ' .. commit_hash)
                else
                    vim.notify('Could not extract commit hash', vim.log.levels.WARN)
                end
            else
                vim.notify('Git blame failed', vim.log.levels.WARN)
            end
        end
        vim.keymap.set('n', '<leader>hy', copy_line_commit_hash, { desc = "Git commit hash [Y]ank" })

        -- Git signs
        local add_color = Colors.green
        vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = add_color, bold = true })
        vim.api.nvim_set_hl(0, "GitSignsAddCul", { fg = add_color, bg = Colors.hush.dark, bold = true })

        local change_color = Colors.blue
        vim.api.nvim_set_hl(0, "GitSignsChange", { fg = change_color, bold = true })
        vim.api.nvim_set_hl(0, "GitSignsChangeCul", { fg = change_color, bg = Colors.hush.dark, bold = true })

        local delete_color = Colors.red
        vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = delete_color, bold = true })
        vim.api.nvim_set_hl(0, "GitSignsDeleteCul", { fg = delete_color, bg = Colors.hush.dark, bold = true })

        vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = Colors.blue, bg = Colors.cyan_dark })
        vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlameEmp", { fg = Colors.blue, bg = Colors.cyan_dark, bold = true })
        vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlameBg", { fg = Colors.cyan_dark, bg = nil })
    end,
}
