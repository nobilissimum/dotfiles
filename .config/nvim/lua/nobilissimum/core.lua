local opts = {}

require("lazy").setup(
    {
        import = "nobilissimum.plugins",
        ui = {
            keymaps = {
                ["j"] = "k",
                ["k"] = "j",
            },
        },
    },
    {
        checker = {
            enabled = true,
            notify = false,
        },
        change_detection = {
            notify = false,
        }
    }
)

require("nobilissimum.options")
