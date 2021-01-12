local api, fn, cmd, g, ft = vim.api, vim.fn, vim.cmd, vim.g, vim.bo.filetype
local G = require("global")

local Git = {}

local function get_dir_contains(path, dirname)
    -- return parent path for specified entry (either file or directory)
    local function pathname(path)
        local prefix = ""
        local i = path:find("[\\/:][^\\/:]*$")
        if i then
            prefix = path:sub(1, i - 1)
        end
        return prefix
    end

    -- Navigates up one level
    local function up_one_level(path)
        if path == nil then
            path = "."
        end
        if path == "." then
            path = io.popen "cd":read "*l"
        end
        return pathname(path)
    end

    -- Checks if provided directory contains git directory
    local function has_specified_dir(path, specified_dir)
        if path == nil then
            path = "."
        end
        return G.isdir(path .. "/" .. specified_dir)
    end

    -- Set default path to current directory
    if path == nil then
        path = "."
    end

    -- If we're already have .git directory here, then return current path
    if has_specified_dir(path, dirname) then
        return path .. "/" .. dirname
    else
        -- Otherwise go up one level and make a recursive call
        local parent_path = up_one_level(path)
        if parent_path == path then
            return nil
        else
            return get_dir_contains(parent_path, dirname)
        end
    end
end

-- adapted from from clink-completions' git.lua
function Git.get_root_dir(path)
    -- return parent path for specified entry (either file or directory)
    local function pathname(path)
        local prefix = ""
        local i = path:find("[\\/:][^\\/:]*$")
        if i then
            prefix = path:sub(1, i - 1)
        end

        return prefix
    end

    -- Checks if provided directory contains git directory
    local function has_git_dir(dir)
        local git_dir = dir .. "/.git"
        if G.isdir(git_dir) then
            return git_dir
        end
    end

    local function has_git_file(dir)
        local gitfile = io.open(dir .. "/.git")
        if not gitfile then
            return false
        end

        local git_dir = gitfile:read():match("gitdir: (.*)")
        gitfile:close()

        return git_dir and dir .. "/" .. git_dir
    end

    -- Set default path to current directory
    if not path or path == "." then
        path = io.popen "cd":read "*l"
    end

    -- Calculate parent path now otherwise we won't be
    -- able to do that inside of logical operator
    local parent_path = pathname(path)

    return has_git_dir(path)
        or has_git_file(path)
        -- Otherwise go up one level and make a recursive call
        or (parent_path ~= path and Git.get_root_dir(parent_path) or nil)
end

function Git.check_workspace()
    local current_file = fn.expand("%:p")
    if current_file == '' or current_file == nil then return false end
    local current_dir
    -- if file is a symlinks
    if fn.getftype(current_file) == "link" then
        local real_file = fn.resolve(current_file)
        current_dir = fn.fnamemodify(real_file, ":h")
    else
        current_dir = fn.expand("%:p:h")
    end
    local result = Git.get_root_dir(current_dir)
    if not result then
        return false
    end
    return true
end

function Git.get_branch()
    if ft == "help" then
        return
    end
    local current_file = fn.expand("%:p")
    local current_dir

    -- if file is a symlinks
    if fn.getftype(current_file) == "link" then
        local real_file = fn.resolve(current_file)
        current_dir = fn.fnamemodify(real_file, ":h")
    else
        current_dir = fn.expand("%:p:h")
    end

    local _, gitbranch_pwd = pcall(api.nvim_buf_get_var, 0, "gitbranch_pwd")
    local _, gitbranch_path = pcall(api.nvim_buf_get_var, 0, "gitbranch_path")
    if gitbranch_path and gitbranch_pwd then
        if gitbranch_path:find(current_dir) and string.len(gitbranch_pwd) ~= 0 then
            return gitbranch_pwd
        end
    end
    local git_dir = Git.get_root_dir(current_dir)
    if not git_dir then
        return
    end
    local git_root
    if not git_dir:find("/.git") then
        git_root = git_dir
    end
    git_root = git_dir:gsub("/.git", "")

    -- If git directory not found then we're probably outside of repo
    -- or something went wrong. The same is when head_file is nil
    local head_file = git_dir and io.open(git_dir .. "/HEAD")
    if not head_file then
        return
    end

    local HEAD = head_file:read()
    head_file:close()

    -- if HEAD matches branch expression, then we're on named branch
    -- otherwise it is a detached commit
    local branch_name = HEAD:match("ref: refs/heads/(.+)")
    if branch_name == nil then
        return
    end

    api.nvim_buf_set_var(0, "gitbranch_pwd", branch_name)
    api.nvim_buf_set_var(0, "gitbranch_path", git_root)

    return branch_name .. " "
end

