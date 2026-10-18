return {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
        mappings = {
            "<C-u>",
            "<C-d>",
        },
        easing = "linear",
        duration_multiplier = 0.25,
        performance_mode = false,
    },
    config = function(_, opts)
        require("neoscroll").setup(opts)

        local scroll = require("neoscroll.scroll")
        local function reset()
            pcall(scroll.tear_down, scroll)
            scroll.scrolling = false
            scroll.continuous_scroll = false
            scroll.relative_line = 0
            scroll.target_line = 0
        end

        -- Self-heal: scrolling flagged but timer not running = stuck.
        local new_scroll = require("neoscroll").new_scroll
        require("neoscroll").new_scroll = function(...)
            if scroll.scrolling and not scroll.timer:is_active() then
                reset()
            end
            return new_scroll(...)
        end

        vim.api.nvim_create_autocmd({ "BufLeave", "ModeChanged" }, {
            group = vim.api.nvim_create_augroup("NeoscrollReset", {}),
            callback = function()
                if scroll.scrolling then
                    reset()
                end
            end,
        })

        vim.api.nvim_create_user_command("NeoscrollReset", reset, {})
    end,
}
