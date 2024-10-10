vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("nobilissimum-ruff-hover", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            return
        end

        if client.name == "ruff" or client.name == "ruff_lsp" then
            client.server_capabilities.hoverProvider = false
        end
    end,
    desc = "LSP: Disable hover capability of Ruff",
})
