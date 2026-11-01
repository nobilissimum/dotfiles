local title = "OmniSharp"

local analysis_status = {
  started = 0,
  progress = 1,
  finished = 2,
}

local states = {}

local function notify(root_dir, msg, level, timeout)
  vim.notify(msg, level or vim.log.levels.INFO, {
    id = "omnisharp-loading-" .. root_dir,
    title = title,
    timeout = timeout,
  })
end

local function get_root_and_state(client_id)
  local client = vim.lsp.get_client_by_id(client_id)
  local root_dir = client and client.root_dir
  return root_dir, root_dir and states[root_dir]
end

local handlers = {
  ["o#/msbuildprojectdiagnostics"] = function(_, result, ctx)
    local root_dir = get_root_and_state(ctx.client_id)
    if root_dir and result and result.Errors and #result.Errors > 0 then
      local messages = vim.tbl_map(function(e)
        return e.Text
      end, result.Errors)
      notify(
        root_dir,
        "Failed to load " .. vim.fn.fnamemodify(result.FileName, ":t") .. "\n" .. table.concat(messages, "\n"),
        vim.log.levels.ERROR,
        60000
      )
    end
  end,

  ["o#/projectadded"] = function(_, result, ctx)
    local root_dir, state = get_root_and_state(ctx.client_id)
    if not state or state.ready then
      return
    end

    state.project = result and result.MsBuildProject and result.MsBuildProject.AssemblyName or "project"
    notify(root_dir, "Loaded " .. state.project .. ", analyzing files...", nil, 0)
  end,

  ["o#/backgrounddiagnosticstatus"] = function(_, result, ctx)
    local root_dir, state = get_root_and_state(ctx.client_id)
    if not state or state.ready or not state.project or not result then
      return
    end

    if result.Status == analysis_status.started and not state.total and result.NumberFilesTotal > 1 then
      state.total = result.NumberFilesTotal
    end
    if result.NumberFilesTotal ~= state.total then
      return
    end

    if result.Status == analysis_status.finished then
      state.ready = true
      local elapsed = (vim.uv.hrtime() - state.started_at) / 1e9
      notify(root_dir, string.format("%s ready (%.1fs)", state.project, elapsed))
    else
      local done = state.total - result.NumberFilesRemaining
      notify(root_dir, string.format("Loaded %s, analyzing files... (%d/%d)", state.project, done, state.total), nil, 0)
    end
  end,
}

return {
  setup = function()
    vim.lsp.config("omnisharp", {
      handlers = handlers,
      before_init = function(_, config)
        if not config.root_dir then
          return
        end

        states[config.root_dir] = { started_at = vim.uv.hrtime() }
        notify(config.root_dir, "Loading project...", nil, 0)
      end,
    })
  end,
}
