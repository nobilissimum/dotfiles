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
