-- Allow misspellings
local typo = require("utils").fixSpell
local cmd = vim.cmd

-- Start an external command with a single bang
cmd "nnoremap ! :!"
cmd "imap ;date %d %b %Y"
cmd "iab btw by the way"
cmd "iab atm at the moment"
cmd "iab ily I love you ❤️"

-- Allow misspellings
local cmdDefs = {
    bd = {
        "Bd",
        "bD"
    },
    q = {
        "Q"
    },
    ["q!"] = {
        "Q!"
    },
    qall = {
        "Qall"
    },
    ["qall!"] = {
        "Qall!"
    },
    w = {
        "W"
    },
    ["w!"] = {
        "W!"
    },
    wa = {
        "Wa"
    },
    wq = {
        "qw",
        "Wq",
        "WQ"
    }
}

local inDefs = {
    about = {
        "abbout",
        "abotu",
        "baout"
    },
    actually = {
        "actualyl",
        "acutally"
    },
    additional = {
        "additinal",
        "addtional"
    },
    again = {
        "agian",
        "agaon"
    },
    aggressive = {
        "aggresive",
        "agressive"
    },
    almost = {
        "almots",
        "almsot",
        "alomst"
    },
    attention = {
        "atention",
        "attentioin"
    },
    always = {
        "allwasy",
        "allwyas",
        "alwasy",
        "alwats",
        "alwyas"
    },
    available = {
        "availalbe",
        "availible"
    },
    away = {
        "awya",
        "aywa"
    }
}


typo("cnoreabbrev", cmdDefs)
typo("inoreabbrev", inDefs)
