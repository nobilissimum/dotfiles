F = {}
F.unpack = table.unpack
if not F.unpack then
---@diagnostic disable-next-line: deprecated
    F.unpack = unpack
end

function F.is_string_in_table(str, tbl)
    for _, value in ipairs(tbl) do
        if value == str then
            return true
        end
    end

    return false
end


function F.upsert(key, value, tbl)
    local current_value = tbl[key]
    if current_value then
        table.insert(current_value, value)
    else
        tbl[key] = { value }
    end
end

function F.empty_table(length)
    local table = {}
    for i = 1, length do
        table[i] = ""
    end

    return table
end

function F.is_executable(cmd)
    return vim.fn.executable(cmd) == 1
end

function F.get_uname()
    local f = io.popen("uname")
    if f == nil then
        return nil
    end

    local uname = f:read("*l")
    f:close()

    return uname
end

function F.log_to_cache(msg)
    local log_path = vim.fn.stdpath("cache") .. "/nvim.log"
    local file = io.open(log_path, "a")
    if not file then
        vim.notify("Failed to open log file", vim.log.levels.ERROR)
        return
    end

    file:write(tostring(msg) .. "\n")
    file:close()

    vim.notify("Logged to " .. log_path, vim.log.levels.INFO)
end

function F.is_module_available(path)
    if package.loaded[path] then
        return true
    end

    for _, searcher in ipairs(package.loaders) do
        local loader = searcher(path)
        if type(loader) == "function" then
            package.preload[path] = loader
            return true
        end
    end

    return false
end
