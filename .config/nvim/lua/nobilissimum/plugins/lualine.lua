return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local hush_theme = {
            normal = {
                a = { fg = Colors.hush.dark, bg = Colors.blue, gui = "bold" },
                b = { fg = Colors.white, bg = Colors.bright_black2 },
                c = { fg = Colors.white, bg = Colors.bright_black3 },
                x = { fg = Colors.white, bg = Colors.bright_black2 },
                y = { fg = Colors.white, bg = Colors.bright_black3 },
            },
            command = {
                a = { fg = Colors.hush.dark, bg = Colors.yellow, gui = "bold" },
                b = { fg = Colors.white, bg = Colors.bright_black2 },
                x = { fg = Colors.white, bg = Colors.bright_black2 },
                y = { fg = Colors.white, bg = Colors.bright_black3 },
            },
            insert = {
                a = { fg = Colors.hush.dark, bg = Colors.green, gui = "bold" },
                b = { fg = Colors.white, bg = Colors.bright_black2 },
                x = { fg = Colors.white, bg = Colors.bright_black2 },
                y = { fg = Colors.white, bg = Colors.bright_black3 },
            },
            visual = {
                a = { fg = Colors.hush.dark, bg = Colors.magenta, gui = "bold" },
                b = { fg = Colors.white, bg = Colors.bright_black2 },
                x = { fg = Colors.white, bg = Colors.bright_black2 },
                y = { fg = Colors.white, bg = Colors.bright_black3 },
            },
            replace = {
                a = { fg = Colors.hush.dark, bg = Colors.red, gui = "bold" },
                b = { fg = Colors.white, bg = Colors.bright_black2 },
                x = { fg = Colors.white, bg = Colors.bright_black2 },
                y = { fg = Colors.white, bg = Colors.bright_black3 },
            },
            inactive = {
                a = { fg = Colors.white, bg = Colors.hush.dark, gui = "bold" },
                b = { fg = Colors.white, bg = Colors.hush.dark },
                c = { fg = Colors.white, bg = Colors.hush.dark },
                x = { fg = Colors.white, bg = Colors.hush.dark },
                y = { fg = Colors.white, bg = Colors.hush.dark },
            },
        }

        local separator_left = ""
        local separator_right = ""
        local separators = { left = separator_left, right = separator_right }

        -- Git status colors
        vim.api.nvim_set_hl(0, "LualineGitAdded", { fg = Colors.green, bg = Colors.bright_black2, bold = true })
        vim.api.nvim_set_hl(0, "LualineGitModified", { fg = Colors.blue, bg = Colors.bright_black2, bold = true })
        vim.api.nvim_set_hl(0, "LualineGitRemoved", { fg = Colors.red, bg = Colors.bright_black2, bold = true })
        vim.api.nvim_set_hl(0, "LualineGitUntracked", { fg = Colors.magenta, bg = Colors.bright_black2, bold = true })
        vim.api.nvim_set_hl(0, "LualineGitStaged", { fg = Colors.cyan, bg = Colors.bright_black2, bold = true })

        require("lualine").setup({
            options = {
                theme = hush_theme,
                component_separators = { left = '•', right = '•'},
                section_separators = { left = separator_right, right = separator_left },
                globalstatus = true,
            },
            sections = {
                lualine_a = {{ "mode", separator = { right = separator_right } } },
                lualine_b = {
                    "branch",
                    {
                        function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            if not gitsigns then return "" end

                            local added = gitsigns.added or 0
                            local modified = gitsigns.changed or 0
                            local removed = gitsigns.removed or 0
                            local untracked = gitsigns.untracked or 0
                            local staged = gitsigns.staged or 0

                            local diff = {}
                            local diff_sign_separator = " "

                            if added > 0 then
                                table.insert(diff, "%#LualineGitAdded#" .. string.format(" %s", added))
                            end

                            if modified > 0 then
                                local diff_separator = #diff > 0 and diff_sign_separator or ""
                                table.insert(diff, diff_separator .. "%#LualineGitModified#" .. string.format(" %s", modified))
                            end

                            if removed > 0 then
                                local diff_separator = #diff > 0 and diff_sign_separator or ""
                                table.insert(diff, diff_separator .. "%#LualineGitRemoved#" .. string.format("󰇾 %s", removed))
                            end

                            if untracked > 0 then
                                local diff_separator = #diff > 0 and diff_sign_separator or ""
                                table.insert(diff, diff_separator .. "%#LualineGitUntracked#" .. string.format(" %s", untracked))
                            end

                            if staged > 0 then
                                local diff_separator = #diff > 0 and diff_sign_separator or ""
                                table.insert(diff, diff_separator .. "%#LualineGitStaged#" .. string.format("󰏫 %s", staged))
                            end

                            return table.concat(diff)
                        end,
                        color = {},
                        icons_enabled = true,
                    },
                    "diagnostics",
                },
                lualine_c = {{ "filename", path = 1 }},
                lualine_x = {
                    {
                        "encoding",
                        padding = { left = 1, right = 2 },
                        separator = separators,
                    },
                    {
                        "fileformat",
                        separator = separators,
                        symbols = {
                            unix = "LF",
                            dos = "CRLF",
                            mac = "CR",
                        }
                    },
                    {
                        "filetype",
                        padding = { left = 2, right = 1 },
                        separator = separators,
                    },
                },
                lualine_y = { "progress" },
                lualine_z = {{
                    "location",
                    padding = { left = 0, right = 1 },
                    separator = { left = separator_left },
                }},
            },
        })
    end,
}
