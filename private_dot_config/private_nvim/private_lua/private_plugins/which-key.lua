-- Vim-Which-Key
vim.g.which_key_map = {
    b = {
        name = "Buffer",
        d = "Order by directory",
        l = "Order by language",
        n = "Next",
        p = "Previous",
        s = "Search"
    },
    c = {
        name = "Code",
        ["]"] = "Previous disagnostic",
        ["["] = "Next disagnostic",
        a = "Code action",
        d = "Preview definition",
        D = "Find the currsor word definition and reference",
        h = "Show hover doc",
        i = "LSP implementation",
        o = "Diagnostic set locl list",
        p = "LSP Peek definition",
        r = "LSP references",
        R = "LSP rename",
        s = {
            name = "Symbols",
            d = "Document symbols",
            w = "Workspace symbols"
        },
        S = "LSP signature",
        t = "LSP type definition",
    },
    f = {
        name = "Find",
        b = "Bookmarks",
        c = "Commits",
        f = "File",
        g = "Git file",
        h = "History",
        l = "Loc list",
        s = "String",
        w = "Word"
    },
    g = {
        name = "Git",
        b = "Branch",
        c = "Commit",
        C = "Commit --amend",
        l = "LazyGit",
        L = "Log",
        s = "Status",
        t = "Tag",
        u = "Gitui"
    },
    s = {
        name = "Session/Splits",
        h = "Horizontal split",
        l = "Session load",
        q = "Close split",
        s = "Session save",
        v = "Vertical split"
    },
    t = {
        name = "Toggle",
        d = "DatabaseUI",
        f = "Filetree",
        l = "Lists",
        n = "Numbers",
        s = "Spell",
        v = "Vista"
    }
}


vim.api.nvim_set_keymap('n', "<leader>", "<cmd>WhichKey '<space>'<cr>",  {noremap = true, silent = true})
vim.fn['which_key#register']('<space>', 'g:which_key_map')
