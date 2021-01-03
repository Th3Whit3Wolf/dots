vim.cmd "packadd paq-nvim"
local Paq = require "paq-nvim"
local paq = Paq.paq

local M = {}
local function plugins()
    paq {"savq/paq-nvim", opt = true}

    -- My spacemacs colorscheme
    paq {
        "Th3Whit3Wolf/space-nvim-theme",
        branch = "main"
    }

    -- neovim statusline plugin written in lua
    paq {
        "glepnir/galaxyline.nvim",
        branch = "main"
    }

    -- Indent Guides (written in lua)
    paq {
        "glepnir/indent-guides.nvim",
        branch = "main"
    }

    -- Modern vim-startify
    paq "glepnir/dashboard-nvim"

    -- devicons in lua
    paq "kyazdani42/nvim-web-devicons"

    -- A File Explorer For Neovim Written In Lua
    paq {"kyazdani42/nvim-tree.lua", opt = true}

    -- auto completion framework that aims to provide a better completion experience with neovim's built-in LSP
    paq "nvim-lua/completion-nvim"

    -- Collection of common configurations for the Nvim LSP client.
    paq "neovim/nvim-lspconfig"

    -- bunch of info & extension callbacks for built-in LSP (provides inlay hints)
    paq "tjdevries/lsp_extensions.nvim"

    -- elescope is a highly extendable fuzzy finder over lists. Items are shown in a popup with a prompt to search over.
    paq "nvim-lua/telescope.nvim"

    -- All the lua functions I don't want to write twice.
    paq "nvim-lua/plenary.nvim"

    -- An implementation of the Popup API from vim in Neovim
    paq "nvim-lua/popup.nvim"
    
    -- Snippet plugin for vim/nvim that supports LSP/VSCode's snippet forma
    paq "hrsh7th/vim-vsnip"

    -- vim-vsnip integrations to other plugins
    paq "hrsh7th/vim-vsnip-integ"

    -- plugin for interacting with databases
    paq {"tpope/vim-dadbod"}

    -- Like pgadmin but for vim
    paq {"kristijanhusak/vim-dadbod-ui"}

    --use "nvim-treesitter/completion-treesitter"
    paq "kristijanhusak/vim-dadbod-completion"

    -- Completion for buffers word.
    paq "steelsojka/completion-buffers"

    -- high-performance color highlighter for Neovim
    paq {
        "norcalli/nvim-colorizer.lua",
        opt = true
    }

    paq "akinsho/nvim-toggleterm.lua"

    -- A surround text object plugin for neovim, written in lua.
    paq {
        "blackcauldron7/surround.nvim",
        opt = true
    }

    paq {
        "Raimondi/delimitMate",
        opt = true
    }

    -- uses the sign column to indicate added, modified and removed lines in a file that is managed by a version control system
    paq {
        "mhinz/vim-signify",
        opt = true
    }

    -- Vim sugar for the UNIX shell commands
    paq {
        "tpope/vim-eunuch",
        opt = true
    }

    -- shows the history of commits under the cursor in popup window
    paq {
        "rhysd/git-messenger.vim",
        opt = true
    }

    -- Vim plugin that shows keybindings in popup
    paq {
        "liuchengxu/vim-which-key",
        opt = true
    }

    -- improves the git commit buffer
    paq {
        "rhysd/committia.vim",
        opt = true
    }

    -- Asynchronously control git repositories in Neovim
    paq {
        "lambdalisue/gina.vim",
        opt = true
    }

    -- A simple, easy-to-use Vim alignment plugin
    paq "junegunn/vim-easy-align"

    paq {
        "liuchengxu/vista.vim",
        opt = true
    }

    -- Auto close (X)HTML tags
    paq {
        "alvan/vim-closetag",
        opt = true
    }

    paq {
        "turbio/bracey.vim",
        hook = "npm install --prefix server",
        opt = true
    }

    -- An asynchronous markdown preview plugin for Neovim
    paq {
        "euclio/vim-markdown-composer",
        hook = "cargo build --release",
        opt = true
    }

    -- Simpler Rainbow Parentheses
    paq {
        "junegunn/rainbow_parentheses.vim",
        opt = true
    }

    -- Read DotEnv
    paq {
        "tpope/vim-dotenv",
        opt = true
    }

    -- Profiling
    paq {
        "tweekmonster/startuptime.vim",
        opt = true
    }

    --------------------------------------------
    --     ____                               --
    --    / __ \   _____  ____    _____  ___  --
    --   / /_/ /  / ___/ / __ \  / ___/ / _ \ --
    --  / ____/  / /    / /_/ / (__  ) /  __/ --
    -- /_/      /_/     \____/ /____/  \___/  --
    --------------------------------------------

    -- Add all of these in  `lazy/git`
    -- Uncover usage problems in your writing
    paq {
        "reedes/vim-wordy",
        opt = true
    }

    -- Highlights overused words
    paq {
        "dbmrq/vim-ditto",
        opt = true
    }

    -- Building on Vim’s spell-check and thesaurus/dictionary completion
    paq {
        "reedes/vim-lexical",
        opt = true
    }

    -- handful of tweaks needed to smooth the path to writing prose
    paq {
        "reedes/vim-pencil",
        opt = true
    }

    -----------------------------------------------------------------------------
    --     __                                                                  --
    --    / /   ____ _   ____    ____ _  __  __  ____ _   ____ _  ___    _____ --
    --   / /   / __ `/  / __ \  / __ `/ / / / / / __ `/  / __ `/ / _ \  / ___/ --
    --  / /___/ /_/ /  / / / / / /_/ / / /_/ / / /_/ /  / /_/ / /  __/ (__  )  --
    -- /_____/\__,_/  /_/ /_/  \__, /  \__,_/  \__,_/   \__, /  \___/ /____/   --
    --                        /____/                   /____/                  --
    -----------------------------------------------------------------------------

    -- ACPI ASL
    paq {
        "martinlroth/vim-acpi-asl",
        opt = true
    }

    -- Ansible 2.x
    paq {
        "pearofducks/ansible-vim",
        opt = true
    }

    -- API Blueprint
    paq {
        "sheerun/apiblueprint.vim",
        opt = true
    }

    -- AppleScript
    paq {
        "mityu/vim-applescript",
        opt = true
    }

    -- Arduino
    paq {
        "sudar/vim-arduino-syntax",
        opt = true
    }

    -- AsciiDoc
    paq {
        "asciidoc/vim-asciidoc",
        opt = true
    }

    -- BATS
    paq {
        "aliou/bats.vim",
        opt = true
    }

    -- Bazel
    paq {
        "bazelbuild/vim-bazel",
        opt = true
    }

    -- Bazel
    paq {
        "google/vim-maktaba",
        opt = true
    }

    -- Blade templates
    paq {
        "jwalton512/vim-blade",
        opt = true
    }

    -- Brewfile
    paq {
        "bfontaine/Brewfile.vim",
        opt = true
    }

    -- C#
    paq {
        "OrangeT/vim-csharp",
        opt = true
    }

    -- C#
    paq {
        "OmniSharp/omnisharp-vim",
        opt = true
    }

    -- Caddyfile
    paq {
        "isobit/vim-caddyfile",
        opt = true
    }

    -- Cargo Make (Rust cargo extension)
    paq {
        "nastevens/vim-cargo-make",
        opt = true
    }

    -- Cargo.toml (Rust)
    paq {
        "mhinz/vim-crates",
        opt = true
    }

    -- Carp
    paq {
        "hellerve/carp-vim",
        opt = true
    }

    -- Chef
    paq {
        "vadv/vim-chef",
        opt = true
    }

    -- Clojure
    paq {
        "guns/vim-clojure-static",
        opt = true
    }

    -- Clojure
    paq {
        "tpope/vim-fireplace",
        opt = true
    }

    -- Clojure
    paq {
        "guns/vim-clojure-highlight",
        opt = true
    }

    -- Clojure
    paq {
        "Olical/conjure",
        tag = "v4.8.0",
        opt = true
    }

    -- LISP languages
    paq {
        "eraserhd/parinfer-rust",
        opt = true,
        run = "cargo build --release"
    }

    -- Cmake
    paq {
        "pboettch/vim-cmake-syntax",
        opt = true
    }

    -- Cmake
    paq {
        "vhdirk/vim-cmake",
        opt = true
    }

    -- CoffeScript
    paq {
        "kchmck/vim-coffee-script",
        opt = true
    }

    -- CJSX (JSX equivalent in CoffeeScript)
    paq {
        "mtscout6/vim-cjsx",
        opt = true
    }

    -- Cassandra CQL
    paq {
        "elubow/cql-vim",
        opt = true
    }

    -- Cryptol
    paq {
        "victoredwardocallaghan/cryptol.vim",
        opt = true
    }

    -- Crystal
    paq {
        "vim-crystal/vim-crystal",
        opt = true
    }

    -- CSS
    paq {
        "hail2u/vim-css3-syntax",
        opt = true
    }

    -- CSV
    paq {
        "chrisbra/csv.vim",
        opt = true
    }

    -- Cucumber
    paq {
        "tpope/vim-cucumber",
        opt = true
    }

    -- Cue
    paq {
        "mgrabovsky/vim-cuesheet",
        opt = true
    }

    -- D Lang
    paq {
        "JesseKPhillips/d.vim",
        opt = true
    }

    -- Dafny
    paq {
        "mlr-msft/vim-loves-dafny",
        opt = true
    }

    -- Dart
    paq {
        "dart-lang/dart-vim-plugin",
        opt = true
    }

    -- Dhall
    paq {
        "vmchale/dhall-vim",
        opt = true
    }

    -- Dockerfile
    paq {
        "ekalinin/Dockerfile.vim",
        opt = true
    }

    -- Duckscript
    paq {
        "nastevens/vim-duckscript",
        opt = true
    }

    -- Elixir
    paq {
        "elixir-editors/vim-elixir",
        opt = true
    }

    -- Emblem
    paq {
        "yalesov/vim-emblem",
        opt = true
    }

    -- Erlang
    paq {
        "vim-erlang/vim-erlang-runtime",
        opt = true
    }

    -- Fennel
    paq {
        "bakpakin/fennel.vim",
        opt = true
    }

    -- Ferm
    paq {
        "vim-scripts/ferm.vim",
        opt = true
    }

    -- Fish
    paq {
        "georgewitteman/vim-fish",
        opt = true
    }

    -- Flatbuffers
    paq {
        "dcharbon/vim-flatbuffers",
        opt = true
    }

    -- Fountain
    paq {
        "kblin/vim-fountain",
        opt = true
    }

    -- GDScript 3
    paq {
        "calviken/vim-gdscript3",
        opt = true
    }

    -- Git
    paq {
        "tpope/vim-git",
        opt = true
    }

    -- OpenGL Shading Language
    paq {
        "tikhomirov/vim-glsl",
        opt = true
    }

    -- Gleam
    paq {
        "gleam-lang/gleam.vim",
        opt = true
    }

    -- GMPL
    paq {
        "maelvls/gmpl.vim",
        opt = true
    }

    -- GNUPlot
    paq {
        "vim-scripts/gnuplot-syntax-highlighting",
        opt = true
    }

    if vim.fn.executable("go") > 1 then
        -- Go
        paq {
            "fatih/vim-go",
            opt = true,
            hook = function()
                vim.cmd("GoUpdateBinaries")
            end
        }
    end

    -- Gradle
    paq {
        "tfnico/vim-gradle",
        opt = true
    }

    -- GraphQL
    paq {
        "jparise/vim-graphql",
        opt = true
    }

    -- Hack
    paq {
        "hhvm/vim-hack",
        opt = true
    }

    -- Haml
    paq {
        "sheerun/vim-haml",
        opt = true
    }

    -- Handlebars
    paq {
        "mustache/vim-mustache-handlebars",
        opt = true
    }

    -- HAProxy
    paq {
        "CH-DanReif/haproxy.vim",
        opt = true
    }

    -- Haskel
    paq {
        "neovimhaskell/haskell-vim",
        opt = true
    }

    -- Haxe
    paq {
        "yaymukund/vim-haxe",
        opt = true
    }

    -- HCL
    paq {
        "b4b4r07/vim-hcl",
        opt = true
    }

    -- Helm Templates
    paq {
        "towolf/vim-helm",
        opt = true
    }

    -- Hive
    paq {
        "zebradil/hive.vim",
        opt = true
    }

    -- HTML5
    paq {
        "othree/html5.vim",
        opt = true
    }

    -- i3
    paq {
        "mboughaba/i3config.vim",
        opt = true
    }

    -- icalendar
    paq {
        "chutzpah/icalendar.vim",
        opt = true
    }

    -- Idris
    paq {
        "idris-hackers/idris-vim",
        opt = true
    }

    -- Info
    paq {
        "HiPhish/info.vim",
        opt = true
    }

    -- Ion
    paq {
        "vmchale/ion-vim",
        opt = true
    }

    -- ISPC
    paq {
        "jez/vim-ispc",
        opt = true
    }

    -- JST
    paq {
        "briancollins/vim-jst",
        opt = true
    }

    -- JSX
    paq {
        "maxmellon/vim-jsx-pretty",
        opt = true
    }

    -- Jenkins
    paq {
        "martinda/Jenkinsfile-vim-syntax",
        opt = true
    }

    -- Jinja
    paq {
        "lepture/vim-jinja",
        opt = true
    }

    -- Json
    paq {
        "elzr/vim-json",
        opt = true
    }

    -- Json5
    paq {
        "GutenYe/json5.vim",
        opt = true
    }

    -- Julia
    paq {
        "JuliaEditorSupport/julia-vim",
        opt = true
    }

    -- Kotlin
    paq {
        "udalov/kotlin-vim",
        opt = true
    }

    -- Latex
    paq {
        "lervag/vimtex",
        opt = true
    }

    -- Latex
    paq {
        "xuhdev/vim-latex-live-preview",
        opt = true
    }

    -- Ledger
    paq {
        "ledger/vim-ledger",
        opt = true
    }

    -- Less
    paq {
        "groenewege/vim-less",
        opt = true
    }

    -- Lilypond
    paq {
        "sersorrel/vim-lilypond",
        opt = true
    }

    -- LiveScript
    paq {
        "gkz/vim-ls",
        opt = true
    }

    -- Log
    paq {
        "MTDL9/vim-log-highlighting",
        opt = true
    }

    -- Macports
    paq {
        "jstrater/mpvim",
        opt = true
    }

    -- Mako
    paq {
        "sophacles/vim-bundle-mako",
        opt = true
    }

    -- Markdown
    paq {
        "plasticboy/vim-markdown",
        opt = true
    }

    -- Markdown (Github)
    paq {
        "rhysd/vim-gfm-syntax",
        opt = true
    }

    -- Mathematica
    paq {
        "voldikss/vim-mma",
        opt = true
    }

    -- Matlab
    paq {
        "daeyun/vim-matlab",
        opt = true
    }

    -- MDX
    paq {
        "jxnblk/vim-mdx-js",
        opt = true
    }

    -- Mercury
    paq {
        "stewy33/mercury-vim",
        opt = true
    }

    -- MoonScript
    paq {
        "leafo/moonscript-vim",
        opt = true
    }

    -- Nginx
    paq {
        "chr4/nginx.vim",
        opt = true
    }

    -- Nim
    paq {
        "zah/nim.vim",
        opt = true
    }

    -- Nix
    paq {
        "LnL7/vim-nix",
        opt = true
    }

    -- Objective-C
    paq {
        "b4winckler/vim-objc",
        opt = true
    }

    -- OCaml
    paq {
        "ocaml/vim-ocaml",
        opt = true
    }

    -- Octave
    paq {
        "McSinyx/vim-octave",
        opt = true
    }

    -- Pawn
    paq {
        "mcnelson/vim-pawn",
        opt = true
    }

    -- Pandoc
    paq {
        "vim-pandoc/vim-pandoc",
        opt = true
    }

    -- Pandoc
    paq {
        "vim-pandoc/vim-pandoc-syntax",
        opt = true
    }

    -- PERL
    paq {
        "vim-perl/vim-perl",
        opt = true
    }

    -- PostgreSQL
    paq {
        "lifepillar/pgsql.vim",
        opt = true
    }

    -- PHP
    paq {
        "StanAngeloff/php.vim",
        opt = true
    }

    -- PlantUML
    paq {
        "aklt/plantuml-syntax",
        opt = true
    }

    -- Ponylang
    paq {
        "jakwings/vim-pony",
        opt = true
    }

    -- PowerShell
    paq {
        "PProvost/vim-ps1",
        opt = true
    }

    -- Prolog
    paq {
        "adimit/prolog.vim",
        opt = true
    }

    -- Protocol Buffers
    paq {
        "uarun/vim-protobuf",
        opt = true
    }

    -- Pug
    paq {
        "digitaltoad/vim-pug",
        opt = true
    }

    -- Puppet
    paq {
        "rodjek/vim-puppet",
        opt = true
    }

    -- PureScript
    paq {
        "purescript-contrib/purescript-vim",
        opt = true
    }

    -- QMake
    paq {
        "artoj/qmake-syntax-vim",
        opt = true
    }

    -- QML
    paq {
        "peterhoeg/vim-qml",
        opt = true
    }

    -- R
    paq {
        "jalvesaq/Nvim-R",
        opt = true
    }

    -- Racket
    paq {
        "wlangstroth/vim-racket",
        opt = true
    }

    -- Ragel
    paq {
        "jneen/ragel.vim",
        opt = true
    }

    -- Raku
    paq {
        "Raku/vim-raku",
        opt = true
    }

    -- RAML
    paq {
        "IN3D/vim-raml",
        opt = true
    }

    -- Razor view engine
    paq {
        "adamclerk/vim-razor",
        opt = true
    }

    -- Reason
    paq {
        "reasonml-editor/vim-reason-plus",
        opt = true
    }

    -- reStructuredText
    paq {
        "marshallward/vim-restructuredtext",
        opt = true
    }

    -- RSpec
    paq {
        "keith/rspec.vim",
        opt = true
    }

    -- RON
    paq {
        "ron-rs/ron.vim",
        opt = true
    }

    -- Ruby
    paq {
        "vim-ruby/vim-ruby",
        opt = true
    }

    -- Rust
    paq {
        "rust-lang/rust.vim",
        opt = true
    }

    -- SBT
    paq {
        "derekwyatt/vim-sbt",
        opt = true
    }

    -- Scala
    paq {
        "derekwyatt/vim-scala",
        opt = true
    }

    -- SCSS
    paq {
        "cakebaker/scss-syntax.vim",
        opt = true
    }

    -- Shell
    paq {
        "arzg/vim-sh",
        opt = true
    }

    -- Slim
    paq {
        "slim-template/vim-slim",
        opt = true
    }

    -- Slime
    paq {
        "slime-lang/vim-slime-syntax",
        opt = true
    }

    -- SML
    paq {
        "jez/vim-better-sml",
        opt = true
    }

    -- SMT-LIB2
    paq {
        "bohlender/vim-smt2",
        opt = true
    }

    -- Solidity
    paq {
        "tomlion/vim-solidity",
        opt = true
    }

    -- Starlark
    paq {
        "cappyzawa/starlark.vim",
        opt = true
    }

    -- Sugarss
    paq {
        "hhsnopek/vim-sugarss",
        opt = true
    }

    -- Stylus
    paq {
        "wavded/vim-stylus",
        opt = true
    }

    -- Svelte
    paq {
        "leafOfTree/vim-svelte-plugin",
        opt = true
    }

    -- SVG
    paq {
        "jasonshell/vim-svg-indent",
        opt = true
    }

    -- SVG
    paq {
        "vim-scripts/svg.vim",
        opt = true
    }

    -- Swift
    paq {
        "keith/swift.vim",
        opt = true
    }

    -- Systemd
    paq {
        "wgwoods/vim-systemd-syntax",
        opt = true
    }

    -- SXHKD (bspwm)
    paq {
        "baskerville/vim-sxhkdrc",
        opt = true
    }

    -- Terraform
    paq {
        "hashivim/vim-terraform",
        opt = true
    }

    -- Textile
    paq {
        "timcharper/textile.vim",
        opt = true
    }

    -- Thrift
    paq {
        "solarnz/thrift.vim",
        opt = true
    }

    -- TomDoc
    paq {
        "wellbredgrapefruit/tomdoc.vim",
        opt = true
    }

    -- TPTP
    paq {
        "c-cube/vim-tptp",
        opt = true
    }

    -- Twig
    paq {
        "lumiliet/vim-twig",
        opt = true
    }

    -- V
    paq {
        "ollykel/v-vim",
        opt = true
    }

    -- Vala
    paq {
        "arrufat/vala.vim",
        opt = true
    }

    -- VB.NET
    paq {
        "vim-scripts/vbnet.vim",
        opt = true
    }

    -- VCL
    paq {
        "smerrill/vcl-vim-plugin",
        opt = true
    }

    -- Velocity
    paq {
        "lepture/vim-velocity",
        opt = true
    }

    -- vifm
    paq {
        "vifm/vifm.vim",
        opt = true
    }

    -- VHDL
    paq {
        "suoto/vim-hdl",
        opt = true
    }

    -- Vue
    paq {
        "posva/vim-vue",
        opt = true
    }

    -- XDC
    paq {
        "amal-khailtash/vim-xdc-syntax",
        opt = true
    }

    -- XSL
    paq {
        "vim-scripts/XSLT-syntax",
        opt = true
    }

    -- XML
    paq {
        "amadeus/vim-xml",
        opt = true
    }

    -- YAML
    paq {
        "stephpy/vim-yaml",
        opt = true
    }

    -- YANG
    paq {
        "nathanalderson/yang.vim",
        opt = true
    }

    -- YARD Documentation
    paq {
        "sheerun/vim-yardoc",
        opt = true
    }

    -- Zephir
    paq {
        "xwsoul/vim-zephir",
        opt = true
    }

    -- Zig
    paq {
        "ziglang/zig.vim",
        opt = true
    }
    -- Zinit
    paq {
        "zinit-zsh/zinit-vim-syntax",
        opt = true
    }

    -- Zsh
    paq {
        "chrisbra/vim-zsh",
        opt = true
    }
end

function M.install()
    plugins()
    Paq.install()
end

function M.update()
    plugins()
    Paq.update()
end

function M.clean()
    plugins()
    Paq.clean()
end

return M
