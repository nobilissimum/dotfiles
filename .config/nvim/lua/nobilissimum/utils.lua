function StringInTable(str, tbl)
    for _, value in ipairs(tbl) do
        if value == str then
            return true
        end
    end

    return false
end


function Upsert(key, value, tbl)
    local current_value = tbl[key]
    if current_value then
        table.insert(current_value, value)
    else
        tbl[key] = { value }
    end
end
