local window = require 'utils/windows'
local vcs = require 'myplugins/vcs/git'

local vim = vim
local fn = vim.fn

GITUI_BUFFER = nil
GITUI_LOADED = false
vim.g.gitui_opened = 0

local function gitui_on_exit(job_id, code, event)
    if code == 0 then
        -- Close the window where the GITUI_BUFFER is
        vim.cmd("silent! :q")
        GITUI_BUFFER = nil
        GITUI_LOADED = false
        vim.g.gitui_opened = 0
    end
end

--- Call gitui
local function exec_gitui_command(cmd)
    if GITUI_LOADED == false then
        -- ensure that the buffer is closed on exit
        vim.g.gitui_opened = 1
        vim.fn.termopen(cmd, { on_exit = gitui_on_exit })
    end
    vim.cmd "startinsert"
end

--- :GitUI entry point
local function gitui(path)
    if path == nil then
        path = (function() 
            if fn.getftype(fn.expand("%:p")) == "link" then
                return vcs.get_root_dir(fn.fnamemodify(fn.resolve(fn.expand("%:p")), ":h")):gsub("/.git", "")
            else
                return vcs.get_root_dir(fn.expand("%:p:h")):gsub("/.git", "")
            end
        end)()
    end
    window.open_floating_window(GITUI_BUFFER, 'gitui', GITUI_LOADED)
    local cmd = "gitui " .. "-p " .. path
    exec_gitui_command(cmd)
end

return {
    gitui = gitui,
}