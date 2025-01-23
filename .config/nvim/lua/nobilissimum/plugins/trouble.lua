return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
    keys = {
        {
            "<leader>Dt",
            "<cmd>Trouble diagnostics toggle focus=true<cr>",
            desc = "[D]iagnostics [T]oggle",
        },
        {
            "<leader>Df",
            "<cmd>Trouble diagnostics focus=true<cr>",
            desc = "[D]iagnostics [F]ocus",
        },
        {
            "<leader>dt",
            "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
            desc = "[D]iagnostics [T]oggle buffer",
        },
        {
            "<leader>df",
            "<cmd>Trouble diagnostics filter.buf=0 focus=true<cr>",
            desc = "[D]iagnostics [F]ocus buffer",
        },
        {
            "<leader>cst",
            "<cmd>Trouble symbols toggle focus=true win.position=bottom<cr>",
            desc = "[S]ymbols [T]oggle (Trouble)",
        },
        {
            "<leader>csf",
            "<cmd>Trouble symbols focus=true win.position=bottom<cr>",
            desc = "[S]ymbols [F]ocus (Trouble)",
        },
        {
            "<leader>clt",
            "<cmd>Trouble lsp toggle focus=true<cr>",
            desc = "[L]SP definition and references [T]oggle (Trouble)",
        },
        {
            "<leader>clf",
            "<cmd>Trouble lsp focus=true<cr>",
            desc = "[L]SP definition and references [F]ocus (Trouble)",
        },
        {
            "<leader>xlt",
            "<cmd>Trouble loclist toggle focus=true<cr>",
            desc = "[L]ocation list [T]oggle (Trouble)",
        },
        {
            "<leader>xlf",
            "<cmd>Trouble loclist focus=true<cr>",
            desc = "[L]ocation list [F]ocus (Trouble)",
        },
        {
            "<leader>xqt",
            "<cmd>Trouble qflist toggle focus=true<cr>",
            desc = "[Q]uickfix list [T]oggle (Trouble)",
        },
        {
            "<leader>xqf",
            "<cmd>Trouble qflist focus=true<cr>",
            desc = "[Q]uickfix list [F]ocus (Trouble)",
        },
    },
}
