return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  config = function()
    local trouble = require("trouble")
    trouble.setup({})

    vim.api.nvim_set_hl(0, "TroubleNormal", { bg = Colors.hush.main })
    vim.api.nvim_set_hl(0, "TroubleNormalNC", { bg = Colors.hush.main })

    vim.api.nvim_set_hl(0, "TroubleCount", { bg = nil })

    vim.api.nvim_create_autocmd("DiagnosticChanged", {
      group = vim.api.nvim_create_augroup("nobilissimum-trouble-autoclose", { clear = true }),
      callback = function()
        if not trouble.is_open() then
          return
        end

        local diagnostics = vim.diagnostic.get(vim.api.nvim_get_current_buf())
        if #diagnostics == 0 then
          vim.cmd("Trouble close")
        end
      end,
    })
  end,
  keys = {
    {
      "<M-t>t",
      "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
      desc = "Diagnostics [T]oggle buffer",
    },
    {
      "<M-t>f",
      "<cmd>Trouble diagnostics filter.buf=0 focus=true<cr>",
      desc = "Diagnostics [F]ocus buffer",
    },
    {
      "<M-t>st",
      "<cmd>Trouble symbols toggle focus=true win.position=bottom<cr>",
      desc = "[S]ymbols [T]oggle",
    },
    {
      "<M-t>sf",
      "<cmd>Trouble symbols focus=true win.position=bottom<cr>",
      desc = "[S]ymbols [F]ocus",
    },
    {
      "<M-t>lt",
      "<cmd>Trouble lsp toggle focus=true<cr>",
      desc = "[L]SP definition and references [T]oggle",
    },
    {
      "<M-t>lf",
      "<cmd>Trouble lsp focus=true<cr>",
      desc = "[L]SP definition and references [F]ocus",
    },
    {
      "<M-t>Lt",
      "<cmd>Trouble loclist toggle focus=true<cr>",
      desc = "Location list [T]oggle",
    },
    {
      "<M-t>Lf",
      "<cmd>Trouble loclist focus=true<cr>",
      desc = "Location list [F]ocus",
    },
    {
      "<M-t>qt",
      "<cmd>Trouble qflist toggle focus=true<cr>",
      desc = "[Q]uickfix list [T]oggle",
    },
    {
      "<M-t>qf",
      "<cmd>Trouble qflist focus=true<cr>",
      desc = "[Q]uickfix list [F]ocus",
    },
  },
}