function Git.run()
    local gStatus = Git.check_workspace()
    if gStatus == true then
        local options = {noremap = true, silent = true}
        api.nvim_command("augroup vcsGit")
        if fn.executable('nvr') then
	        cmd "let $GIT_EDITOR = \"nvr -cc split --remote-wait +'set bufhidden=wipe'\""
        end
        api.nvim_command("autocmd!")
        api.nvim_command("autocmd CursorHold * lua require'myplugins/vcs/git/gitlens'.blameVirtText()")
        api.nvim_command("autocmd CursorMoved * lua require'myplugins/vcs/git/gitlens'.clearBlameVirtText()")
        api.nvim_command("autocmd CursorMovedI * lua require'myplugins/vcs/git/gitlens'.clearBlameVirtText()")
        api.nvim_command("augroup END")
        if fn.executable("lazygit") then
            api.nvim_command("command! LazyGit lua require'myplugins/vcs/git/lazygit'.lazygit()")
            api.nvim_command("command! LazyGitFilter lua require'myplugins/vcs/git/lazygit'.lazygitfilter()")
            api.nvim_command("command! LazyGitConfig lua require'myplugins/vcs/git/lazygit'.lazygitconfig()")
        end
        if fn.executable("gitui") then
            api.nvim_command("command! GitUI lua require'myplugins/vcs/git/gitui'.gitui()")
        end
        -- Vim Signify
        api.nvim_command("packadd vim-signify")
        g["signify_sign_add"] = ''
        g["signify_sign_delete"] = ''
        g["signify_sign_delete_first_line"] = ''
        g["signify_sign_change"] = ''
        api.nvim_command("SignifyEnableAll")
        api.nvim_set_keymap("n", "\\<Space>gd", "<cmd>SignifyDiff<CR>",     options)
        api.nvim_set_keymap("n", "\\<Space>gp", "<cmd>SignifyHunkDiff<CR>", options)
        api.nvim_set_keymap("n", "\\<Space>gu", "<cmd>SignifyHunkUndo<CR>", options)
        api.nvim_set_keymap("n", "\\<Space>g[", "<Plug>(signify-prev-hunk)", {silent = true})
        api.nvim_set_keymap("n", "\\<Space>g]", "<Plug>(signify-next-hunk)", {silent = true})
        api.nvim_set_keymap("o", "ih", "<Plug>(signify-inner-pending)", {silent = true})
        api.nvim_set_keymap("x", "ih", "<Plug>(signify-inner-visual)",  {silent = true})
        api.nvim_set_keymap("o", "ah", "<Plug>(signify-outer-pending)", {silent = true})
        api.nvim_set_keymap("x", "ah", "<Plug>(signify-outer-visual)",  {silent = true})
        api.nvim_command("SignifyEnableAll")
        -- Gina
        api.nvim_command("packadd gina.vim")
        api.nvim_set_keymap("n", "<Space>gs", "<cmd>Gina status<CR>",         options)
        api.nvim_set_keymap("n", "<Space>gb", "<cmd>Gina branch<CR>",         options)
        api.nvim_set_keymap("n", "<Space>gc", "<cmd>Gina commit<CR>",         options)
        api.nvim_set_keymap("n", "<Space>gC", "<cmd>Gina commit --amend<CR>", options)
        api.nvim_set_keymap("n", "<Space>gt", "<cmd>Gina tag<CR>",            options)
        api.nvim_set_keymap("n", "<Space>gl", "<cmd>Gina log<CR>",            options)
        api.nvim_set_keymap("n", "<Space>gL", "<cmd>Gina log :%<CR>",         options)
        api.nvim_set_keymap("n", "<Space>gf", "<cmd>Gina ls<CR>",             options)
        fn["gina#custom#command#option"]("commit", "-v|--verbose")
        fn["gina#custom#command#option"]([[/\%(status\|commit\)]], "-u|--untracked-files")
        fn["gina#custom#command#option"]("status", "-b|--branch")
        fn["gina#custom#command#option"]("status", "-s|--short")
        fn["gina#custom#command#option"]([[/\%(commit\|tag\)]], "--restore")
        fn["gina#custom#command#option"]("show", "--show-signature")
        fn["gina#custom#action#alias"]("branch", "track",  "checkout:track")
        fn["gina#custom#action#alias"]("branch", "merge",  "commit:merge")
        fn["gina#custom#action#alias"]("branch", "rebase", "commit:rebase")
        fn["gina#custom#action#alias"]([[/\%(blame\|log\|reflog\)]], "preview", "topleft show:commit:preview")
        fn["gina#custom#action#alias"]([[/\%(blame\|log\|reflog\)]], "changes", "topleft changes:of:preview")
        fn["gina#custom#mapping#nmap"]("branch", "g<CR>", "<Plug>(gina-commit-checkout-track)")
        fn["gina#custom#mapping#nmap"]("status", "<C-^>", ":<C-u>Gina commit<CR>", options)
        fn["gina#custom#mapping#nmap"]("commit", "<C-^>", ":<C-u>Gina status<CR>", options)
        fn["gina#custom#mapping#nmap"]("status", "<C-6>", ":<C-u>Gina commit<CR>", options)
        fn["gina#custom#mapping#nmap"]("commit", "<C-6>", ":<C-u>Gina status<CR>", options)
        fn["gina#custom#mapping#nmap"]([[/\%(blame\|log\|reflog\)]], "p",
            "<cmd>call gina#action#call(''preview'')<CR>", options)
        fn["gina#custom#mapping#nmap"]([[/\%(blame\|log\|reflog\)]],
            "c", "<cmd>call gina#action#call(''changes'')<CR>", options)
        -- Git Messenger
        api.nvim_command("packadd git-messenger.vim")
        g["git_messenger_no_default_mappings"] = true
        api.nvim_set_keymap("n", "gm", "<cmd>GitMessenger<CR>", {silent = true})
        api.nvim_command("packadd committia.vim")
    else
        api.nvim_command("augroup vcsGit")
        api.nvim_command("autocmd!")
        api.nvim_command("augroup END")
    end
end

return Git
