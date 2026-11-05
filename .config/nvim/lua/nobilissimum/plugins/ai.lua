return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local provider = F.env("MINUET_PROVIDER") or "gemini"
      local model = F.env("MINUET_MODEL")
      local max_tokens = F.to_int(F.env("MINUET_MAX_TOKENS")) or 256

      local claude = {
        model = model or "claude-haiku-5-5",
        max_tokens = max_tokens,
      }

      local codestral = {
        model = model or "codestral-latest",
        optional = {
          max_tokens = max_tokens,
        },
      }

      local gemini = {
        model = model or "gemini-3.5-flash-lite",
        optional = {
          generationConfig = {
            maxOutputTokens = max_tokens,
            thinkingConfig = {},
          },
        },
      }
      if provider == "gemini" then
        if not model or vim.starswith(model, "gemini-3") then
          gemini.optional.generationConfig.thinkingConfig.thinkingLevel = "minimal"
        elseif vim.startswith(model, "gemini-2.5") then
          gemini.optional.generationConfig.thinkingConfig.thinkingBudget = 0
        end
      end

      local openai = {
        model = model or "gpt-4o",
        optional = {},
      }
      if provider == "openai" then
        if model and not vim.startswith(model, "gpt-4") then
          openai.optional.max_completion_tokens = max_tokens
        else
          openai.optional.max_tokens = max_tokens
        end
      end

      -- For OpenAI-style APIs (Groq, Cerebras, OpenRouter, Ollama, llama.cpp, ...).
      local compat = {
        model = model,
        end_point = F.env("MINUET_END_POINT"),
        api_key = F.env("MINUET_API_KEY_ENV"),
        name = F.env("MINUET_NAME"),
        optional = {
          max_tokens = max_tokens,
        },
      }

      require("minuet").setup({
        provider = provider,
        provider_options = {
          claude = claude,
          codestral = codestral,
          gemini = gemini,
          openai = openai,
          openai_compatible = compat,
          openai_fim_compatible = vim.deepcopy(compat),
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
