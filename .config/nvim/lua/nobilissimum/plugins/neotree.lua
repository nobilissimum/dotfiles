return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<C-e>", "<CMD>Neotree toggle<CR>", desc = "Neo-tree toggle", noremap = true, silent = true },
    { "<C-S-e>", "<CMD>Neotree reveal<CR>", desc = "Neo-tree toggle", noremap = true, silent = true },
    { "<M-e>", "<CMD>Neotree reveal<CR>", desc = "Neo-tree reveal", noremap = true, silent = true },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      sort_case_insensitive = false,

      event_handlers = {
        {
          event = "file_open_requested",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        mappings = {
          ["h"] = "close_node",
          ["l"] = "open",
          ["gL"] = function(state)
            local path = state.tree:get_node().path
            local result = vim.system({
              "git", "log", "-1", "--follow",
              "--format=%an <%ae>%n%ad%n%h %s",
              "--date=relative",
              "--", path,
            }, { cwd = vim.fs.dirname(path), text = true }):wait()

            local out = vim.trim(result.stdout or "")
            if result.code ~= 0 or out == "" then
              out = "No git history for this file"
            end
            vim.notify(out, vim.log.levels.INFO, { title = vim.fn.fnamemodify(path, ":t") })
          end,
        },
        position = "current",
      },
      default_component_configs = {
        git_status = {
          symbols = {
            added = "",
            modified = "",
            deleted = "󰇾",
            renamed = "󰁕",

            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "󰏫",
            conflict = "",
          },
        },
      },
    })

    -- Colors
    vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { bg = Colors.hush.main, fg = Colors.blue, bold = true })
    vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = Colors.hush.dark, bold = true })

    vim.api.nvim_set_hl(0, "NeoTreeFileStats", { fg = Colors.bright_black })

    vim.api.nvim_set_hl(0, "NeoTreeFloatNormal", { bg = Colors.hush.main })
    vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { bg = Colors.hush.main, fg = Colors.hush.main })
  end,
}
