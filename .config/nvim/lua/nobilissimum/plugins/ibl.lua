return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
        local highlight = {
            "Indent",
            "Indent2",
        }

        vim.api.nvim_set_hl(0, highlight[1], { fg = Colors.bright_black, nocombine = false, bold = true })
        vim.api.nvim_set_hl(0, highlight[2], { fg = Colors.bright_black2_5, nocombine = false, bold = true })

        require("ibl").setup({
            indent = { highlight = highlight, char = "" },
            whitespace = {
                highlight = highlight,
                remove_blankline_trail = true,
            },
            scope = { enabled = false },
        })

        local vim_eol = ""
        local file_format = vim.bo.fileformat
        if file_format == "dos" then
            vim_eol = ""
        else
            vim_eol = "↓"
        end

        vim.opt.listchars = {
            eol = vim_eol,
            nbsp = "+",
            tab = "» ",
            lead = "·",
            space = "·",
            trail = "·",
        }
        vim.opt.list = true
    end,
}
