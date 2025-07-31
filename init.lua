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
    " map <left> <ESC>:NERDTreeToggle<RETURN>
    map <up> <ESC>:bp<RETURN>
    " }
    " paste toggle from http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
    " this is probably no longer needed in nvim
    " set pastetoggle=<F2>

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

"    " Folding {
"    set foldenable " Turn on folding
"    set foldmarker={,} " Fold C style code (only use this as default
"    " if you use a high foldlevel)
"    set foldmethod=marker " Fold on the marker
"
"    function! JavaScriptFold() "{
"    setl foldmethod=syntax
"    setl foldlevelstart=1
"    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
"
"    function! FoldText()"}
"    return substitute(getline(v:foldstart), '{.*', '{...}', '')
"    endfunction
"    setl foldtext=FoldText()
"    endfunction
"    "From http://vim.wikia.com/wiki/Folding
"    "In normal mode, press Space to toggle the current fold open/closed.
"    "However, if the cursor is not in a fold, move to the right
"    "(the default behavior).
"    nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
"    vnoremap <Space> zf
"    "}
"    " }

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

-- Define python_format function for REPL formatting
_G.python_format = function(text)
    -- Clean up REPL interactions to handle indentation
    if string.find(text, "^\n*%s*$") then
        return "\n"
    end
    text = string.gsub(text, "\n%s*$", "")

    if vim.bo.filetype == "python" then
        -- Indent after certain patterns for Python
        local should_indent = string.find(text, "[%({[]%s*$") or
            string.find(text, "%:$") or
            string.find(text, "%:%s*#.*$")
        if should_indent then
            return text .. "\n"
        end
    end
    return text
end

