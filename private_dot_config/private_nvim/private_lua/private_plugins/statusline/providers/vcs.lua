local vim = vim
local i = require("plugins.statusline.icons")
local c = require("plugins.statusline.colors")
local u = require("plugins.statusline.utils")
local git = require("myplugins.vcs.git")
local diagnostic = require("plugins.statusline.providers.diagnostic")
local M = {}

-- get diff datas
-- support plugins: vim-gitgutter vim-signify coc-git
local function get_hunks_data()
  -- diff data 1:add 2:modified 3:remove
  local diff_data = {0, 0, 0}
  if vim.fn.exists("*GitGutterGetHunkSummary") == 1 then
    for idx, v in pairs(vim.fn.GitGutterGetHunkSummary()) do
      diff_data[idx] = v
    end
    return diff_data
  elseif vim.fn.exists("*sy#repo#get_stats") == 1 then
    diff_data[1] = vim.fn["sy#repo#get_stats"]()[1]
    diff_data[2] = vim.fn["sy#repo#get_stats"]()[2]
    diff_data[3] = vim.fn["sy#repo#get_stats"]()[3]
    return diff_data
  elseif vim.fn.exists("b:gitsigns_status_dict") == 1 then
    local gitsigns_dict = vim.api.nvim_buf_get_var(0, "gitsigns_status_dict")
    diff_data[1] = gitsigns_dict["added"]
    diff_data[2] = gitsigns_dict["changed"]
    diff_data[3] = gitsigns_dict["removed"]
  end
  return diff_data
end

function M.diff_add()
  local add = get_hunks_data()[1]
  if add > 0 then
    return add .. " "
  end
end

function M.diff_modified()
  local modified = get_hunks_data()[2]
  if modified > 0 then
    return modified .. " "
  end
end

function M.diff_remove()
  local removed = get_hunks_data()[3]
  if removed > 0 then
    return removed .. " "
  end
end

function M.get_git_branch_formatted()
  if diagnostic.has_diagnostics() then
    u.GalaxyBG("GitBranch", c.purple)
  else
    u.GalaxyBG("GitBranch", c.bg2)
  end
  return git.get_branch()
end

function M.seperator()
  if diagnostic.has_diagnostics() and not git.check_workspace() then
    return i.slant.Left
  elseif not diagnostic.has_diagnostics() and git.check_workspace() then
    return i.slant.Left
  else
    return ""
  end
end

return M
