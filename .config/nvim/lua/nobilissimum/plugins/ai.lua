return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("minuet").setup({
        provider = "gemini",
        provider_options = {
          gemini = {
            model = "gemini-3.5-flash-lite",
            optional = {
              generationConfig = {
                maxOutputTokens = 256,
                thinkingConfig = {
                  thinkingLevel = "minimal",
                },
              },
            },
          },
        },
        virtualtext = {
          auto_trigger_ft = { "*" },
          keymap = {
            accept = "<M-A>",
            accept_line = "<M-a>",
            accept_n_lines = "<M-z>",
            prev = "<M-[>",
            next = "<M-]>",
            dismiss = "<M-e>",
          },
        },
      })
    end,
  },
}