-- Lazy.nvim configuration
require("lazy").setup(
    {
        -- General plugins
        {
            "nvim-lua/plenary.nvim",
            "tpope/vim-fugitive",
            "tpope/vim-sleuth",
            "nvim-tree/nvim-tree.lua",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            opts = {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            },
            keys = {
                {
                    "<leader>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "Buffer Local Keymaps (which-key)",
                },
                ask = {
                    floating = false, -- Open the 'AvanteAsk' prompt in a floating window
                    start_insert = true, -- Start insert mode when opening the ask window
                    border = "rounded",
                    height = 30, -- Enlarged height
                },
            },
        },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			{ "williamboman/mason.nvim",           opts = true },
			{ "williamboman/mason-lspconfig.nvim", opts = true }
		},
		opts = {
			ensure_installed = {
				-- Python
				"pyright", -- LSP for python
				"ruff",    -- linter for python (includes flake8, pep8, etc.)
				"debugpy", -- debugger
				"black",   -- formatter
				"isort",   -- organize imports
				"taplo",   -- LSP for toml (for pyproject.toml files)

				-- TypeScript/React
				"typescript-language-server", -- LSP for TypeScript/JavaScript
				"eslint-lsp",                 -- ESLint Language Server
				"prettier",                   -- Formatter for JS/TS/JSX/TSX
				"css-lsp",                    -- CSS Language Server
				"html-lsp",                   -- HTML Language Server
				"stylelint-lsp",              -- Stylelint Language Server
				"tailwindcss-language-server" -- TailwindCSS Language Server (if using tailwind)
			}
		}
	},
	{
		"Mofiqul/adwaita.nvim",
		lazy = false,
		priority = 1000,
		-- configure and set on startup
		config = function()
			vim.g.adwaita_darker = false            -- for darker version
			vim.g.adwaita_disable_cursorline = true -- to disable cursorline
			vim.g.adwaita_transparent = true        -- makes the background transparent
			vim.cmd("colorscheme adwaita")
		end
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup {
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
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
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_y = { "progress" },
					lualine_z = { "location" }
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
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
	{ "preservim/nerdcommenter", },
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end
	},
	{ "lambdalisue/suda.vim" },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{ "Darazaki/indent-o-matic" },
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
        { "Raimondi/delimitMate" },
        {
            "nvim-telescope/telescope.nvim",
            dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
            keys = {
                { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Telescope Find Files" },
                { "<leader>fg", "<cmd>Telescope live_grep<CR>",  desc = "Telescope Live Grep" },
                { "<leader>fb", "<cmd>Telescope buffers<CR>",    desc = "Telescope Buffers" },
                { "<leader>fh", "<cmd>Telescope help_tags<CR>",  desc = "Telescope Help Tags" },
                { "<leader>ss", "<cmd>Telescope aerial<CR>",     desc = "Goto Symbol (Aerial)" },
                {
                    "<leader>fw",
                    function()
                        require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") })
                    end,
                    desc = "Search Current Word"
                },
            },
            config = function()
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")

                require("telescope").setup({
                    defaults = {
                        -- General Telescope settings
                        prompt_prefix = "🔍 ",
                        selection_caret = "➤ ",
                        layout_strategy = "horizontal",
                        layout_config = {
                            horizontal = {
                                preview_width = 0.5, -- Adjust preview window size
                            },
                        },
                        mappings = {
                            i = {
                                -- Custom action for Enter key: create new file if no selection
                                ["<CR>"] = function(prompt_bufnr)
                                    local selection = action_state.get_selected_entry()
                                    if selection == nil then
                                        local entry = action_state.get_current_line()
                                        actions.close(prompt_bufnr)
                                        vim.cmd("edit " .. entry)            -- Open new file
                                    else
                                        actions.select_default(prompt_bufnr) -- Open existing file
                                    end
                                    vim.cmd("normal! gg")                    -- Move cursor to top
                                end,
                                ["<C-u>"] = actions.preview_scrolling_up,
                                ["<C-d>"] = actions.preview_scrolling_down,
                            },
                            n = {
                                ["<CR>"] = actions.select_default,
                                ["q"] = actions.close,
                            },
                        },
                    },
                    pickers = {
                        find_files = {
                            hidden = true,                                                       -- Show dotfiles
                            no_ignore = true,                                                    -- Ignore .gitignore
                            find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" }, -- Use ripgrep
                        },
                        live_grep = {
                            additional_args = function()
                                return { "--hidden", "--glob", "!.git/*" } -- Grep hidden files, exclude .git
                            end,
                        },
                        buffers = {
                            sort_lastused = true,         -- Show recently used buffers first
                            ignore_current_buffer = true, -- Skip current buffer in list
                        },
                    },
                })
            end,
        },
        {
            "debugloop/telescope-undo.nvim",
            dependencies = { "nvim-telescope/telescope.nvim" },
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
                {
                    "<leader>p",
                    function()
                        require("telescope").extensions.yank_history.yank_history({})
                    end,
                    desc = "Open Yank History"
                },
                { "y",  "<Plug>(YankyYank)",                      mode = { "n", "x" },                           desc = "Yank text" },
                { "p",  "<Plug>(YankyPutAfter)",                  mode = { "n", "x" },                           desc = "Put yanked text after cursor" },
                { "P",  "<Plug>(YankyPutBefore)",                 mode = { "n", "x" },                           desc = "Put yanked text before cursor" },
                { "gp", "<Plug>(YankyGPutAfter)",                 mode = { "n", "x" },                           desc = "Put yanked text after selection" },
                { "gP", "<Plug>(YankyGPutBefore)",                mode = { "n", "x" },                           desc = "Put yanked text before selection" },
                { "[y", "<Plug>(YankyCycleForward)",              desc = "Cycle forward through yank history" },
                { "]y", "<Plug>(YankyCycleBackward)",             desc = "Cycle backward through yank history" },
                { "]p", "<Plug>(YankyPutIndentAfterLinewise)",    desc = "Put indented after cursor (linewise)" },
                { "[p", "<Plug>(YankyPutIndentBeforeLinewise)",   desc = "Put indented before cursor (linewise)" },
                { "]P", "<Plug>(YankyPutIndentAfterLinewise)",    desc = "Put indented after cursor (linewise)" },
                { "[P", "<Plug>(YankyPutIndentBeforeLinewise)",   desc = "Put indented before cursor (linewise)" },
                { ">p", "<Plug>(YankyPutIndentAfterShiftRight)",  desc = "Put and indent right" },
                { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)",   desc = "Put and indent left" },
                { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
                { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)",  desc = "Put before and indent left" },
                { "=p", "<Plug>(YankyPutAfterFilter)",            desc = "Put after applying a filter" },
                { "=P", "<Plug>(YankyPutBeforeFilter)",           desc = "Put before applying a filter" }
            }
        },
        {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            event = "InsertEnter",
            config = function()
                require("copilot").setup({
                    panel = {
                        enabled = false,
                        auto_refresh = false,
                        keymap = {
                            jump_prev = "[[",
                            jump_next = "]]",
                            accept = "<CR>",
                            refresh = "gr",
                            open = "<M-CR>"
                        },
                        layout = {
                            position = "bottom", -- | top | left | right | horizontal | vertical
                            ratio = 0.4
                        },
                    },
                    suggestion = {
                        enabled = false,
                        auto_trigger = false,
                        hide_during_completion = true,
                        debounce = 75,
                        keymap = {
                            accept = "<M-l>",
                            accept_word = false,
                            accept_line = false,
                            next = "<M-]>",
                            prev = "<M-[>",
                            dismiss = "<C-]>",
                        },
                    },
                    filetypes = {
                        yaml = false,
                        markdown = false,
                        help = false,
                        gitcommit = false,
                        gitrebase = false,
                        hgcommit = false,
                        svn = false,
                        cvs = false,
                        ["."] = false,
                    },
                    copilot_node_command = 'node', -- Node.js version must be > 18.x
                    server_opts_overrides = {},
                })
            end,
        },
        {
            "stevearc/aerial.nvim",
            opts = function()
                --local icons = vim.deepcopy(LazyVim.config.icons.kinds)

                -- HACK: fix lua's weird choice for `Package` for control
                -- structures like if/else/for/etc.
                --icons.lua = { Package = icons.Control }

                ---@type table<string, string[]>|false
                local filter_kind = false
                --if LazyVim.config.kind_filter then
                --filter_kind = assert(vim.deepcopy(LazyVim.config.kind_filter))
                --filter_kind._ = filter_kind.default
                --filter_kind.default = nil
                --end

                local opts = {
                    attach_mode = "global",
                    backends = { "lsp", "treesitter", "markdown", "man" },
                    show_guides = true,
                    layout = {
                        resize_to_content = false,
                        win_opts = {
                            winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
                            signcolumn = "yes",
                            statuscolumn = " ",
                        },
                    },
                    icons = icons,
                    filter_kind = filter_kind,
                    -- stylua: ignore
                    guides = {
                        mid_item   = "├╴",
                        last_item  = "└╴",
                        nested_top = "│ ",
                        whitespace = "  ",
                    },
                }
                return opts
            end,
            keys = {
                { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
            },
            lazy = true,                             -- Ensure the plugin is loaded lazily
            event = { "BufReadPost", "BufNewFile" }, -- Optional: you can load it on file events or keep it key-based only
        },
        -- Python-specific plugins
        {
            "neovim/nvim-lspconfig",
            config = function()
                -- Define standard capabilities for LSP
                local capabilities = vim.lsp.protocol.make_client_capabilities()
                capabilities = vim.tbl_deep_extend("force", capabilities, {
                    textDocument = {
                        completion = {
                            completionItem = {
                                snippetSupport = true,
                                preselectSupport = true,
                                insertReplaceSupport = true,
                                labelDetailsSupport = true,
                                deprecatedSupport = true,
                                commitCharactersSupport = true,
                                tagSupport = { valueSet = { 1 } },
                                resolveSupport = {
                                    properties = {
                                        "documentation",
                                        "detail",
                                        "additionalTextEdits",
                                    }
                                }
                            }
                        }
                    }
                })

                -- Python LSP setup
                require("lspconfig").pyright.setup {
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "basic"
                            }
                        }
                    },
                    capabilities = capabilities,
                }

                -- TypeScript/React LSP setup (using typescript-language-server)
                -- Note: tsserver is deprecated, we use typescript-language-server via Mason
                require("lspconfig").ts_ls.setup({
                    cmd = { vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server", "--stdio" },
                    settings = {
                        typescript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            }
                        },
                        javascript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            }
                        }
                    },
                    capabilities = capabilities,
                })

                -- ESLint LSP setup
                require("lspconfig").eslint.setup({
                    -- If you want ESLint to automatically fix issues on save
                    on_attach = function(client, bufnr)
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            command = "EslintFixAll",
                        })
                    end,
                    cmd = { vim.fn.stdpath("data") .. "/mason/bin/vscode-eslint-language-server", "--stdio" },
                    capabilities = capabilities,
                })

                -- CSS LSP setup
                require("lspconfig").cssls.setup({
                    cmd = { vim.fn.stdpath("data") .. "/mason/bin/vscode-css-language-server", "--stdio" },
                    capabilities = capabilities,
                })

                -- HTML LSP setup
                require("lspconfig").html.setup({
                    cmd = { vim.fn.stdpath("data") .. "/mason/bin/vscode-html-language-server", "--stdio" },
                    capabilities = capabilities,
                })

                -- Tailwind CSS LSP setup
                require("lspconfig").tailwindcss.setup({
                    cmd = { vim.fn.stdpath("data") .. "/mason/bin/tailwindcss-language-server", "--stdio" },
                    capabilities = capabilities,
                })
            end
        },
        {
            "folke/neodev.nvim",
            opts = {
                library = {
                    plugins = { "nvim-dap-ui" },
                    types = true,
                },
                setup_jsonls = true,
                lspconfig = true,
            }
        },
        {
            "saghen/blink.cmp",
            --dependencies = { 'rafamadriz/friendly-snippets' },
            dependencies = {
                -- Keep friendly-snippets as you had it before
                "rafamadriz/friendly-snippets",
                'Kaiser-Yang/blink-cmp-avante',
                "fang2hou/blink-copilot",
                -- Add blink.compat for compatibility with some nvim-cmp sources
                {
                    "saghen/blink.compat",
                    opts = {},
                    version = "*",
                },
                -- Keep vsnip for snippet support
                "hrsh7th/vim-vsnip",
            },
            build = function()
                if vim.fn.executable("cargo") == 1 then
                    return "cargo build --release"
                end
            end,
            -- use a release tag to download pre-built binaries
            version = "*", -- blink.cmp requires a release tag for its rust binary
            opts = {
                -- 'default' for mappings similar to built-in vim completion
                -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
                -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
                --
                -- All presets have the following mappings:
                -- C-space: Open menu or open docs if already open
                -- C-n/C-p or Up/Down: Select next/previous item
                -- C-e: Hide menu
                -- C-k: Toggle signature help (if signature.enabled = true)
                keymap = { preset = "super-tab" },
                signature = { enabled = true },
                --fuzzy = { implementation = "prefer_rust_with_warning" },
                completion = {
                    documentation = { auto_show = true },
                    keyword = { range = 'full' },
                    menu = {
                        -- Don't automatically show the completion menu
                        auto_show = true,

                        -- nvim-cmp style menu
                        draw = {
                            columns = {
                                { "label",     "label_description", gap = 1 },
                                { "kind_icon", "kind" }
                            },
                        }
                    },
                },
                ---- Sources configuration
                sources = {
                    -- Default providers
                    default = {
                        "buffer",
                        "path",
                        "lsp",
                        --"vsnip",
                        "copilot",
                        "avante",
                    },
                    per_filetype = {
                        codecompanion = { "codecompanion" },
                    },
                    providers = {
                        avante = {
                            module = 'blink-cmp-avante',
                            name = 'Avante',
                            opts = {
                                -- options for blink-cmp-avante
                            },
                        },
                        copilot = {
                            name = "copilot",
                            module = "blink-copilot",
                            score_offset = 100,
                            async = true,
                        },
                    },
                },
            },
        },
        { "rafamadriz/friendly-snippets" },
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
            event = "bufwritepre", -- load the plugin before saving
            keys = {
                {
                    "<leader>c",
                    function()
                        require("conform").format({ lsp_fallback = true })
                    end,
                    desc = "format"
                }
            },
            opts = {
                formatters_by_ft = {
                    -- Python formatters
                    python = { "isort", "black" },

                    -- TypeScript/React formatters
                    typescript = { "prettier" },
                    javascript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    css = { "prettier" },
                    html = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier", "inject" },

                    -- "inject" is a special formatter from conform.nvim, which
                    -- formats treesitter-injected code. basically, this makes
                    -- conform.nvim format python codeblocks inside a markdown file.
                },
                -- enable format-on-save
                format_on_save = {
                    -- when no formatter is setup for a filetype, fallback to formatting
                    -- via the lsp. this is relevant e.g. for taplo (toml lsp), where the
                    -- lsp can handle the formatting for us
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
                { "<leader>i", vim.cmd.IronRepl, desc = "󱠤 Toggle REPL" },
                { "<leader>I", vim.cmd.IronRestart, desc = "󱠤 Restart REPL" },
                -- these keymaps need no right-hand-side, since that is defined by the
                -- plugin config further below
                { "+", mode = { "n", "x" }, desc = "󱠤 Send-to-REPL Operator" },
                { "++", desc = "󱠤 Send Line to REPL" }
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
                -- this defined how the repl is opened. Here we set the REPL window
                -- to open in a horizontal split to a bottom, with a height of 10
                -- cells.
                repl_open_cmd = "vertical botright 80 vsplit",
                -- This defines which binary to use for the REPL. If `ipython` is
                -- available, it will use `ipython`, otherwise it will use `python3`.
                -- since the python repl does not play well with indents, it's
                -- preferable to use `ipython` or `bypython` here.
                -- (see: https://github.com/Vigemus/iron.nvim/issues/348)
                repl_definition = {
                    python = {
                        command = function()
                            local ipythonAvailable = vim.fn.executable("ipython") == 1
                            if ipythonAvailable then
                                return { "ipython", "--no-autoindent" }
                            else
                                return { "python3" }
                            end
                        end,
                        format = python_format
                    }
                },
                -- If the highlight is on, you can change how it looks
                -- For the available options, check nvim_set_hl
                highlight = {
                    italic = true
                },
                ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
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
                highlight = { enable = true }, -- enable treesitter syntax highlighting
                indent = { enable = true },
                ensure_installed = {
                    -- auto-install the Treesitter parser for python and related languages
                    "python",
                    "toml",
                    "rst",
                    "ninja",
                    "lua",

                    -- JavaScript/TypeScript/React
                    "javascript",
                    "typescript",
                    "tsx",
                    "css",
                    "html",
                    "json",

                    -- needed for formatting code-blockcs inside markdown via conform.nvim
                    "markdown",
                    "markdown_inline",
                    "yaml",
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
        { "Vimjas/vim-python-pep8-indent" },
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
                { "stevearc/overseer.nvim", config = true },
                "rcarriga/nvim-dap-ui",
                -- virtual text for the debugger
                {
                    "theHamsta/nvim-dap-virtual-text",
                    opts = {},
                },
            },
            keys = {
                {
                    "<leader>ds",
                    function()
                        local widgets = require("dap.ui.widgets")
                        widgets.centered_float(widgets.scopes, { border = "rounded" })
                    end,
                    desc = "DAP Scopes"
                },
                { "<F2>", function()
                    require("dap.ui.widgets").hover(nil, { border = "rounded" })
                end },
                { "<F4>",       "<CMD>DapDisconnect<CR>",             desc = "DAP Disconnect" },
                { "<leader>dt", "<CMD>DapTerminate<CR>",              desc = "DAP Terminate" },
                { "<leader>dc", "<CMD>DapContinue<CR>",               desc = "DAP Continue" },
                { "<leader>dj", function() require("dap").down() end, desc = "Down" },
                { "<leader>dk", function() require("dap").up() end,   desc = "Up" },
                {
                    "<leader>dl",
                    function()
                        require("dap").run_last()
                    end,
                    desc = "Run Last"
                },
                {
                    "<leader>dC",
                    function()
                        require("dap").run_to_cursor()
                    end,
                    desc = "Run to Cursor"
                },
                { "<leader>db", "<CMD>DapToggleBreakpoint<CR>",              desc = "Toggle Breakpoint" },
                {
                    "<leader>dB",
                    function()
                        vim.ui.input(
                            { prompt = "Breakpoint condition: " },
                            function(input)
                                require("dap").set_breakpoint(input)
                            end
                        )
                    end,
                    desc = "Conditional Breakpoint"
                },
                { "<leader>dO", "<CMD>DapStepOver<CR>",                      desc = "Step Over" },
                {"<leader>di", "<CMD>DapStepInto<CR>", desc = "Step Into"},
                { "<leader>do", function() require("dap").step_out() end,    desc = "Step Out" },
                { "<leader>dO", function() require("dap").step_over() end,   desc = "Step Over" },
                { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
                { "<leader>drst", function() require("dap").restart() end, desc = "DAP Restart" },
                { "<leader>dlp", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "DAP Log Point" },
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
                    sign(group, { text = "●", texthl = group })
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
            dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
            opts = {
                icons = {
                    expanded = "󰅀",
                    collapsed = "󰅂",
                    current_frame = "󰅂"
                },
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks", size = 0.25 },
                            { id = "watches", size = 0.25 },
                        },
                        size = 40,
                        position = "right",
                    },
                    {
                        elements = {
                            { id = "repl", size = 0.5 },
                            { id = "console", size = 0.5 },
                        },
                        size = 12,
                        position = "bottom",
                    },
                },
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
                {
                    "<leader>du",
                    function()
                        require("dapui").toggle({})
                    end,
                    desc = "Dap UI"
                },
                {
                    "<leader>de",
                    function()
                        require("dapui").eval()
                    end,
                    desc = "Eval",
                    mode = { "n", "v" }
                },
                {
                    "<leader>Dc",
                    function()
                        require("dapui").close({})
                        require("dap").disconnect() -- Close the DAP terminal
                    end,
                    desc = "Close DAP UI and Terminal"
                }
            },
            config = function(_, opts)
                local dap = require("dap")
                local dapui = require("dapui")
                dapui.setup(opts)
                -- dap.listeners.after.event_initialized["dapui_config"] = function()
                --     dapui.open({})
                -- end
                --dap.listeners.before.event_terminated["dapui_config"] = function()
                --dapui.close({})
                --end
                --dap.listeners.before.event_exited["dapui_config"] = function()
                --dapui.close({})
                --end
                -- require("dapui").setup(opts) -- This is redundant
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
        -- {
        --     "linux-cultist/venv-selector.nvim",
        --     dependencies = {
        --         "neovim/nvim-lspconfig",
        --         "mfussenegger/nvim-dap",
        --         "mfussenegger/nvim-dap-python", --optional
        --         { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } }
        --     },
        --     lazy = false,
        --     branch = "regexp", -- This is the regexp branch, use this for the new version
        --     config = function()
        --         require("venv-selector").setup({})
        --     end,
        --     keys = {
        --         { ",v", "<cmd>VenvSelect<cr>" }
        --     },
        --     opts = {
        --         dap_enabled = true -- makes the debugger work with venv
        --     }
        -- },
        -- additional python text objects
        -- https://github.com/chrisgrieser/nvim-various-textobjs?
        {
            "chrisgrieser/nvim-various-textobjs",
            event = "UIEnter",
            opts = { useDefaults = true },
            --opts = { keymaps.useDefaults = true },
        },
        --  Markdown
        {
            "iamcco/markdown-preview.nvim",
            --build = function() vim.fn["mkdp#util#install"]() end,
            ft = "markdown",
            keys = { { "<A-o>", "<CMD>MarkdownPreviewToggle<CR>", desc = "Toggle Markdown Preview" } }
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
        },
        -- AI
        {
            "ravitemer/mcphub.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
            },
            -- Use the bundled build script instead of a global npm install
            build = "bundled_build.lua",
            config = function()
                require("mcphub").setup({
                    -- Tell mcphub to use the executable installed by the bundled_build.lua script
                    use_bundled_binary = true,
                    auto_approve = true,
                    auto_toggle_mcp_servers = true,
                    extensions = {
                        avante = {
                            make_slash_commands = true,
                        },
                    },
                })
            end,
        },
        {
            "yetone/avante.nvim",
            event = "VeryLazy",
            build = "make",
            opts = {
                provider = "copilot",
                auto_suggestions_provider = "copilot",
                selector = {
                    provider = "telescope",
                },
                providers = {
                    deepseek = {
                        __inherited_from = "openai",
                        api_key_name = "DEEPSEEK_API_KEY",
                        endpoint = "https://api.deepseek.com/",
                        model = "deepseek-coder",
                        mode = legacy,
                    },
                    copilot = {
                        model = "gpt-4o",
                        timeout = 30000,
                        --extra_request_body = {
                            --options = {
                                --temperature = 0,
                            --},
                        --},
                    },
                    ollama = {
                        endpoint = "http://127.0.0.1:11434",
                        timeout = 30000, -- Timeout in milliseconds
                        extra_request_body = {
                            options = {
                                temperature = 0.75,
                                num_ctx = 20480,
                                keep_alive = "5m",
                            },
                        },
                    },
                    --jetstream = {
                        --__inherited_from = "openai",
                        --api_key_name = "JETSTREAM_API_KEY",
                        --endpoint = "https://llm.jetstream-cloud.org/sglang/v1",
                        --model = "DeepSeek-R1",
                    --},
                    --openrouter = {
                    --__inherited_from = "openai",
                    --api_key_name = "OPENROUTER_API_KEY",
                    --endpoint = "https://openrouter.ai/api/v1",
                    --model = "google/gemini-2.5-pro-exp-03-25:free",
                    --},
                    --["gemini-2.5-pro-exp"] = {
                        --__inherited_from = "gemini",
                        --model = "gemini-2.5-pro-exp-03-25",
                        ----max_tokens = 128000,
                        ----display_name = "Gemini 2.5 Pro Exp"
                    --},
                    gemini = {
                        --__inherited_from = "gemini",
                        use_ReAct_prompt = true,
                        --model = "gemini-2.5-pro-exp-03-25",
                        --extra_request_body = {
                        --options = {
                        --temperature = 0,
                        --},
                    }
                },
                behaviour = {
                    auto_suggestions = false, -- Experimental stage
                    auto_set_highlight_group = true,
                    auto_set_keymaps = true,
                    auto_apply_diff_after_generation = false,
                    support_paste_from_clipboard = true,
                    minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
                    enable_claude_text_editor_tool_mode = true,
                },
                web_search_engine = {
                    provider = "google",
                },
                mappings = {
                    ask = "<leader>aa",
                    edit = "<leader>ae",
                    refresh = "<leader>ar",
                    --- @class AvanteConflictMappings
                    diff = {
                        ours = "co",
                        theirs = "ct",
                        none = "c0",
                        both = "cb",
                        next = "]x",
                        prev = "[x",
                    },
                    suggestion = {
                        accept = "<M-l>",
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                    jump = {
                        next = "]]",
                        prev = "[[",
                    },
                    submit = {
                        normal = "<CR>",
                        insert = "<C-s>",
                    },
                    toggle = {
                        debug = "<leader>ad",
                        hint = "<leader>ah",
                    },
                },
                hints = { enabled = true },
                windows = {
                    position = "right",
                    wrap = true,          -- similar to vim.o.wrap
                    width = 40,           -- default % based on available width
                    sidebar_header = {
                        align = "center", -- left, center, right for title
                        rounded = true,
                    },
                    input = {
                        prefix = "> ",
                        height = 12, -- Height of the input window in vertical layout
                    },
                },
                highlights = {
                    diff = {
                        current = "DiffText",
                        incoming = "DiffAdd",
                    },
                },
                diff = {
                    autojump = true,
                    list_opener = "copen",
                    --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
                    --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
                    --- Disable by setting to -1.
                    override_timeoutlen = 500,
                },
                system_prompt = function()
                    local hub = require("mcphub").get_hub_instance()
                    return hub:get_active_servers_prompt()
                end,
                -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
                custom_tools = function()
                    return {
                        require("mcphub.extensions.avante").mcp_tool(),
                    }
                end,
            },
            dependencies = {
                "ellisonleao/dotenv.nvim",     -- Make sure dotenv loads before avante
                "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
                "stevearc/dressing.nvim",
                "nvim-lua/plenary.nvim",
                "MunifTanjim/nui.nvim",
                "zbirenbaum/copilot.lua",        -- for providers='copilot'
                "ravitemer/mcphub.nvim",
                "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
                {
                    -- support for image pasting
                    "HakonHarnes/img-clip.nvim",
                    event = "VeryLazy",
                    opts = {
                        -- recommended settings
                        default = {
                            embed_image_as_base64 = true,
                            prompt_for_file_name = false,
                            drag_and_drop = {
                                insert_mode = true,
                            },
                            -- required for Windows users
                            use_absolute_path = true,
                        },
                    },
                    keys = {
                        -- custom keymap to avoid conflict with yanky
                        { "<leader>ip", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
                    },
                },
                --- The below is optional, make sure to setup it properly if you have lazy=true
                {
                    'MeanderingProgrammer/render-markdown.nvim',
                    opts = {
                        file_types = { "markdown", "Avante", "codecompanion"},
                    },
                    ft = { "markdown", "Avante" },
                },
            },
        },
        {
            "olimorris/codecompanion.nvim",
            opts = {},
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-treesitter/nvim-treesitter",
                "ravitemer/mcphub.nvim",
            },
            config = function()
                require("codecompanion").setup({
                    extensions = {
                        mcphub = {
                            callback = "mcphub.extensions.codecompanion",
                            opts = {
                                make_vars = true,
                                make_slash_commands = true,
                                show_result_in_chat = true
                            }
                        }
                    },
                    adapters = {
                        deepseek = function()
                            return require("codecompanion.adapters").extend("deepseek", {
                                env = {
                                    api_key = function()
                                        return os.getenv("DEEPSEEK_API_KEY")
                                    end,
                                },
                            })
                        end,
                    },
                    strategies = {
                        chat = { adapter = "deepseek", },
                        inline = { adapter = "deepseek" },
                        agent = { adapter = "deepseek" },
                    },
                })
            end
        },
        {
            "echasnovski/mini.diff",
            config = function()
                local diff = require("mini.diff")
                diff.setup({
                    -- Disabled by default
                    source = diff.gen_source.none(),
                })
            end,
        },
        {
            "HakonHarnes/img-clip.nvim",
            opts = {
                filetypes = {
                    codecompanion = {
                        prompt_for_file_name = false,
                        template = "[Image]($FILE_PATH)",
                        use_absolute_path = true,
                    },
                },
            },
        },
        --NOTEBOOK SUPPORT
        {
            "benlubas/molten-nvim",
            version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
            build = ":UpdateRemotePlugins",
            init = function()
                -- this is an example, not a default. Please see the readme for more configuration options
                vim.g.molten_output_win_max_height = 12
            end,
        },
        {
            "GCBallesteros/jupytext.nvim",
            config = true,
            -- Depending on your nvim distro or config you may need to make the loading not lazy
            -- lazy=false,
        },
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

            -- Use treesitter for folding, which is more reliable with syntax highlighting
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"

            local iabbrev = function(lhs, rhs)
                vim.keymap.set("ia", lhs, rhs, { buffer = true })
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
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true, silent = true })
vim.keymap.set('n', '<Right>', ':AerialToggle!<CR>', { noremap = true, silent = true })

-- Set up filetype-specific configurations
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact", "css", "html" },
    callback = function()
        -- Use 2 spaces for indentation for web-related files
        vim.opt_local.expandtab = true
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
    end
})

-- LSP specific keybindings
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- Ensure Treesitter highlighting is enabled for the buffer, which can sometimes
        -- fail to apply automatically when jumping between files.
        if pcall(require, "nvim-treesitter.highlight") then
            vim.cmd("TSBufEnable highlight")
        end

        -- Code navigation
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Go to References" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to Implementation" })
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to Type Definition" })

        -- Documentation
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show Documentation" })

        -- Code actions
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })

        -- Diagnostics
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Previous Diagnostic" })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next Diagnostic" })
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show Diagnostics" })
    end,
})

-- Python-specific configurations
--vim.cmd [[
--autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 colorcolumn=88
--]]
-- nvim-jupyter-client

-- configuration for Windows Subsystem for Linux (WSL)
local in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil

if in_wsl then
    vim.g.clipboard = {
        name = 'wsl clipboard',
        copy = { ["+"] = { "clip.exe" }, ["*"] = { "clip.exe" } },
        paste = { ["+"] = { "nvim_paste" }, ["*"] = { "nvim_paste" } },
        cache_enabled = true
    }
end
