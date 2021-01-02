local packer = nil

local function init()
  if packer == nil then
    packer = require("packer")
    packer.init()
  end

  local use = packer.use
  packer.reset()

  use {"wbthomason/packer.nvim", opt = true}

  -- My spacemacs colorscheme
  use {
    "Th3Whit3Wolf/space-nvim-theme",
    branch = "main"
  }

  use {
    "Th3Whit3Wolf/Dusk-til-Dawn.nvim",
    opt = true,
    branch = "main",
    setup = function()
      vim.g.dusk_til_dawn_light_luafile =
        "~/.local/share/nvim/site/pack/packer/opt/space-nvim-theme/lua/space-nvim-theme.lua"
      vim.g.dusk_til_dawn_dark_luafile =
        "~/.local/share/nvim/site/pack/packer/opt/space-nvim-theme/lua/space-nvim-theme.lua"
      vim.g.dusk_til_dawn_morning = 7
      vim.g.dusk_til_dawn_night = 19
    end
  }

  -- neovim statusline plugin written in lua
  use {
    "glepnir/galaxyline.nvim",
    branch = "main",
    config = function()
      require "plugins.statusline"
    end
  }

  use {
    "glepnir/indent-guides.nvim",
    branch = "main"
  }

  -- Modern vim-startify
  use {"glepnir/dashboard-nvim"}

  -- A File Explorer For Neovim Written In Lua
  use {
    "kyazdani42/nvim-tree.lua",
    cmd = {
      "NvimTreeToggle",
      "NvimTreeRefresh",
      "NvimTreeFindFile"
    },
    -- devicons in lua
    requires = "kyazdani42/nvim-web-devicons"
  }

  -- auto completion framework that aims to provide a better completion experience with neovim's built-in LSP
  use {
    "nvim-lua/completion-nvim",
    config = function()
      require "plugins.lsp"
    end
  }

  -- Collection of common configurations for the Nvim LSP client.
  use {"neovim/nvim-lspconfig"}

  -- bunch of info & extension callbacks for built-in LSP (provides inlay hints)
  use {"tjdevries/lsp_extensions.nvim"}

  -- Snippet plugin for vim/nvim that supports LSP/VSCode's snippet forma
  use {"hrsh7th/vim-vsnip"}

  -- vim-vsnip integrations to other plugins
  use {"hrsh7th/vim-vsnip-integ"}

  --use "nvim-treesitter/completion-treesitter"
  use "kristijanhusak/vim-dadbod-completion"

  -- Completion for buffers word.
  use "steelsojka/completion-buffers"

  -- Treesitter configurations and abstraction layer for Neovim.
  -- use {
  --  "nvim-treesitter/nvim-treesitter",
  --  run = ":TSUpdate"
  --}

  -- high-performance color highlighter for Neovim
  use {
    "norcalli/nvim-colorizer.lua",
    opt = true
  }

  -- A surround text object plugin for neovim, written in lua.
  use {
    "blackcauldron7/surround.nvim",
    opt = true
  }

  use {
    "Raimondi/delimitMate",
    event = "InsertEnter *"
  }

  ----------
  -- Lazy --
  ----------

  -- uses the sign column to indicate added, modified and removed lines in a file that is managed by a version control system
  use {
    "mhinz/vim-signify",
    opt = true,
    config = function()
      vim.g.signify_sign_add = ""
      vim.g.signify_sign_delete = ""
      vim.g.signify_sign_delete_first_line = ""
      vim.g.signify_sign_change = ""
      vim.g.signify_sign_change = ""
    end
  }

  -- Vim sugar for the UNIX shell commands
  use {
    "tpope/vim-eunuch",
    cmd = {
      "Delete",
      "Unlink",
      "Move",
      "Rename",
      "Chmod",
      "Mkdir",
      "Cfind",
      "Clocate",
      "Lfind",
      "Llocate",
      "Wall",
      "SudoWrite",
      "SudoEdit"
    }
  }

  -- shows the history of commits under the cursor in popup window
  use {
    "rhysd/git-messenger.vim",
    cmd = "GitMessenger"
  }

  -- Vim plugin that shows keybindings in popup
  use {
    "liuchengxu/vim-which-key",
    opt = true
  }

  -- improves the git commit buffer
  use {
    "rhysd/committia.vim",
    opt = true
  }

  -- Asynchronously control git repositories in Neovim
  use {
    "lambdalisue/gina.vim",
    opt = true
  }

  -- A simple, easy-to-use Vim alignment plugin
  use {
    "junegunn/vim-easy-align"
  }

  -- Viewer & Finder for LSP symbols and tags
  use {
    "liuchengxu/vista.vim",
    cmd = "Vista"
    --config = function()
    -- How each level is indented and what to prepend.
    -- This could make the display more compact or more spacious.
    -- e.g., more compact: ["▸ ", ""]
    -- Note: this option only works the LSP executives, doesn't work for `:Vista ctags`
    --    vim.cmd [[ let g:vista_icon_indent = ["╰─▸ ", "├─▸ "] ]]
    -- Executive used when opening vista sidebar without specifying it.
    -- See all the avaliable executives via `:echo g:vista#executives`.
    --    vim.cmd [[ let g:vista_default_executive = 'ctags' ]]
    -- To enable fzf's preview window set g:vista_fzf_preview.
    -- The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
    -- For example:
    --    vim.cmd [[ let g:vista_fzf_preview = ['right:50%'] ]]
    -- Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
    --    vim.cmd [[ let g:vista#renderer#enable_icon = 1 ]]
    -- The default icons can't be suitable for all the filetypes, you can extend it as you wish.
    --    vim.cmd [[ let g:vista#renderer#icons = { "function": "\uf794", "variable": "\uf71b" } ]]
    --end
  }

  -- Auto close (X)HTML tags
  use {
    "alvan/vim-closetag",
    opt = true
  }

  use {
    "turbio/bracey.vim",
    run = "npm install --prefix server",
    opt = true
  }

  -- An asynchronous markdown preview plugin for Neovim
  use {
    "euclio/vim-markdown-composer",
    run = "cargo build --release",
    opt = true
  }

  -- Simpler Rainbow Parentheses
  use {
    "junegunn/rainbow_parentheses.vim",
    event = "InsertEnter *"
    -- config = function()
    --vim.cmd('RainbowParentheses')
    --end
  }

  -- Read DotEnv
  use {
    "tpope/vim-dotenv",
    cmd = "Dotenv"
  }

  -- Profiling
  use {
    "tweekmonster/startuptime.vim",
    cmd = "StartupTime"
  }

  -----------
  -- Prose --
  -----------

  -- Add all of these in  `lazy/git`
  -- Uncover usage problems in your writing
  use {
    "reedes/vim-wordy",
    cmd = {
      "PrevWordy",
      "Wordy",
      "NextWordy"
    }
  }

  -- Highlights overused words
  use {
    "dbmrq/vim-ditto",
    opt = true
  }

  -- Building on Vim’s spell-check and thesaurus/dictionary completion
  use {
    "reedes/vim-lexical",
    opt = true
  }

  -- handful of tweaks needed to smooth the path to writing prose
  use {
    "reedes/vim-pencil",
    opt = true
  }

  ---------------
  -- FTPlugins --
  ---------------

  -- ACPI ASL
  use {
    "martinlroth/vim-acpi-asl",
    ft = "asl"
  }

  -- Ansible 2.x
  use {
    "pearofducks/ansible-vim",
    ft = "ansible"
  }

  -- API Blueprint
  use {
    "sheerun/apiblueprint.vim",
    ft = "apiblueprint"
  }

  -- AppleScript
  use {
    "mityu/vim-applescript",
    ft = "applescript"
  }

  -- Arduino
  use {
    "sudar/vim-arduino-syntax",
    ft = "arduino"
  }

  -- AsciiDoc
  use {
    "asciidoc/vim-asciidoc",
    ft = "asciidoc"
  }

  -- BATS
  use {
    "aliou/bats.vim",
    ft = "bats"
  }

  -- Bazel
  use {
    "bazelbuild/vim-bazel",
    ft = "bzl"
  }

  -- Bazel
  use {
    "google/vim-maktaba",
    ft = "bzl"
  }

  -- Blade templates
  use {
    "jwalton512/vim-blade",
    ft = "blade"
  }

  -- Brewfile
  use {
    "bfontaine/Brewfile.vim",
    ft = "brewfile"
  }

  -- C#
  use {
    "OrangeT/vim-csharp",
    ft = {
      "cs",
      "xml",
      "cshtml.html",
      "aspx.html"
    }
  }

  -- C#
  use {
    "OmniSharp/omnisharp-vim",
    ft = {
      "cs",
      "omnisharplog"
    }
  }

  -- Caddyfile
  use {
    "isobit/vim-caddyfile",
    ft = "caddyfile"
  }

  -- Cargo Make (Rust cargo extension)
  use {
    "nastevens/vim-cargo-make",
    ft = "cargo-make"
  }

  -- Cargo.toml (Rust)
  use {
    "mhinz/vim-crates",
    opt = true
  }

  -- Carp
  use {
    "hellerve/carp-vim",
    ft = "carp"
  }

  -- Chef
  use {
    "vadv/vim-chef",
    ft = "chef"
  }

  -- Clojure
  use {
    "guns/vim-clojure-static",
    ft = "clojure"
  }

  -- Clojure
  use {
    "tpope/vim-fireplace",
    ft = "clojure"
  }

  -- Clojure
  use {
    "guns/vim-clojure-highlight",
    ft = "clojure"
  }

  -- Clojure
  use {
    "Olical/conjure",
    tag = "v4.8.0",
    ft = {
      "clojure",
      "fennel"
    }
  }

  -- LISP languages
  use {
    "eraserhd/parinfer-rust",
    ft = {
      "clojure",
      "lisp",
      "scheme",
      "racket",
      "jbuild",
      "fennel",
      "pddl"
    },
    run = "cargo build --release"
  }

  -- Cmake
  use {
    "pboettch/vim-cmake-syntax",
    ft = "cmake"
  }

  -- Cmake
  use {
    "vhdirk/vim-cmake",
    ft = "cmake"
  }

  -- CoffeScript
  use {
    "kchmck/vim-coffee-script",
    ft = "coffee"
  }

  -- CJSX (JSX equivalent in CoffeeScript)
  use {
    "mtscout6/vim-cjsx",
    ft = "coffee"
  }

  -- Cassandra CQL
  use {
    "elubow/cql-vim",
    ft = "cql"
  }

  -- Cryptol
  use {
    "victoredwardocallaghan/cryptol.vim",
    ft = "cryptol"
  }

  -- Crystal
  use {
    "vim-crystal/vim-crystal",
    ft = "crystal"
  }

  -- CSS
  use {
    "hail2u/vim-css3-syntax",
    ft = "css"
    --config = function()
    --    vim.bo = vim.api.nvim_get_option('iskeyword') .. ',-'
    --    vim.cmd('setlocal iskeyword+=-')
    --end
  }

  -- CSV
  use {
    "chrisbra/csv.vim",
    ft = "csv"
  }

  -- Cucumber
  use {
    "tpope/vim-cucumber",
    ft = "cucumber"
  }

  -- Cue
  use {
    "mgrabovsky/vim-cuesheet",
    ft = "cue"
  }

  -- D Lang
  use {
    "JesseKPhillips/d.vim",
    ft = {
      "d",
      "dcov",
      "dd",
      "ddoc",
      "dsdl"
    }
  }

  -- Dafny
  use {
    "mlr-msft/vim-loves-dafny",
    ft = "dafny"
  }

  -- Dart
  use {
    "dart-lang/dart-vim-plugin",
    ft = "dart"
  }

  -- Dhall
  use {
    "vmchale/dhall-vim",
    ft = "dhall"
  }

  -- Dockerfile
  use {
    "ekalinin/Dockerfile.vim",
    ft = {
      "yaml.docker-compose",
      "dockerfile"
    }
  }

  -- Duckscript
  use {
    "nastevens/vim-duckscript",
    ft = {
      "cargo-make",
      "duckscript"
    }
  }

  -- Elixir
  use {
    "elixir-editors/vim-elixir",
    ft = "elixir"
  }

  -- Emblem
  use {
    "yalesov/vim-emblem",
    ft = "emblem"
  }

  -- Erlang
  use {
    "vim-erlang/vim-erlang-runtime",
    ft = "erlang"
  }

  -- Fennel
  use {
    "bakpakin/fennel.vim",
    ft = "fennel"
  }

  -- Ferm
  use {
    "vim-scripts/ferm.vim",
    ft = "ferm"
  }

  -- Fish
  use {
    "georgewitteman/vim-fish",
    ft = "fish"
  }

  -- Flatbuffers
  use {
    "dcharbon/vim-flatbuffers",
    ft = "fbs"
  }

  -- Fountain
  use {
    "kblin/vim-fountain",
    ft = "fountain"
  }

  -- GDScript 3
  use {
    "calviken/vim-gdscript3",
    ft = {
      "gdscript3",
      "gsl",
      "gd"
    }
  }

  -- Git
  use {
    "tpope/vim-git",
    ft = {
      "git",
      "gitcommit",
      "gitconfig",
      "gitrebase",
      "gitsendemail"
    }
  }

  -- OpenGL Shading Language
  use {
    "tikhomirov/vim-glsl",
    ft = "glsl"
  }

  -- Gleam
  use {
    "gleam-lang/gleam.vim",
    ft = "gleam"
  }

  -- GMPL
  use {
    "maelvls/gmpl.vim",
    ft = "gmpl"
  }

  -- GNUPlot
  use {
    "vim-scripts/gnuplot-syntax-highlighting",
    ft = "gnuplot"
  }

  if vim.fn.executable("go") then
    -- Go
    use {
      "fatih/vim-go",
      ft = "go",
      run = ":GoUpdateBinaries"
    }
  end

  -- Gradle
  use {
    "tfnico/vim-gradle",
    ft = "groovy"
  }

  -- GraphQL
  use {
    "jparise/vim-graphql",
    ft = {
      "graphql",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue"
    }
  }

  -- Hack
  use {
    "hhvm/vim-hack",
    ft = "hack"
  }

  -- Haml
  use {
    "sheerun/vim-haml",
    ft = {
      "haml",
      "sass"
    }
  }

  -- Handlebars
  use {
    "mustache/vim-mustache-handlebars",
    ft = {
      "handlebars",
      "mustache"
    }
  }

  -- HAProxy
  use {
    "CH-DanReif/haproxy.vim",
    ft = "haproxy"
  }

  -- Haskel
  use {
    "neovimhaskell/haskell-vim",
    ft = "haskell"
  }

  -- Haxe
  use {
    "yaymukund/vim-haxe",
    ft = "haxe"
  }

  -- HCL
  use {
    "b4b4r07/vim-hcl",
    ft = "hcl"
  }

  -- Helm Templates
  use {
    "towolf/vim-helm",
    ft = "helm"
  }

  -- Hive
  use {
    "zebradil/hive.vim",
    ft = "hive"
  }

  -- HTML5
  use {
    "othree/html5.vim",
    ft = "html"
  }

  -- i3
  use {
    "mboughaba/i3config.vim",
    ft = "i3config"
  }

  -- icalendar
  use {
    "chutzpah/icalendar.vim",
    ft = "icalendar"
  }

  -- Idris
  use {
    "idris-hackers/idris-vim",
    ft = "idris"
  }

  -- Info
  use {
    "HiPhish/info.vim",
    ft = "info"
  }

  -- Ion
  use {
    "vmchale/ion-vim",
    ft = "ion"
  }

  -- ISPC
  use {
    "jez/vim-ispc",
    ft = "ispc"
  }

  -- JST
  use {
    "briancollins/vim-jst",
    ft = "jst"
  }

  -- JSX
  use {
    "maxmellon/vim-jsx-pretty",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact"
    }
  }

  -- Jenkins
  use {
    "martinda/Jenkinsfile-vim-syntax",
    ft = "jenkins"
  }

  -- Jinja
  use {
    "lepture/vim-jinja",
    ft = "jinja"
  }

  -- Json
  use {
    "elzr/vim-json",
    ft = "json"
  }

  -- Json5
  use {
    "GutenYe/json5.vim",
    ft = "json5"
  }

  -- Julia
  use {
    "JuliaEditorSupport/julia-vim",
    ft = "julia"
  }

  -- Kotlin
  use {
    "udalov/kotlin-vim",
    ft = "kotlin"
  }

  -- Latex
  use {
    "lervag/vimtex",
    ft = {
      "tex",
      "bib"
    }
  }

  -- Latex
  use {
    "xuhdev/vim-latex-live-preview",
    ft = "tex"
  }

  -- Ledger
  use {
    "ledger/vim-ledger",
    ft = "ledger"
  }

  -- Less
  use {
    "groenewege/vim-less",
    ft = "less"
  }

  -- Lilypond
  use {
    "sersorrel/vim-lilypond",
    ft = "lilypond"
  }

  -- LiveScript
  use {
    "gkz/vim-ls",
    ft = "ls"
  }

  -- Log
  use {
    "MTDL9/vim-log-highlighting",
    ft = "log"
  }

  -- Macports
  use {
    "jstrater/mpvim",
    ft = "portfile"
  }

  -- Mako
  use {
    "sophacles/vim-bundle-mako",
    ft = "mako"
  }

  -- Markdown
  use {
    "plasticboy/vim-markdown",
    ft = "markdown"
  }

  -- Markdown (Github)
  use {
    "rhysd/vim-gfm-syntax",
    opt = true
  }

  -- Mathematica
  use {
    "voldikss/vim-mma",
    ft = "mma"
  }

  -- Matlab
  use {
    "daeyun/vim-matlab",
    ft = "matlab"
  }

  -- MDX
  use {
    "jxnblk/vim-mdx-js",
    ft = "mdx"
  }

  -- Mercury
  use {
    "stewy33/mercury-vim",
    ft = "mercury"
  }

  -- MoonScript
  use {
    "leafo/moonscript-vim",
    ft = "moon"
  }

  -- Nginx
  use {
    "chr4/nginx.vim",
    ft = "nginx"
  }

  -- Nim
  use {
    "zah/nim.vim",
    ft = "nim"
  }

  -- Nix
  use {
    "LnL7/vim-nix",
    ft = "nix"
  }

  -- Objective-C
  use {
    "b4winckler/vim-objc",
    ft = "objc"
  }

  -- OCaml
  use {
    "ocaml/vim-ocaml",
    ft = {
      "dune",
      "oasis",
      "ocaml",
      "ocamlbuild_tags",
      "omake",
      "sexplib"
    }
  }

  -- Octave
  use {
    "McSinyx/vim-octave",
    ft = "octave"
  }

  -- Pawn
  use {
    "mcnelson/vim-pawn",
    ft = "pawn"
  }

  -- Pandoc
  use {
    "vim-pandoc/vim-pandoc",
    ft = "pandoc"
  }

  -- Pandoc
  use {
    "vim-pandoc/vim-pandoc-syntax",
    ft = "pandoc"
  }

  -- PERL
  use {
    "vim-perl/vim-perl",
    ft = {
      "perl",
      "perl6"
    }
  }

  -- PostgreSQL
  use {
    "lifepillar/pgsql.vim",
    ft = "pgsql"
  }

  -- PHP
  use {
    "StanAngeloff/php.vim",
    ft = "php"
  }

  -- PlantUML
  use {
    "aklt/plantuml-syntax",
    ft = "plantuml"
  }

  -- Ponylang
  use {
    "jakwings/vim-pony",
    ft = "pony"
  }

  -- PowerShell
  use {
    "PProvost/vim-ps1",
    ft = {
      "ps1",
      "ps1xml"
    }
  }

  -- Prolog
  use {
    "adimit/prolog.vim",
    ft = "prolog"
  }

  -- Protocol Buffers
  use {
    "uarun/vim-protobuf",
    ft = "proto"
  }

  -- Pug
  use {
    "digitaltoad/vim-pug",
    ft = "pug"
  }

  -- Puppet
  use {
    "rodjek/vim-puppet",
    ft = {
      "puppet",
      "embeddedpuppet"
    }
  }

  -- PureScript
  use {
    "purescript-contrib/purescript-vim",
    ft = "purescript"
  }

  -- QMake
  use {
    "artoj/qmake-syntax-vim",
    ft = "qmake"
  }

  -- QML
  use {
    "peterhoeg/vim-qml",
    ft = "qml"
  }

  -- R
  use {
    "jalvesaq/Nvim-R",
    ft = "r"
  }

  -- Racket
  use {
    "wlangstroth/vim-racket",
    ft = "racket"
  }

  -- Ragel
  use {
    "jneen/ragel.vim",
    ft = "ragel"
  }

  -- Raku
  use {
    "Raku/vim-raku",
    ft = "raku"
  }

  -- RAML
  use {
    "IN3D/vim-raml",
    ft = "raml"
  }

  -- Razor view engine
  use {
    "adamclerk/vim-razor",
    ft = "razor"
  }

  -- Reason
  use {
    "reasonml-editor/vim-reason-plus",
    ft = "reason"
  }

  -- reStructuredText
  use {
    "marshallward/vim-restructuredtext",
    ft = "rst"
  }

  -- RSpec
  use {
    "keith/rspec.vim",
    ft = "rspec"
  }

  -- RON
  use {
    "ron-rs/ron.vim",
    ft = "ron"
  }

  -- Ruby
  use {
    "vim-ruby/vim-ruby",
    ft = {
      "eruby",
      "ruby"
    }
  }

  -- Rust
  use {
    "rust-lang/rust.vim",
    ft = "rust"
  }

  -- SBT
  use {
    "derekwyatt/vim-sbt",
    ft = "sbt"
  }

  -- Scala
  use {
    "derekwyatt/vim-scala",
    ft = "scala"
  }

  -- SCSS
  use {
    "cakebaker/scss-syntax.vim",
    ft = "scss"
  }

  -- Shell
  use {
    "arzg/vim-sh",
    ft = "sh"
  }

  -- Slim
  use {
    "slim-template/vim-slim",
    ft = "slim"
  }

  -- Slime
  use {
    "slime-lang/vim-slime-syntax",
    ft = "slime"
  }

  -- SML
  use {
    "jez/vim-better-sml",
    ft = "sml"
  }

  -- SMT-LIB2
  use {
    "bohlender/vim-smt2",
    ft = "smt2"
  }

  -- Solidity
  use {
    "tomlion/vim-solidity",
    ft = "solidity"
  }

  -- Starlark
  use {
    "cappyzawa/starlark.vim",
    ft = "starlark"
  }

  -- Sugarss
  use {
    "hhsnopek/vim-sugarss",
    ft = "sugarss"
  }

  -- Stylus
  use {
    "wavded/vim-stylus",
    ft = "stylus"
  }

  -- Svelte
  use {
    "leafOfTree/vim-svelte-plugin",
    ft = "svelte"
    --config = function()
    --    vim.g.vim_svelte_plugin_load_full_syntax = 1
    --end
  }

  -- SVG
  use {
    "jasonshell/vim-svg-indent",
    ft = "svg"
  }

  -- SVG
  use {
    "vim-scripts/svg.vim",
    ft = "svg"
  }

  -- Swift
  use {
    "keith/swift.vim",
    ft = "swift"
  }

  -- Systemd
  use {
    "wgwoods/vim-systemd-syntax",
    ft = "systemd"
  }

  -- SXHKD (bspwm)
  use {
    "baskerville/vim-sxhkdrc",
    ft = "sxhkdrc"
  }

  -- Terraform
  use {
    "hashivim/vim-terraform",
    ft = "terraform"
  }

  -- Textile
  use {
    "timcharper/textile.vim",
    ft = "textile"
  }

  -- Thrift
  use {
    "solarnz/thrift.vim",
    ft = "thrift"
  }

  -- TomDoc
  use {
    "wellbredgrapefruit/tomdoc.vim",
    ft = "tomdoc"
  }

  -- TPTP
  use {
    "c-cube/vim-tptp",
    ft = "tptp"
  }

  -- Twig
  use {
    "lumiliet/vim-twig",
    ft = "twig"
  }

  -- V
  use {
    "ollykel/v-vim",
    ft = {
      "v",
      "vlang"
    }
  }

  -- Vala
  use {
    "arrufat/vala.vim",
    ft = "vala"
  }

  -- VB.NET
  use {
    "vim-scripts/vbnet.vim",
    ft = "vb.net"
  }

  -- VCL
  use {
    "smerrill/vcl-vim-plugin",
    ft = "vcl"
  }

  -- Velocity
  use {
    "lepture/vim-velocity",
    ft = "velocity"
  }

  -- vifm
  use {
    "vifm/vifm.vim",
    ft = {
      "vifm",
      "vifm-rename"
    }
  }

  -- VHDL
  use {
    "suoto/vim-hdl",
    ft = "vhdl"
  }

  -- Vue
  use {
    "posva/vim-vue",
    ft = "vue"
  }

  -- XDC
  use {
    "amal-khailtash/vim-xdc-syntax",
    ft = "xdc"
  }

  -- XSL
  use {
    "vim-scripts/XSLT-syntax",
    ft = "xsl"
  }

  -- XML
  use {
    "amadeus/vim-xml",
    ft = "xml"
  }

  -- YAML
  use {
    "stephpy/vim-yaml",
    ft = "yaml"
  }

  -- YANG
  use {
    "nathanalderson/yang.vim",
    ft = "yang"
  }

  -- YARD Documentation
  use {
    "sheerun/vim-yardoc",
    ft = {
      "eruby",
      "ruby"
    }
  }

  -- Zephir
  use {
    "xwsoul/vim-zephir",
    ft = "zephir"
  }

  -- Zig
  use {
    "ziglang/zig.vim",
    ft = "zig"
  }

  -- Zinit
  use {
    "zinit-zsh/zinit-vim-syntax",
    ft = "zsh"
  }

  -- Zsh
  use {
    "chrisbra/vim-zsh",
    ft = "zsh"
  }
end

local plugins =
  setmetatable(
  {},
  {
    __index = function(_, key)
      init()
      return packer[key]
    end
  }
)
return plugins
