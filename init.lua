vim.cmd(
    [[
    " Modeline and Notes {
    "   vim: set foldmarker={,} foldlevel=0 spell:
    "
    "   source:
    "   http://robertmelton.com/contact (many forms of communication)
    "   also used this guide:
    "   http://amix.dk/vim/vimrc.html
    " }

    " Basics {
    set nocompatible " explicitly get out of vi-compatible mode
    set noexrc " don't use local version of .(g)vimrc, .exrc
    set t_Co=256 "To enable 256 colors
    "    set background=dark " we plan to use a dark background
    set cpoptions=aABceFsmq
    "             |||||||||
    "             ||||||||+-- When joining lines, leave the cursor
    "             |||||||      between joined lines
    "             |||||||+-- When a new match is created (showmatch)
    "             ||||||      pause for .5
    "             ||||||+-- Set buffer options when entering the
    "             |||||      buffer
    "             |||||+-- :write command updates current file name
    "             ||||+-- Automatically add <CR> to the last line
    "             |||      when using :@r
    "             |||+-- Searching continues at the end of the match
    "             ||      at the cursor position
    "             ||+-- A backslash has no special meaning in mappings
    "             |+-- :write updates alternative file name
    "             +-- :read updates alternative file name
    syntax on " syntax highlighting on
    " }

    " Mappings {
    let mapleader=','

    " ROT13 - fun
    map <F12> ggVGg?

    " space / shift-space scroll in normal mode
    "noremap <S-space> <C-b>
    "noremap <space> <C-f>

    " Make Arrow Keys Useful Again {
    map <down> <ESC>:bn<RETURN>
    map <left> <ESC>:NERDTreeToggle<RETURN>
    map <right> <ESC>:TagbarToggle<RETURN>
    map <up> <ESC>:bp<RETURN>
    " }
    " paste toggle from http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
    set pastetoggle=<F2>

    " aleternate buffer
    map <Leader>bb :b#<CR>

    " }

    " General {
    filetype plugin indent on " load filetype plugins/indent settings
    set autoread " Set to auto read when a file is changed from the outside
    "set autochdir " always switch to the current file directory
    set backspace=indent,eol,start " make backspace a more flexible
    "set backup " make backup files
    "set backupdir=~/.vim/backup " where to put backup files
    set clipboard+=unnamed " share windows clipboard
    "set directory=~/.vim/tmp " directory to place swap files in
    set noswapfile
    set fileformats=unix,dos,mac " support all three, in this order
    set hidden " you can change buffers without saving
    " (XXX: #VIM/tpope warns the line below could break things)
    set iskeyword+=_,$,@,%,# " none of these are word dividers
    "set mouse=a " use mouse everywhere
    set noerrorbells " don't make noise
    set whichwrap=b,s,h,l,<,>,~,[,] " everything wraps
    "             | | | | | | | | |
    "             | | | | | | | | +-- "]" Insert and Replace
    "             | | | | | | | +-- "[" Insert and Replace
    "             | | | | | | +-- "~" Normal
    "             | | | | | +-- <Right> Normal and Visual
    "             | | | | +-- <Left> Normal and Visual
    "             | | | +-- "l" Normal and Visual (not recommended)
    "             | | +-- "h" Normal and Visual (not recommended)
    "             | +-- <Space> Normal and Visual
    "             +-- <BS> Normal and Visual
    set wildmenu " turn on command line completion wild style
    " ignore these list file extensions
    set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,
    \*.jpg,*.gif,*.png
    set wildmode=list:longest " turn on wild mode huge list
    " }

    " Vim UI {
    set cursorcolumn " highlight the current column
    set cursorline " highlight current line
    set incsearch " BUT do highlight as you type you
    " search phrase
    set laststatus=2 " always show the status line
    set lazyredraw " do not redraw while running macros
    set linespace=0 " don't insert any extra pixel lines
    " betweens rows
    set list " we do what to show tabs, to ensure we get them
    " out of my files
    set listchars=tab:>-,trail:- " show tabs and trailing
    set matchtime=5 " how many tenths of a second to blink
    " matching brackets for
    set nohlsearch " do not highlight searched for phrases
    set nostartofline " leave my cursor where it was
    set novisualbell " don't blink
    set number " turn on line numbers
    set numberwidth=5 " We are good up to 99999 lines
    set report=0 " tell us when anything is changed via :...
    set ruler " Always show current positions along the bottom
    set scrolloff=10 " Keep 10 lines (top/bottom) for scope
    set shortmess=aOstT " shortens messages to avoid
    " 'press a key' prompt
    set showcmd " show the command being typed
    set showmatch " show matching brackets
    set sidescrolloff=10 " Keep 5 lines at the size
    set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
    "              | | | | |  |   |      |  |     |    |
    "              | | | | |  |   |      |  |     |    + current
    "              | | | | |  |   |      |  |     |       column
    "              | | | | |  |   |      |  |     +-- current line
    "              | | | | |  |   |      |  +-- current % into file
    "              | | | | |  |   |      +-- current syntax in
    "              | | | | |  |   |          square brackets
    "              | | | | |  |   +-- current fileformat
    "              | | | | |  +-- number of lines
    "              | | | | +-- preview flag in square brackets
    "              | | | +-- help flag in square brackets
    "              | | +-- readonly flag in square brackets
    "              | +-- rodified flag in square brackets
    "              +-- full path to file in the buffer
    set so=7 " Set 7 lines to the curors - when moving vertical..
    "set cmdheight=2 " The commandbar height
    set magic "Set magic on, for regular expressions
    " }

    " Text Formatting/Layout {
    set completeopt= " don't use a pop up menu for completions
    set expandtab " no real tabs please!
    set formatoptions=rq " Automatically insert comment leader on return,
    " and let gq format comments
    set ignorecase " case insensitive by default
    set infercase " case inferred by default
    set nowrap " do not wrap line
    set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
    set smartcase " if there are caps, go case-sensitive
    set shiftwidth=4 " auto-indent amount when using cindent,
    " >>, << and stuff like that
    set softtabstop=4 " when hitting tab or backspace, how many spaces
    "should a tab be (see expandtab)
    set tabstop=4 " real tabs should be 8, and they will show with
    " set list on
    " }

    " Visual mode related {
    vnoremap <silent> * :call VisualSearch('f')<CR> " In visual mode when you press *
    vnoremap <silent> # :call VisualSearch('b')<CR> " or # to search for the current selection

    "   When you press gv you vimgrep after the selected text
    vnoremap <silent> gv :call VisualSearch('gv')<cr>
    map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

    function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
    endfunction

    function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
    endfunction
    " }

    " Folding {
    set foldenable " Turn on folding
    set foldmarker={,} " Fold C style code (only use this as default
    " if you use a high foldlevel)
    set foldmethod=marker " Fold on the marker

    function! JavaScriptFold() "{
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()"}
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
    endfunction
    "From http://vim.wikia.com/wiki/Folding
    "In normal mode, press Space to toggle the current fold open/closed.
    "However, if the cursor is not in a fold, move to the right 
    "(the default behavior).
    nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
    vnoremap <Space> zf
    "}
    " }

]]
)
-- Lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)

