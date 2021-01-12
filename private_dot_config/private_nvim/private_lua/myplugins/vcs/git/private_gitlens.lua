local vim, nv = vim, vim.api
local git = {}

-- Show git information in virtual text for current line like GitLens
function git.blameVirtText()
    local ft = vim.fn.expand('%:h:t') -- get the current file extension
    if ft == '' then -- if we are in a scratch buffer or unknown filetype
        return
    end
    if ft == 'bin' then -- if we are in nvim's terminal window
        return
    end
    local currFile = vim.fn.expand('%')
    if not vim.fn.filereadable(currFile) then return end
    nv.nvim_buf_clear_namespace(0, 2, 0, -1) -- clear out virtual text from namespace 2 (the namespace we will set later)
    local line = nv.nvim_win_get_cursor(0)
    local blame = vim.fn.system(string.format('git blame -c -L %d,%d %s', line[1], line[1], currFile))
    local hash = vim.split(blame, '%s')[1]
    local cmd = string.format("git show %s ", hash) .. "--format=' : %an | %ar | %s'"
    if hash == '00000000' then
        text = 'Not Committed Yet'
    else
        text = vim.fn.system(cmd)
        text = vim.split(text, '\n')[1]
        if text:find("fatal") then
            -- if the call to git show fails
            text = 'Not Committed Yet'
        end
    end
    -- set virtual text for namespace 2 with the content from git and assign it to the higlight group 'GitLens'
    nv.nvim_buf_set_virtual_text(0, 2, line[1] - 1, {{text, 'GitLens'}}, {})
end

--- Clearing out the virtual text
function git.clearBlameVirtText()
    nv.nvim_buf_clear_namespace(0, 2, 0, -1)
end

return git