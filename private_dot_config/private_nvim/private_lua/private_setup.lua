local G = require "global"
local cmd, fn = vim.cmd, vim.fn

local function createDirs()
    -- Create all cache directories
    -- Install python virtualenv and language server
    local data_dir = {
        G.cache_dir .. "backup",
        G.cache_dir .. "dadbod_queries",
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
                            "pip3 install -U setuptools pynvim jedi 'python-language-server[all]' isort pyls-isort neovim-remote fortran-language-server"
        )
    end
end

local function nodeHostInit()
    if fn.executable("npm") then
        -- install neovim node host
        if not G.exists(G.node) then
            local needs_install = {
                "neovim",
                "vscode-css-languageserver-bin",
                "dockerfile-language-server-nodejs",
                "elm",
                "elm-test",
                "elm-format",
                "@elm-tooling/elm-language-server",
                "vscode-html-languageserver-bin",
                "intelephense",
                "vscode-json-languageserver",
                "purescript-language-server",
                "rome",
                "svelte-language-server",
                "typescript",
                "typescript-language-server",
                'vim-language-server',
                'vls',
                'yaml-language-server'
            }
            for _, v in pairs(needs_install) do
                os.execute("npm install -g " .. v)
            end
            os.execute("npm install -g neovim")
        end
    end
end

local function packerInit()
    if not G.isdir(G.plugins .. "packer" .. G.path_sep .. "opt" .. G.path_sep .. "packer.nvim") then
        fn.mkdir(G.plugins .. "opt", "p")
        local out =
            fn.system(
            string.format(
                "git clone %s %s",
                "https://github.com/wbthomason/packer.nvim",
                G.plugins .. "packer" .. G.path_sep .. "opt" .. G.path_sep .. "packer.nvim"
            )
        )
        print(out)
        print("Downloading packer.nvim...")
        cmd("set runtimepath+=" .. G.plugins .. "opt" .. G.path_sep .. "packer.nvim")
    end
    if not G.isdir(G.plugins .. "paqs" .. G.path_sep .. "opt" .. G.path_sep .. "paq-nvim") then
        fn.mkdir(G.plugins .. "opt", "p")
        local out =
            fn.system(
            string.format(
                "git clone %s %s",
                "https://github.com/savq/paq-nvim",
                G.plugins .. "paqs" .. G.path_sep .. "opt" .. G.path_sep .. "paq-nvim"
            )
        )
        print(out)
        print("Downloading paq...")
        cmd("set runtimepath+=" .. G.plugins .. "opt" .. G.path_sep .. "paq-nvim")
    end
    require "plug_paq"
    require "paq-nvim".install()
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
