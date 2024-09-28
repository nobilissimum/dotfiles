return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local telescope = require("telescope.builtin")
        vim.keymap.set("n", "<C-p>", telescope.find_files, { noremap = true, silent = true })
        vim.keymap.set("n", "<C-f>", telescope.live_grep, { noremap = true, silent = true })
    end,
}
