M = {}

M.dark = {
    bg = "#282c34",
    bg2 = "#212026",
    base = "#b2b2b2",
    comp = "#c56ec3",
    act1 = "#222226",
    DarkGoldenrod2 = "#eead0e", -- normal / unmodified
    chartreuse3 = "#66cd00", --insert
    SkyBlue2 = "#7ec0ee", -- modified
    chocolate = "#d2691e", -- replace
    gray = "#bebebe", -- visual
    plum3 = "#cd96cd", -- read-only / motion
    yellow = "#fabd2f",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#afd700",
    orange = "#FF8800",
    purple = "#5d4d7a", --act2
    magenta = "#d16d9e",
    grey = "#c0c0c0",
    blue = "#0087d7",
    red = "#ec5f67",
    comments = "#2aa1ae",
    head1 = "#4f97d7",
    error = "#FC5C94",
    warning = "#F3EA98",
    info = "#8DE6F7"
}

M.light = {
    bg = "#fbf8ef",
    bg2 = "#efeae9",
    base = "#655370",
    comp = "#6c4173",
    act1 = "#e7e5eb",
    DarkGoldenrod2 = "#eead0e", -- normal / unmodified
    chartreuse3 = "#66cd00", --insert
    SkyBlue2 = "#7ec0ee", -- modified
    chocolate = "#d2691e", -- replace
    gray = "#bebebe", -- visual
    plum3 = "#cd96cd", -- read-only / motion
    yellow = "#fabd2f",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#afd700",
    orange = "#FF8800",
    purple = "#d3d3e7", --act2
    magenta = "#d16d9e",
    grey = "#c0c0c0",
    blue = "#0087d7",
    red = "#ec5f67",
    comments = "#2aa1ae",
    head1 = "#3a81c3",
    error = "#FC5C94",
    warning = "#F3EA98",
    info = "#8DE6F7"
}

function M.color(val)
    if vim.o.background ~= nil and vim.o.background == "light" then
        return M.light[val]
    elseif vim.o.background ~= nil and vim.o.background == "dark" then
        return M.dark[val]
    else
        local hours = tonumber(os.date("%H"))
        if hours >= vim.g["dusk_til_dawn_morning"] and hours < vim.g["dusk_til_dawn_night"] then
            return M.light[val]
        else
            return M.dark[val]
        end
    end
end

return M
