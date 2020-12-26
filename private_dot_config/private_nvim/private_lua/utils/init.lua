local api = vim.api

M = {}

local function strSplit(delim, str)
    local t = {}

    for substr in string.gmatch(str, "[^" .. delim .. "]*") do
        if substr ~= nil and string.len(substr) > 0 then
            table.insert(t, substr)
        end
    end

    return t
end

function M.fixSpell(abbrev, def) 
    for correct, incorrect_list in pairs(def) do
        for _, incorrect in ipairs(incorrect_list) do
            --local command = table.concat(vim.tbl_flatten {scope, def}, " ")
            local command = abbrev .. " " .. incorrect .. " " .. correct
            api.nvim_command(command)
        end
    end
end

function M.abolish(str1, str2)
    local occurence1 = 0
    local occurence2 = 0
    for c in string.gmatch(str1, "%A") do
        if c == "{" then
            occurence1 = occurence1 + 1
        end
    end
    for c in string.gmatch(str2, "%A") do
        if c == "{" then
            occurence2 = occurence2 + 1
        end
    end
    if occurence1 < 1 then
        api.nvim_command("iab " .. str1 .. " " .. str2)
    elseif occurence2 == 1 then
        local begin_word1, mid_word1, end_word1 = (function()
            if string.sub(str1, 1) == "{" then
                local s = str1:sub(2, -1)
                local split_str = strSplit("}", s)
                local begin_word = ""
                local end_word = table.remove(split_str)
                local mid_word = strSplit(",", table.concat(split_str))
                return begin_word, mid_word, end_word
            elseif string.sub(str1, -1) == "}" then
                local s = str1:sub(1, -2)
                local split_str = strSplit("{", s)
                local begin_word = table.remove(split_str, 1)
                local mid_word = strSplit(",", table.concat(split_str))
                local end_word = ""
                return begin_word, mid_word, end_word
            else
                local s = str1:sub(1, -2)
                local split_str = strSplit("{", s)
                local begin_word = table.remove(split_str, 1)
                local end_word = table.remove(split_str)
                local mid_word = strSplit(",", table.concat(split_str))
                return begin_word, mid_word, end_word
            end
        end)()

        if occurence2 < 1 then
            for _,word in pairs(mid_word1) do
                api.nvim_command("iab " .. begin_word1 .. word .. end_word1 .. " " .. word .. str2)
            end
        else
        if string.sub(str2, 1) == "{" then
            for _,word in pairs(mid_word1) do
                api.nvim_command("iab " .. begin_word1 .. word .. end_word1 .. " " .. word .. str2:sub(3, -1))
            end
        elseif string.sub(str2, -1) == "}" then
            for _,word in pairs(mid_word1) do
                api.nvim_command("iab " .. begin_word1 .. word .. end_word1 .. " " .. str2:sub(1, -3) .. word)
            end
        else
            local split_str = strSplit("{}", str2)
            for _,word in pairs(mid_word1) do
                api.nvim_command("iab " .. begin_word1 .. word .. end_word1 .. " " .. split_str[1] .. word .. split_str[2])
            end
        end
    end
    end
end


return M