-- Lazy.nvim configuration
require("lazy").setup(
    {
        -- General plugins
        {
            "nvim-lua/plenary.nvim",
            "tpope/vim-fugitive",
            "tpope/vim-sleuth",
            "nvim-tree/nvim-tree.lua",
            "nvim-lualine/lualine.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim"
        },
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            dependencies = {
                {"williamboman/mason.nvim", opts = true},
                {"williamboman/mason-lspconfig.nvim", opts = true}
            },
            opts = {
                ensure_installed = {
                    "pyright", -- LSP for python
                    "ruff", -- linter for python (includes flake8, pep8, etc.)
                    "debugpy", -- debugger
                    "black", -- formatter
                    "isort", -- organize imports
                    "taplo" -- LSP for toml (for pyproject.toml files)
                }
            }
        },
        {
            "Mofiqul/adwaita.nvim",
            lazy = false,
            priority = 1000,
            -- configure and set on startup
            config = function()
                vim.g.adwaita_darker = true -- for darker version
                vim.g.adwaita_disable_cursorline = true -- to disable cursorline
                vim.g.adwaita_transparent = true -- makes the background transparent
                vim.cmd("colorscheme adwaita")
            end
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = {"nvim-tree/nvim-web-devicons"},
            config = function()
                require("lualine").setup {
                    options = {
                        icons_enabled = true,
                        theme = "auto",
                        component_separators = {left = "", right = ""},
                        section_separators = {left = "", right = ""},
                        disabled_filetypes = {
                            statusline = {},
                            winbar = {}
                        },
                        ignore_focus = {},
                        always_divide_middle = true,
                        globalstatus = false,
                        refresh = {
                            statusline = 1000,
                            tabline = 1000,
                            winbar = 1000
                        }
                    },
                    sections = {
                        lualine_a = {"mode"},
                        lualine_b = {"branch", "diff", "diagnostics"},
                        lualine_c = {"filename"},
                        lualine_x = {"encoding", "fileformat", "filetype"},
                        lualine_y = {"progress"},
                        lualine_z = {"location"}
                    },
                    inactive_sections = {
                        lualine_a = {},
                        lualine_b = {},
                        lualine_c = {"filename"},
                        lualine_x = {"location"},
                        lualine_y = {},
                        lualine_z = {}
                    },
                    tabline = {},
                    winbar = {},
                    inactive_winbar = {},
                    extensions = {}
                }
            end
        },
        {"preservim/nerdcommenter"},
        {
            "kylechui/nvim-surround",
            version = "*", -- Use for stability; omit to use `main` branch for the latest features
            event = "VeryLazy",
            config = function()
                require("nvim-surround").setup({})
            end
        },
        {"lambdalisue/suda.vim"},
        {"lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}},
        {"Darazaki/indent-o-matic"},
        --{"Darazaki/indent-o-matic",
        --config = function()
        --require('indent-o-matic').setup ({
        ---- The values indicated here are the defaults

        ---- Number of lines without indentation before giving up (use -1 for infinite)
        --max_lines = 2048,

        ---- Space indentations that should be detected
        --standard_widths = { 2, 4, 8 },

        ---- Skip multi-line comments and strings (more accurate detection but less performant)
        --skip_multiline = true,
        --})
        --end
        --},
        {"Raimondi/delimitMate"},
        -- TODO telescope can't find . files, doesn't open using ,ff on new files and end of files
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {"nvim-lua/plenary.nvim", "BurntSushi/ripgrep"},
            keys = {
                {"<leader>ff", " <cmd>Telescope find_files<cr>", desc = "Telescope Find Files"},
                {"<leader>fg", " <cmd>Telescope live_grep<cr>", desc = "Telescope Live Grep"},
                {"<leader>fb", " <cmd>Telescope buffers<cr>", desc = "Telescope Buffers"},
                {"<leader>fh", " <cmd>Telescope help_tags<cr>", desc = "Telescope Help Tags"}
            }
        },
        {
            "debugloop/telescope-undo.nvim",
            dependencies = {"nvim-telescope/telescope.nvim"},
            keys = {
                {
                    -- lazy style key map
                    "<leader>u",
                    "<cmd>Telescope undo<cr>",
                    desc = "undo history"
                },
                opts = {
                    extensions = {
                        undo = {}
                    }
                },
                config = function(_, opts)
                    -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
                    -- configs for us. We won't use data, as everything is in it's own namespace (telescope
                    -- defaults, as well as each extension).
                    require("telescope").setup(opts)
                    require("telescope").load_extension("undo")
                end
            }
        },
        {
            "gbprod/yanky.nvim",
            opts = {},
            keys = {
                {"<leader>p", function()
                    require("telescope").extensions.yank_history.yank_history({})
                end, desc = "Open Yank History"},
                {"y", "<Plug>(YankyYank)", mode = {"n", "x"}, desc = "Yank text"},
                {"p", "<Plug>(YankyPutAfter)", mode = {"n", "x"}, desc = "Put yanked text after cursor"},
                {"P", "<Plug>(YankyPutBefore)", mode = {"n", "x"}, desc = "Put yanked text before cursor"},
                {"gp", "<Plug>(YankyGPutAfter)", mode = {"n", "x"}, desc = "Put yanked text after selection"},
                {"gP", "<Plug>(YankyGPutBefore)", mode = {"n", "x"}, desc = "Put yanked text before selection"},
                {"[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history"},
                {"]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history"},
                {"]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)"},
                {"[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)"},
                {"]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)"},
                {"[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)"},
                {">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right"},
                {"<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left"},
                {">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right"},
                {"<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left"},
                {"=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter"},
                {"=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter"}
            }
        },
        -- Python-specific plugins
        {
            "neovim/nvim-lspconfig",
            config = function()
                require("lspconfig").pyright.setup {
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "basic"
                            }
                        }
                    }
                }
            end
        },
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "saadparwaiz1/cmp_luasnip",
                "L3MON4D3/LuaSnip"
            },
            config = function()
                local cmp = require("cmp")
                cmp.setup {
                    mapping = cmp.mapping.preset.insert(
                        {
                            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                            ["<C-f>"] = cmp.mapping.scroll_docs(4),
                            ["<C-Space>"] = cmp.mapping.complete(),
                            ["<C-e>"] = cmp.mapping.abort(),
                            ["<CR>"] = cmp.mapping.confirm({select = true})
                        }
                    ),
                    sources = cmp.config.sources(
                        {
                            {name = "nvim_lsp"},
                            {name = "luasnip"},
                            {name = "buffer"},
                            {name = "path"}
                        }
                    )
                }
            end
        },
        {
            "saadparwaiz1/cmp_luasnip",
            dependencies = {
                "L3MON4D3/LuaSnip"
            },
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end
        },
        {
            "folke/trouble.nvim",
            config = function()
                require("trouble").setup {}
            end
        },
        -- Formatting client: conform.nvim
        -- - configured to use black & isort in python
        -- - use the taplo-LSP for formatting in toml
        -- - Formatting is triggered via `<leader>f`, but also automatically on save
        {
            "stevearc/conform.nvim",
            event = "BufWritePre", -- load the plugin before saving
            keys = {
                {
                    "<leader>c",
                    function()
                        require("conform").format({lsp_fallback = true})
                    end,
                    desc = "Format"
                }
            },
            opts = {
                formatters_by_ft = {
                    -- first use isort and then black
                    python = {"isort", "black"},
                    -- "inject" is a special formatter from conform.nvim, which
                    -- formats treesitter-injected code. Basically, this makes
                    -- conform.nvim format python codeblocks inside a markdown file.
                    markdown = {"inject"}
                },
                -- enable format-on-save
                format_on_save = {
                    -- when no formatter is setup for a filetype, fallback to formatting
                    -- via the LSP. This is relevant e.g. for taplo (toml LSP), where the
                    -- LSP can handle the formatting for us
                    lsp_fallback = true
                }
            }
        },
        -----------------------------------------------------------------------------
        -- PYTHON REPL
        -- A basic REPL that opens up as a horizontal split
        -- - use `<leader>i` to toggle the REPL
        -- - use `<leader>I` to restart the REPL
        -- - `+` serves as the "send to REPL" operator. That means we can use `++`
        -- to send the current line to the REPL, and `+j` to send the current and the
        -- following line to the REPL, like we would do with other vim operators.
        {
            "Vigemus/iron.nvim",
            keys = {
                {"<leader>i", vim.cmd.IronRepl, desc = "󱠤 Toggle REPL"},
                {"<leader>I", vim.cmd.IronRestart, desc = "󱠤 Restart REPL"},
                -- these keymaps need no right-hand-side, since that is defined by the
                -- plugin config further below
                {"+", mode = {"n", "x"}, desc = "󱠤 Send-to-REPL Operator"},
                {"++", desc = "󱠤 Send Line to REPL"}
            },
            -- since irons's setup call is `require("iron.core").setup`, instead of
            -- `require("iron").setup` like other plugins would do, we need to tell
            -- lazy.nvim which module to via the `main` key
            main = "iron.core",
            opts = {
                keymaps = {
                    send_line = "++",
                    visual_send = "+",
                    send_motion = "+"
                },
                config = {
                    -- this defined how the repl is opened. Here we set the REPL window
                    -- to open in a horizontal split to a bottom, with a height of 10
                    -- cells.
                    repl_open_cmd = "horizontal bot 10 split",
                    -- This defines which binary to use for the REPL. If `ipython` is
                    -- available, it will use `ipython`, otherwise it will use `python3`.
                    -- since the python repl does not play well with indents, it's
                    -- preferable to use `ipython` or `bypython` here.
                    -- (see: https://github.com/Vigemus/iron.nvim/issues/348)
                    repl_definition = {
                        python = {
                            command = function()
                                local ipythonAvailable = vim.fn.executable("ipython") == 1
                                local binary = ipythonAvailable and "ipython" or "python3"
                                return {binary}
                            end
                        }
                    }
                }
            }
        },
        -- SYNTAX HIGHLIGHTING

        -- treesitter for syntax highlighting
        -- - auto-installs the parser for python
        {
            "nvim-treesitter/nvim-treesitter",
            -- automatically update the parsers with every new release of treesitter
            build = ":TSUpdate",
            -- since treesitter's setup call is `require("nvim-treesitter.configs").setup`,
            -- instead of `require("nvim-treesitter").setup` like other plugins do, we
            -- need to tell lazy.nvim which module to via the `main` key
            main = "nvim-treesitter.configs",
            opts = {
                highlight = {enable = true}, -- enable treesitter syntax highlighting
                indent = {enable = true},
                ensure_installed = {
                    -- auto-install the Treesitter parser for python and related languages
                    "python",
                    "toml",
                    "rst",
                    "ninja",
                    "lua",
                    -- needed for formatting code-blockcs inside markdown via conform.nvim
                    "markdown",
                    "markdown_inline"
                }
            }
        },
        -----------------------------------------------------------------------------
        -- EDITING SUPPORT PLUGINS
        -- some plugins that help with python-specific editing operations

        -- Docstring creation
        -- - quickly create docstrings via `<leader>a`
        {
            "danymat/neogen",
            opts = true,
            keys = {
                {
                    "<leader>a",
                    function()
                        require("neogen").generate()
                    end,
                    desc = "Add Docstring"
                }
            }
        },
        {
            "chrisgrieser/nvim-puppeteer",
            lazy = false,
            dependencies = "nvim-treesitter/nvim-treesitter"
        },
        -- better indentation behavior
        -- by default, vim has some weird indentation behavior in some edge cases,
        -- which this plugin fixes
        {"Vimjas/vim-python-pep8-indent"},
        -----------------------------------------------------------------------------
        -- DEBUGGING

        -- DAP Client for nvim
        -- - start the debugger with `<leader>dc`
        -- - add breakpoints with `<leader>db`
        -- - terminate the debugger `<leader>dt`
        -- working config from https://github.com/igorlfs/dotfiles/blob/main/nvim/.config/nvim/lua/plugins/nvim-dap.lua
        {
        "mfussenegger/nvim-dap",
            dependencies = {
                -- Runs preLaunchTask / postDebugTask if present
                {"stevearc/overseer.nvim", config = true},
                "rcarriga/nvim-dap-ui"
            },
            keys = {
                {
                    "<leader>ds",
                    function()
                        local widgets = require("dap.ui.widgets")
                        widgets.centered_float(widgets.scopes, {border = "rounded"})
                    end,
                    desc = "DAP Scopes"
                },
                {"<F2>", function()
                    require("dap.ui.widgets").hover(nil, {border = "rounded"})
                end},
                {"<F4>", "<CMD>DapDisconnect<CR>", desc = "DAP Disconnect"},
                {"<leader>dt", "<CMD>DapTerminate<CR>", desc = "DAP Terminate"},
                {"<leader>dc", "<CMD>DapContinue<CR>", desc = "DAP Continue"},
                { "<leader>dj", function() require("dap").down() end, desc = "Down" },
                { "<leader>dk", function() require("dap").up() end, desc = "Up" },
                {"<leader>dl", function()
                    require("dap").run_last()
                end, desc = "Run Last"},
                {"<leader>dC", function()
                    require("dap").run_to_cursor()
                end, desc = "Run to Cursor"},
                {"<leader>db", "<CMD>DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint"},
                {
                    "<leader>dB",
                    function()
                        vim.ui.input(
                            {prompt = "Breakpoint condition: "},
                            function(input)
                                require("dap").set_breakpoint(input)
                            end
                        )
                    end,
                    desc = "Conditional Breakpoint"
                },
                {"<leader>dO", "<CMD>DapStepOver<CR>", desc = "Step Over"},
                --{"<leader>di", "<CMD>DapStepInto<CR>", desc = "Step Into"},
                --{"<leader>do", "<CMD>DapStepOut<CR>", desc = "Step Out"},
                { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
                { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
                { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            },
            config = function()
                -- Signs
                local sign = vim.fn.sign_define

                local dap_round_groups = {
                    "DapBreakpoint",
                    "DapBreakpointCondition",
                    "DapBreakpointRejected",
                    "DapLogPoint"
                }
                for _, group in pairs(dap_round_groups) do
                    sign(group, {text = "●", texthl = group})
                end

                local dap = require("dap")

                -- Adapters
                -- Python
                dap.adapters.python = function(cb, config)
                    if config.request == "attach" then
                        ---@diagnostic disable-next-line: undefined-field
                        local port = (config.connect or config).port
                        ---@diagnostic disable-next-line: undefined-field
                        local host = (config.connect or config).host or "localhost"
                        cb(
                            {
                                type = "server",
                                port = assert(port, "`connect.port` is required for a python `attach` configuration"),
                                host = host
                            }
                        )
                    else
                        cb(
                            {
                                type = "executable",
                                command = "debugpy-adapter"
                            }
                        )
                    end
                end
                -- DAP configurations for Python
                dap.configurations.python = {
                    {
                        name = "Launch",
                        type = "python",
                        request = "launch",
                        program = "${file}",
                        console = "integratedTerminal",
                        justMyCode = false,
                        on_exit = function(_, return_value)
                            if return_value ~= 0 then
                                print("Stack trace:")
                                vim.fn.system("python -m pdb --stacktrace " .. vim.fn.expand("%"))
                            end
                        end
                    },
                }
            end,
        },

        -- UI for the debugger
        -- - the debugger UI is also automatically opened when starting/stopping the debugger
        -- - toggle debugger UI manually with `<leader>du`
        {
            "rcarriga/nvim-dap-ui",
            dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
            opts = {
                icons = {
                    expanded = "󰅀",
                    collapsed = "󰅂",
                    current_frame = "󰅂"
                },
                --layouts = {
                    --{
                        --elements = {"console", "watches"},
                        --position = "bottom",
                        --size = 10
                    --}
                --},
                expand_lines = false,
                controls = {
                    enabled = true
                },
                floating = {
                    border = "rounded"
                },
                render = {
                    indent = 2,
                    -- Hide variable types as C++'s are verbose
                    max_type_length = 0
                }
            },
            --opts = {},
            keys = {
                {"<leader>du", function()
                    require("dapui").toggle({})
                end, desc = "Dap UI"},
                {"<leader>de", function()
                    require("dapui").eval()
                end, desc = "Eval", mode = {"n", "v"}},
                {"<leader>Dc", function()
                    require("dapui").close({})
                    require("dap").disconnect()  -- Close the DAP terminal
                end, desc = "Close DAP UI and Terminal"}   
            },
            config = function(_, opts)
                local dap = require("dap")
                local dapui = require("dapui")
                dapui.setup(opts)
                dap.listeners.after.event_initialized["dapui_config"] = function()
                    dapui.open({})
                end
                --dap.listeners.before.event_terminated["dapui_config"] = function()
                    --dapui.close({})
                --end
                --dap.listeners.before.event_exited["dapui_config"] = function()
                    --dapui.close({})
                --end
                require("dapui").setup(opts)
            end
        },
        -- Configuration for the python debugger
        -- - configures debugpy for us
        -- - uses the debugpy installation from mason
        {
            "mfussenegger/nvim-dap-python",
            keys = {
                {
                    mode = "n",
                    "<leader>df",
                    function()
                        require("dap-python").test_method()
                    end
                }
            },
            config = function()
                require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
                require("dap-python").test_runner = "pytest"
            end
        },
        -- select virtual environments
        -- - makes pyright and debugpy aware of the selected virtual environment
        -- - Select a virtual environment with `:VenvSelect`
        {
            "linux-cultist/venv-selector.nvim",
            dependencies = {
                "neovim/nvim-lspconfig",
                "nvim-telescope/telescope.nvim",
                "mfussenegger/nvim-dap-python"
            },
            opts = {
                dap_enabled = true -- makes the debugger work with venv
            }
        },
        {
            "linux-cultist/venv-selector.nvim",
            dependencies = {
                "neovim/nvim-lspconfig",
                "mfussenegger/nvim-dap",
                "mfussenegger/nvim-dap-python", --optional
                {"nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = {"nvim-lua/plenary.nvim"}}
            },
            lazy = false,
            branch = "regexp", -- This is the regexp branch, use this for the new version
            config = function()
                require("venv-selector").setup()
            end,
            keys = {
                {",v", "<cmd>VenvSelect<cr>"}
            },
            opts = {
                dap_enabled = true -- makes the debugger work with venv
            }
        },
        --  Markdown
        {
            "iamcco/markdown-preview.nvim",
            --build = function() vim.fn["mkdp#util#install"]() end,
            ft = "markdown",
            keys = {{"<A-o>", "<CMD>MarkdownPreviewToggle<CR>", desc = "Toggle Markdown Preview"}}
        },
        -- CSV
        {
            "emmanueltouzery/decisive.nvim",
            ft = "csv",
            keys = {
                {
                    "<leader><leader>",
                    function()
                        require("decisive").align_csv({})
                    end,
                    desc = "Align CSV"
                }
            }
        }
    }
)

--------------------------------------------------------------------------------
-- SETUP BASIC PYTHON-RELATED OPTIONS

-- The filetype-autocmd runs a function when opening a file with the filetype
-- "python". This method allows you to make filetype-specific configurations. In
-- there, you have to use `opt_local` instead of `opt` to limit the changes to
-- just that buffer. (As an alternative to using an autocmd, you can also put those
-- configurations into a file `/after/ftplugin/{filetype}.lua` in your
-- nvim-directory.)
vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = "python", -- filetype for which to run the autocmd
        callback = function()
            -- use pep8 standards
            vim.opt_local.expandtab = true
            vim.opt_local.shiftwidth = 4
            vim.opt_local.tabstop = 4
            vim.opt_local.softtabstop = 4

            -- folds based on indentation https://neovim.io/doc/user/fold.html#fold-indent
            -- if you are a heavy user of folds, consider using `nvim-ufo`
            vim.opt_local.foldmethod = "indent"

            local iabbrev = function(lhs, rhs)
                vim.keymap.set("ia", lhs, rhs, {buffer = true})
            end
            -- automatically capitalize boolean values. Useful if you come from a
            -- different language, and lowercase them out of habit.
            iabbrev("true", "True")
            iabbrev("false", "False")

            -- in the same way, we can fix habits regarding comments or None
            iabbrev("--", "#")
            iabbrev("null", "None")
            iabbrev("none", "None")
            iabbrev("nil", "None")
        end
    }
)

-- Additional configurations
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.api.nvim_set_option("clipboard", "unnamed")

-- Python-specific configurations
--vim.cmd [[
--autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 colorcolumn=88
--]]
