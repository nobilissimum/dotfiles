local ruff_min_version_with_server = {
    major = 0,
    minor = 4,
    patch = 0,
}

local split_version = function(version)
    local major, minor, patch = version:match("(%d+)%.(%d+)%.(%d+)")
    return tonumber(major), tonumber(minor), tonumber(patch)
end

return {
    setup = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("nobilissimum-ruff-hover", { clear = true }),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client == nil then
                    return
                end

                if client.name == "ruff" then
                    client.server_capabilities.hoverProvider = false
                end
            end,
            desc = "LSP: Disable hover capability of Ruff",
        })
    end,

    get_ruff_cmd = function()
        local _ = vim.fn.system("python -m ruff_lsp --version")
        local ruff_lsp_exit_code = vim.v.shell_error
        if ruff_lsp_exit_code == 0 then
            return { "python", "-m", "ruff_lsp" }
        end

        local output = vim.fn.system("python -m ruff --version")
        local ruff_exit_code = vim.v.shell_error
        if ruff_exit_code == 0 then
            local version = output:match("ruff (%d+%.%d+%.%d+)")
            if not version then
                goto continue
            end

            local major, minor, patch = split_version(version)
            if major > ruff_min_version_with_server.major then
                return { "python", "-m", "ruff", "server" }
            end

            if major == ruff_min_version_with_server.major and minor > ruff_min_version_with_server.minor then
                return { "python", "-m", "ruff", "server" }
            end

            if
                major == ruff_min_version_with_server.major
                and minor == ruff_min_version_with_server.minor
                and patch >= ruff_min_version_with_server.patch
            then
                return { "python", "-m", "ruff", "server" }
            end

            ::continue::
        end

        local mason_path = vim.fn.stdpath("data") .. "/mason/bin/ruff"
        if vim.fn.executable(mason_path) == 1 then
            return { mason_path, "server" }
        end

        return { "ruff", "server" }
    end,
}
