return {
    "f-person/git-blame.nvim",
    name = "gitblame",
    config = function ()
        require("gitblame").setup({
            enabled = true,
            delay = 0,

            message_template = "   <<sha>> • <author> • <date> • <summary>",
            date_format = "%r • %Y%m%d:%H%M%S",

            message_when_not_committed = "   Uncommitted change"
        })

        vim.api.nvim_set_hl(0, 'GitBlame', { bg = "#1D232E", fg = "#203A4A" })
    end,
}
