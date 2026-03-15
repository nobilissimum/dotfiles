local M = {}

function M.lazy_plugins_picker(opts)
    opts = opts or {}

    local plugins = require("lazy").plugins()

    local plugin_list = {}
    for _, plugin in ipairs(plugins) do
        plugin_list[#plugin_list + 1] = plugin.name
    end
    table.sort(plugin_list)

    require("telescope.pickers")
        .new(opts, {
            prompt_title = "Plugins",
            finder = require("telescope.finders").new_table({
                results = plugin_list,
                entry_maker = function(entry)
                    local name_part, extension = entry:match("^(.*)(%..*)$")

                    if not name_part then
                        name_part = entry
                        extension = ""
                    end

                    return {
                        value = entry,
                        display = function()
                            local display_text = name_part .. extension
                            return display_text, {
                                { { 0, #name_part }, "TelescopeCustomResultsIdentifier" },
                                { { #name_part, #display_text }, "TelescopeCustomResultsIdentifierAlt" },
                            }
                        end,
                        ordinal = entry,
                    }
                end,
            }),
            previewer = false,
            sorter = require("telescope.config").values.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr)
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")

                actions.select_default:replace(function()
                    local selection = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)

                    vim.cmd("Lazy reload " .. selection.value)
                end)

                return true
            end,
        })
        :find()
end

return M
