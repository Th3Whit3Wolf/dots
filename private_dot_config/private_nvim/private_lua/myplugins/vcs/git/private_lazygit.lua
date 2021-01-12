-- Original work can be found here, https://github.com/kdheepak/lazygit.nvim

vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_scaling_factor = 0.8
vim.g.lazygit_use_neovim_remote = 1

local window = require 'utils/windows'
local vcs = require 'myplugins/vcs/git'

local vim = vim
local fn = vim.fn

LAZYGIT_BUFFER = nil
LAZYGIT_LOADED = false
vim.g.lazygit_opened = 0

local function lazygit_on_exit(job_id, code, event)
    if code == 0 then
        -- Close the window where the LAZYGIT_BUFFER is
        vim.cmd("silent! :q")
        LAZYGIT_BUFFER = nil
        LAZYGIT_LOADED = false
        vim.g.lazygit_opened = 0
    end
end

--- Call lazygit
local function exec_lazygit_command(cmd)
    if LAZYGIT_LOADED == false then
        -- ensure that the buffer is closed on exit
        vim.g.lazygit_opened = 1
        vim.fn.termopen(cmd, { on_exit = lazygit_on_exit })
    end
    vim.cmd "startinsert"
end

--- :LazyGit entry point
local function lazygit(path)
    if path == nil then
        path = vcs.project_root_dir()
    end
    window.open_floating_window(vim.g.lazygit_floating_window_scaling_factor, vim.g.lazygit_floating_window_winblend, LAZYGIT_BUFFER, 'lazygit', LAZYGIT_LOADED)
    local cmd = "lazygit " .. "-p " .. path
    exec_lazygit_command(cmd)
end

--- :LazyGitFilter entry point
local function lazygitfilter(path)
    if path == nil then
        path = vcs.project_root_dir()
    end
    window.open_floating_window(vim.g.lazygit_floating_window_scaling_factor, vim.g.lazygit_floating_window_winblend, LAZYGIT_BUFFER, 'lazygit', LAZYGIT_LOADED)
    local cmd = "lazygit " .. "-f " .. path
    exec_lazygit_command(cmd)
end

--- :LazyGitConfig entry point
local function lazygitconfig()
    local os = fn.substitute(fn.system('uname'), '\n', '', '')
    local config_file = ""
    if os == "Darwin" then
        config_file = "~/Library/Application Support/jesseduffield/lazygit/config.yml"
    else
        config_file = "~/.config/jesseduffield/lazygit/config.yml"
    end
    if fn.empty(fn.glob(config_file)) == 1 then
        -- file does not exist
        -- check if user wants to create it
        local answer = fn.confirm("File " .. config_file .. " does not exist.\nDo you want to create the file and populate it with the default configuration?", "&Yes\n&No")
        if answer == 2 then
            return nil
        end
        if fn.isdirectory(fn.fnamemodify(config_file, ":h")) == false then
            -- directory does not exist
            fn.mkdir(fn.fnamemodify(config_file, ":h"))
        end
        vim.cmd('edit ' .. config_file)
        vim.cmd([[execute "silent! 0read !lazygit -c"]])
        vim.cmd([[execute "normal 1G"]])
    else
        vim.cmd('edit ' .. config_file)
    end
end

return {
    lazygit = lazygit,
    lazygitfilter = lazygitfilter,
    lazygitconfig = lazygitconfig,
}