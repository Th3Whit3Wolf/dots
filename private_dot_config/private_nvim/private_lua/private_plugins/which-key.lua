-- Vim-Which-Key
vim.g.which_key_sep = ''
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
        a = "Code action",
        d = {
            name = "Diagnostics",
            p = "Goto previous",
            o = "Set loc list",
            n = "Goto next"
        },
        D = "Preview definition",
        f = "Find the cursor word definition and reference",
        l = {
            name = "LSP",
            h = "Show hover doc",
            i = "Implementation",
            p = "Peek Definition",
            r = "References",
            R = "Rename",
            s = {
                name = "Symbols",
                d = "Document symbols",
                w = "Workspace symbols"
            },
            S = "Signature",
            t = "Type definition",
        }
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

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function code_map(lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_buf_set_keymap(0, 'n', "<leader>c" .. lhs, ":update <bar> call " .. rhs .. "MyCode()<CR>", options)
end

function WhichKeyCodeTest()
    -- Set key mappings 
    code_map("c", "Compile")
    code_map("r", "Run")
    code_map("t", "Test")

    -- Get Which-Key keymap
    key_maps = vim.g.which_key_map

    -- Add keys to Which-Key keymap
    key_maps.c.c = 'Compile'
    key_maps.c.r = 'Run'
    key_maps.c.t = 'Test'

    -- Remove keys from Which-Key keymap
    if key_maps.l ~=nil then
		key_maps.l = nil
    end

    -- Update Which-Key keymap
    vim.g.which_key_map = key_maps
end

function WhichKeyCodeCompileRun()
    -- Set key mappings 
	code_map("c", "Compile")
    code_map("r", "Run")

    -- Get Which-Key keymap
    key_maps = vim.g.which_key_map

    -- Add keys to Which-Key keymap
	key_maps.c.c = 'Compile'
    key_maps.c.r = 'Run'

    -- Remove keys from Which-Key keymap
    if key_maps.c.t ~=nil then
		key_maps.c.t = nil
    end
    if key_maps.l ~=nil then
		key_maps.l = nil
    end

    -- Update Which-Key keymap
    vim.g.which_key_map = key_maps
end

function WhichKeyCodeCompile()
    -- Set key mappings 
	code_map("c", "Compile")

    -- Get Which-Key keymap
    key_maps = vim.g.which_key_map

    -- Add Kkys to Which-Key keymap
    key_maps.c.c = 'Compile'

    -- Remove keys from Which-Key keymap
    if key_maps.c.r ~=nil then
		key_maps.c.r = nil
    end
    if key_maps.c.t ~=nil then
		key_maps.c.t = nil
    end
    if key_maps.l ~=nil then
		key_maps.l = nil
    end

    -- Update Which-Key keymap
    vim.g.which_key_map = key_maps
end

function WhichKeyCodeRun()
    -- Set key mappings 
    code_map("r", "Run")

    -- Get Which-Key keymap
    key_maps = vim.g.which_key_map

    -- Add keys to Which-Key keymap
    key_maps.c.r = 'Run'

    -- Remove keys from Which-Key keymap
    if key_maps.c.c ~=nil then
		key_maps.c.c = nil
    end
    if key_maps.c.t ~=nil then
		key_maps.c.t = nil
    end

    -- Update Which-Key keymap
    vim.g.which_key_map = key_maps
end

function WhichKeyProseRun()
    -- Set key mappings 
    code_map("r", "Run")

    -- Get Which-Key keymap
    key_maps = vim.g.which_key_map

    -- Add keys to Which-Key keymap
    key_maps.c.r = 'Run'
    key_maps.l = {
        name = "Lexical",
        b = "Dictionary",
        c = "Thesaurus",
    }

    -- Remove keys from Which-Key keymap
    if key_maps.c.c ~=nil then
		key_maps.c.c = nil
    end
    if key_maps.c.t ~=nil then
		key_maps.c.t = nil
    end
    

    -- Update Which-Key keymap
    vim.g.which_key_map = key_maps
end

function WhichKeyProse()

    -- Get Which-Key keymap
    key_maps = vim.g.which_key_map

    -- Add keys to Which-Key keymap
    key_maps.l = {
        name = "Lexical",
        b = "Dictionary",
        c = "Thesaurus",
    }

    -- Remove keys from Which-Key keymap
    if key_maps.c.c ~=nil then
		key_maps.c.c = nil
    end
    if key_maps.c.r ~=nil then
		key_maps.c.r = nil
    end
    if key_maps.c.t ~=nil then
		key_maps.c.t = nil
    end

    -- Update Which-Key keymap
    vim.g.which_key_map = key_maps
end

function WhichKeyCodeNone()
    -- Get Which-Key keymap
    key_maps = vim.g.which_key_map

    -- Remove keys from Which-Key keymap
    if key_maps.c.c ~=nil then
		key_maps.c.c = nil
    end
    if key_maps.c.r ~=nil then
		key_maps.c.r = nil
    end
    if key_maps.c.t ~=nil then
		key_maps.c.t = nil
    end
    if key_maps.l ~=nil then
		key_maps.l = nil
    end
    
    -- Update Which-Key keymap
    vim.g.which_key_map = key_maps
end

_G.WhichKey = {}

local CompileRunList = {'c','cpp','go', 'haskell', 'javac'}
local RunList = {'fish', 'html', 'ion', 'javascript','mardown', 'python', 'sh'}
local CompileList = {'coffee','less'}
local Prose = {'asciidoc', 'html', 'mail', 'markdown', 'rst', 'tex', 'text', 'textile', 'xml'}

WhichKey.SetKeyOnFT=function()
    local ft = vim.bo.filetype
    if has_value(CompileRunList, ft) == true then
        WhichKeyCodeCompileRun()
    elseif has_value(RunList, ft) == true and has_value(Prose, ft) == true then
        WhichKeyProseRun()
    elseif has_value(RunList, ft) == true then
        WhichKeyCodeRun()
    elseif has_value(Prose, ft) == true then
        WhichKeyProse()
    elseif has_value(CompileList, ft) == true then
        WhichKeyCodeCompile()
    elseif ft == 'ruby' then
        if vim.fn.filereadable("app/controllers/application_controller.rb") then
			if vim.fn.executable('rails') then
				WhichKeyCodeRun()
			else
				WhichKeyCodeNone()
			end
		else
			if vim.fn.executable('ruby') then
				WhichKeyCodeRun()
			else
				WhichKeyCodeNone()
			end
		end
    elseif ft == 'rust' then
		if vim.fn.filereadable("Cargo.toml") or vim.fn.filereadable("../Cargo.toml") or vim.fn.filereadable("../../Cargo.toml") or vim.fn.filereadable("../../../Cargo.toml") then
			if vim.fn.executable('cargo') then
				WhichKeyCodeTest()
			else
				WhichKeyCodeNone()
			end
		else
            if vim.fn.executable('rustc') then
                WhichKeyCodeCompileRun()
            else
                WhichKeyCodeNone()
			end
        end
    else
        WhichKeyCodeNone()
    end
end



