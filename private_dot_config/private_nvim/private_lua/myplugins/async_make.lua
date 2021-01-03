local M = {}
local loop = vim.loop
local api = vim.api
local results = {}

vim.g.floating_window_winblend = 0
vim.g.loating_window_scaling_factor = 0.8

CMD_RUNNER_BUFFER = nil
CMD_RUNNER_LOADED = false
vim.g.cmd_runner_opened = 0

local window = require 'utils/windows'

local function onread(err, data)
    if err then
        -- print('ERROR: ', err)
        -- TODO handle err
    end
    if data then
        local vals = vim.split(data, "\n")
        for _, d in pairs(vals) do
            if d == "" then goto continue end
            table.insert(results, d)
            ::continue::
        end
    end
end


function M.make()
    local lines = {""}
    local winnr = vim.fn.win_getid()
    local bufnr = vim.api.nvim_win_get_buf(winnr)

    local makeprg = vim.api.nvim_buf_get_option(bufnr, "makeprg")
    if not makeprg then return end

    local cmd = vim.fn.expandcmd(makeprg) .. 'rg " 2>&1 error"'

    local function on_event(job_id, data, event)
        if event == "stdout" or event == "stderr" then
            if data then
                vim.list_extend(lines, data)
                print('Failed to build')
            end
        end

        if event == "exit" then
            vim.fn.setqflist({}, " ", {
                title = cmd,
                lines = lines,
                efm = vim.api.nvim_buf_get_option(bufnr, "errorformat")
            })
            vim.api.nvim_command("doautocmd QuickFixCmdPost")
            
        end
    end

    local job_id =
        vim.fn.jobstart(
        cmd,
        {
            on_stderr = on_event,
            on_stdout = on_event,
            on_exit = on_event,
            stdout_buffered = true,
            stderr_buffered = true,
        }
    )
end


function M.asyncGrep()
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)
    local function setQF()
        vim.fn.setqflist({}, 'r', {title = 'Cargo Build', lines = results})
        api.nvim_command('cwindow')
        local count = #results
        for i=0, count do results[i]=nil end -- clear the table for the next search
    end
    handle = vim.loop.spawn('cargo build', {
        stdio = {stdout,stderr}
    },
    vim.schedule_wrap(function()
        stdout:read_stop()
        stderr:read_stop()
        stdout:close()
        stderr:close()
        handle:close()
        setQF()
    end
    )
    )
    vim.loop.read_start(stdout, onread)
    vim.loop.read_start(stderr, onread)
end

local function on_exit(job_id, code, event)
    if code == 0 then
        -- Close the window where the CMD_RUNNER_BUFFER is
        vim.cmd("silent! :q")
        CMD_RUNNER_BUFFER = nil
        CMD_RUNNER_LOADED = false
        vim.g.cmd_runner_opened = 0
    end
end

--- Call cmd
local function exec_command(cmd)
    if CMD_RUNNER_LOADED == false then
        -- ensure that the buffer is closed on exit
        vim.g.cmd_runner_opened = 1
        vim.fn.termopen(cmd, { on_exit = on_exit })
    end
    vim.cmd "startinsert"
end

--- :cmd entry point
function M.cmdRunner(cmd)
    window.open_floating_window(vim.g.loating_window_scaling_factor, vim.g.floating_window_winblend, CMD_RUNNER_BUFFER, 'cmd_runner', CMD_RUNNER_LOADED)
    exec_command(cmd .. ' && sleep 1')
end

return M