local G = require "global"
local cmd, fn = vim.cmd, vim.fn

local function createDirs()
    -- Create all cache directories
    -- Install python virtualenv and language server
    local data_dir = {
        G.cache_dir .. "backup",
        G.cache_dir .. "session",
        G.cache_dir .. "swap",
        G.cache_dir .. "tags",
        G.cache_dir .. "undo"
    }
    if not G.isdir(G.cache_dir) then
        os.execute("mkdir -p " .. G.cache_dir)
    end
    for _, v in pairs(data_dir) do
        if not G.isdir(v) then
            os.execute("mkdir -p " .. v)
        end
    end
end

local function pythonvenvInit()
    if not G.isdir(G.python3) and fn.executable("python3") then
        os.execute("mkdir -p " .. G.python3)
        os.execute("python3 -m venv " .. G.python3)
        -- install python language server, neovim host, and neovim remote
        cmd(
            "!" ..
                G.python3 ..
                    "bin" ..
                        G.path_sep ..
                            "pip3 install -U setuptools pynvim jedi 'python-language-server[all]' isort pyls-isort neovim-remote"
        )
    end
end

local function nodeHostInit()
    if not G.exists(G.node) and fn.executable("npm") then
        -- install neovim node host
        os.execute("npm install -g neovim")
    end
end

local function packerInit()
    if not G.isdir(G.plugins .. "opt" .. G.path_sep .. "packer.nvim") then
        fn.mkdir(G.plugins .. "opt", "p")
        local out =
            fn.system(
            string.format(
                "git clone %s %s",
                "https://github.com/wbthomason/packer.nvim",
                G.plugins .. "opt" .. G.path_sep .. "packer.nvim"
            )
        )
        print(out)
        print("Downloading packer.nvim...")
        cmd("set runtimepath+=" .. G.plugins .. "opt" .. G.path_sep .. "packer.nvim")
        require "plug".install()
    end
end

local function quoteGenerator()
    if not G.exists(G.local_nvim .. "bin/") then
        os.execute("mkdir -p " .. G.local_nvim .. "bin/")
        print("Downloading Quote Generator...")
        if fn.executable("curl") then
            os.execute(
                "curl -o ~/.local/share/nvim/bin/pq-0.2.0-x86_64-unknown-linux-glibc.tar.gz -LJO https://github.com/Th3Whit3Wolf/pquote/releases/download/0.2.0/pq-0.2.0-x86_64-unknown-linux-glibc.tar.gz"
            )
            print("Unpacking Quote Generator...")
            os.execute(
                "tar xzf ~/.local/share/nvim/bin/pq-0.2.0-x86_64-unknown-linux-glibc.tar.gz --directory ~/.local/share/nvim/bin/"
            )
            print("Cleaning up Quote Generator...")
            os.execute("rm ~/.local/share/nvim/bin/pq-0.2.0-x86_64-unknown-linux-glibc.tar.gz")
            os.execute("mv ~/.local/share/nvim/bin/pq-0.2.0-x86_64-unknown-linux-glibc ~/.local/share/nvim/bin/pq")
        elseif fn.executable("wget") then
            os.execute(
                "wget --no-check-certificate --content-disposition -P ~/.local/share/nvim/bin/ https://github.com/Th3Whit3Wolf/pquote/releases/download/0.2.0/pq-0.2.0-x86_64-unknown-linux-glibc.tar.gz"
            )
            print("Unpacking Quote Generator...")
            os.execute(
                "tar xzf ~/.local/share/nvim/bin/pq-0.2.0-x86_64-unknown-linux-glibc.tar.gz --directory ~/.local/share/nvim/bin/"
            )
            print("Cleaning up Quote Generator...")
            os.execute("rm ~/.local/share/nvim/bin/pq-0.2.0-x86_64-unknown-linux-glibc.tar.gz")
            os.execute("mv ~/.local/share/nvim/bin/pq-0.2.0-x86_64-unknown-linux-glibc ~/.local/share/nvim/bin/pq")
        end
    end
end

createDirs()
pythonvenvInit()
nodeHostInit()
packerInit()
quoteGenerator()
