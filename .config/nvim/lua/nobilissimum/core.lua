local opts = {}

require("lazy").setup(
    { import = "nobilissimum.plugins" },
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
