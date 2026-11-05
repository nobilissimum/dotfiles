return {
  {
    "Exafunction/windsurf.vim",
    event = "InsertEnter",
    init = function()
      vim.g.codeium_disable_bindings = 1
    end,
    config = function()
      local keymaps = {
        prev_comp = "<M-]>",
        next_comp = "<M-[>",
        trigger = "<M-Bslash>",
        accept_word = "<M-l>",
        accept_line = "<M-j>",
      }
      local uname = F.get_uname()
      if uname == "Darwin" then
        keymaps["prev_comp"] = "‘"
        keymaps["next_comp"] = "“"
        keymaps["trigger"] = "«"
        keymaps["accept_word"] = "¬"
        keymaps["accept_line"] = "∆"
      end

      vim.keymap.set("i", "<C-]>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", keymaps.prev_comp, function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", keymaps.next_comp, function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })

      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", keymaps.trigger, function()
        return vim.fn["codeium#Complete"]()
      end, { expr = true, silent = true })

      vim.keymap.set("i", keymaps.accept_word, function()
        return vim.fn["codeium#AcceptNextWord"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", keymaps.accept_line, function()
        return vim.fn["codeium#AcceptNextLine"]()
      end, { expr = true, silent = true })
    end,
  },
}
