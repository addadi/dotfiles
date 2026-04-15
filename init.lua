vim.g.mapleader = ','

vim.opt.clipboard:append("unnamed")
vim.opt.cpoptions = "aABceFsmq"
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fileformats = "unix,dos,mac"
vim.opt.formatoptions = "rq"
vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.iskeyword:append("_,$,@,%,#")
vim.opt.list = true
vim.opt.listchars = "tab:>-,trail:-"
vim.opt.hlsearch = false
vim.opt.startofline = false
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.shortmess = "aOstT"
vim.opt.showmatch = true
vim.opt.sidescrolloff = 10
vim.opt.softtabstop = 4
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.wildignore = "*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png"
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"
vim.opt.wrap = false
vim.opt.whichwrap = "b,s,h,l,<,>,~,[,]"

vim.keymap.set("", "<F12>", "ggVGg?")
vim.keymap.set("", "<down>", ":bn<CR>")
vim.keymap.set("", "<up>", ":bp<CR>")
vim.keymap.set("", "<leader>bb", ":b#<CR>")
vim.keymap.set("v", "*", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]])
vim.keymap.set("v", "#", [[y?\V<C-R>=escape(@",'/\')<CR><CR>]])
vim.keymap.set("n", "<leader>g", ":vimgrep // **/*.<left><left><left><left><left><left><left>")
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
            -- TODO: review replacing oil.nvim with snacks.explorer
            {
                "stevearc/oil.nvim",
                dependencies = { "nvim-tree/nvim-web-devicons" },
                opts = {
                    default_file_explorer = true,
                    view_options = { show_hidden = true },
                },
                keys = {
                    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
                },
            },
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            opts = {
                preset = "modern",
            },
            keys = {
                {
                    "<leader>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "Buffer Local Keymaps (which-key)",
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
			"sainnhe/everforest",
			lazy = false,
			priority = 1000,
			-- configure and set on startup
			config = function()
				vim.g.everforest_background = "soft"  -- options: hard, medium, or soft
				vim.g.everforest_transparent_background = 1 -- makes the background transparent
				vim.g.everforest_ui_contrast = true    -- better UI contrast for Statusline
				vim.g.everforest_better_performance = 1
				vim.cmd("colorscheme everforest")
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
					globalstatus = true,
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
	{ "folke/ts-comments.nvim", opts = {} },
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end
	},
	{ "lambdalisue/vim-suda" },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
        { "echasnovski/mini.pairs", event = "VeryLazy", opts = {} },
        -- Buffer management - fixes :bd behavior in splits
        {
            "echasnovski/mini.bufremove",
            opts = {},
            keys = {
                {
                    "<leader>bd",
                    function()
                        local bd = require("mini.bufremove").delete
                        if vim.bo.modified then
                            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
                            if choice == 1 then -- Yes
                                vim.cmd.write()
                                bd(0)
                            elseif choice == 2 then -- No
                                bd(0, true)
                            end
                        else
                            bd(0)
                        end
                    end,
                    desc = "Delete Buffer"
                },
                {
                    "<leader>bD",
                    function()
                        require("mini.bufremove").delete(0, true)
                    end,
                    desc = "Delete Buffer (Force)"
                },
            },
        },
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
            opts = {
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
                filter_kind = false,
                guides = {
                    mid_item   = "├╴",
                    last_item  = "└╴",
                    nested_top = "│ ",
                    whitespace = "  ",
                },
            },
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
                local capabilities = require('blink.cmp').get_lsp_capabilities()

                -- Python LSP setup
                vim.lsp.config('pyright', {
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "basic"
                            }
                        }
                    },
                    capabilities = capabilities,
                })
                vim.lsp.enable('pyright')

                -- TypeScript/React LSP setup (using typescript-language-server)
                -- Note: tsserver is deprecated, we use typescript-language-server via Mason
                vim.lsp.config('ts_ls', {
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
                vim.lsp.enable('ts_ls')

                -- ESLint LSP setup
                vim.lsp.config('eslint', {
                    on_attach = function(client, bufnr)
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            command = "EslintFixAll",
                        })
                    end,
                    capabilities = capabilities,
                })
                vim.lsp.enable('eslint')

                -- CSS LSP setup
                vim.lsp.config('cssls', {
                    capabilities = capabilities,
                })
                vim.lsp.enable('cssls')

                -- HTML LSP setup
                vim.lsp.enable('html', {
                    capabilities = capabilities,
                })
                vim.lsp.enable('html')

                -- Tailwind CSS LSP setup
                vim.lsp.config('tailwindcss', {
                    capabilities = capabilities,
                })
                vim.lsp.enable('tailwindcss')
            end
        },
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
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
            version = "1.*",
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
        {
            "folke/trouble.nvim",
            opts = {},
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
                        require("conform").format({ lsp_format = "fallback" })
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
                    lsp_format = true
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
            branch = "main",
            lazy = false,
            build = ":TSUpdate",
            config = function()
                local langs = {
                    "python", "toml", "rst", "ninja", "lua",
                    "javascript", "typescript", "tsx", "css", "html", "json",
                    "markdown", "markdown_inline", "yaml",
                }
                require("nvim-treesitter").install(langs)
                vim.api.nvim_create_autocmd("FileType", {
                    callback = function()
                        pcall(vim.treesitter.start)
                    end,
                })
            end,
        },
        -----------------------------------------------------------------------------
        -- EDITING SUPPORT PLUGINS
        -- some plugins that help with python-specific editing operations

        -- Docstring creation
        -- - quickly create docstrings via `<leader>a`
        {
            "danymat/neogen",
            opts = {
                languages = {
                    python = { template = { annotation_convention = "google_docstrings" } },
                },
            },
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
                    opts = {
                        virt_text_pos = "inline",
                    },
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
                require("dap-python").setup("debugpy-adapter")
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
		 "mfussenegger/nvim-dap",
		 "mfussenegger/nvim-dap-python", --optional
		 { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } }
	     },
	     ft = "python", -- Load when opening Python files
	     keys = {
		 { ",v", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
	     },
	     opts = {
		 options = {
		     dap_enabled = true,
		 },
	     },
	 },
        -- additional python text objects
        -- https://github.com/chrisgrieser/nvim-various-textobjs?
        {
            "chrisgrieser/nvim-various-textobjs",
            event = "UIEnter",
            opts = { keymaps = { useDefaults = true } },
        },
        --  Markdown
        {
            "iamcco/markdown-preview.nvim",
            build = function() vim.fn["mkdp#util#install"]() end,
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
            config = function()
                local openrouter = function(model)
                    return {
                        __inherited_from = "openai",
                        endpoint = "https://openrouter.ai/api/v1",
                        api_key_name = "OPENROUTER_API_KEY",
                        model = model,
                    }
                end
                require("avante").setup({
                provider = "copilot",
                auto_suggestions_provider = "copilot",
                mode = "agentic",
                selector = {
                    provider = "telescope",
                },
                providers = {
                    gemini = {
                        endpoint = "https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent",
                        api_key_name = "GEMINI_API_KEY",
                        use_ReAct_prompt = true,
                        models = {
                            { id = "gemini-2.5-flash", display_name = "Gemini Flash 2.5", max_tokens = 8192 },
                            { id = "gemini-2.5-pro", display_name = "Gemini 2.5 Pro", max_tokens = 128000 },
                        },
                    },
                    deepseek = {
                        __inherited_from = "openai",
                        api_key_name = "DEEPSEEK_API_KEY",
                        endpoint = "https://api.deepseek.com/",
                        model = "deepseek-coder",
                    },
                    copilot = {
                        model = "gpt-4o",
                        timeout = 30000,
                    },
                    ollama = {
                        endpoint = "http://127.0.0.1:11434",
                        timeout = 30000,
                        extra_request_body = {
                            options = {
                                temperature = 0.75,
                                num_ctx = 20480,
                                keep_alive = "5m",
                            },
                        },
                    },
                    openai_gpt_oss_120b = openrouter("openai/gpt-oss-120b"),
                    openai_gpt_oss_20b_free = openrouter("openai/gpt-oss-20b:free"),
                    openai_gpt_oss_20b = openrouter("openai/gpt-oss-20b"),
                    mistralai_codestral_2508 = openrouter("mistralai/codestral-2508"),
                    qwen_qwen3_30b_a3b_instruct_2507 = openrouter("qwen/qwen3-30b-a3b-instruct-2507"),
                    z_ai_glm_4_5 = openrouter("z-ai/glm-4.5"),
                    z_ai_glm_4_5_air_free = openrouter("z-ai/glm-4.5-air:free"),
                    z_ai_glm_4_5_air = openrouter("z-ai/glm-4.5-air"),
                    qwen_qwen3_235b_a22b_thinking_2507 = openrouter("qwen/qwen3-235b-a22b-thinking-2507"),
                    qwen_qwen3_coder_free = openrouter("qwen/qwen3-coder:free"),
                    qwen_qwen3_coder = openrouter("qwen/qwen3-coder"),
                    qwen_qwen3_235b_a22b_2507 = openrouter("qwen/qwen3-235b-a22b-2507"),
                    moonshotai_kimi_k2_free = openrouter("moonshotai/kimi-k2:free"),
                    moonshotai_kimi_k2 = openrouter("moonshotai/kimi-k2"),
                    thudm_glm_4_1v_9b_thinking = openrouter("thudm/glm-4.1v-9b-thinking"),
                    tencent_hunyuan_a13b_instruct_free = openrouter("tencent/hunyuan-a13b-instruct:free"),
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
                })
            end,
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
            "NickvanDyke/opencode.nvim",
            dependencies = {
                -- Recommended for `ask()` and `select()`.
                -- Required for default `toggle()` implementation.
                { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} }, keys = {
            { "<leader>u", function() Snacks.picker.undo() end, desc = "undo history" },
        } },
            },
            config = function()
                ---@type opencode.Opts
                vim.g.opencode_opts = {
                    -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
                }

                -- Required for `opts.auto_reload`.
                vim.o.autoread = true

                -- Recommended/example keymaps.
                vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
                vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
                vim.keymap.set({ "n", "x" },    "ga", function() require("opencode").prompt("@this") end,                   { desc = "Add to opencode" })
                vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })
                vim.keymap.set("n",        "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "opencode half page up" })
                vim.keymap.set("n",        "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "opencode half page down" })
                -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
                vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
                vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
            end,
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
                                make_vars = false,
                                make_slash_commands = true,
                                show_result_in_chat = true
                            }
                        }
                    },
                    adapters = {
                        http = {
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
                    },
                    interactions = {
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
            version = "^1.0.0",
            build = ":UpdateRemotePlugins",
            init = function()
                vim.g.molten_output_win_max_height = 12
            end,
        },
        {
            "GCBallesteros/jupytext.nvim",
            config = true,
        },
        -- TODO: evaluate pyrepl.nvim as molten-nvim replacement
        -- pyrepl.nvim is a newer, simpler Jupyter integration that uses
        -- jupyter-console directly. Worth testing if molten feels heavy.
        -- { "ADB-Geeks/pyrepl.nvim", opts = {} },
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
-- vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true }) -- [TEST] Disabling single <Esc> for terminal mode to test double <Esc> only
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true, silent = true })
vim.keymap.set('n', '<Right>', ':AerialToggle!<CR>', { noremap = true, silent = true })
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { noremap = true, silent = true })

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

-- Custom buffer delete command that preserves windows
local function smart_buffer_delete()
    local current_buf = vim.api.nvim_get_current_buf()
    local buffers_in_window = vim.fn.getbufinfo({buflisted = 1})

    -- Count buffers that are loaded and visible
    local loaded_buffers = {}
    for _, buf in ipairs(buffers_in_window) do
        if buf.loaded == 1 and buf.listed == 1 and buf.bufnr ~= current_buf then
            table.insert(loaded_buffers, buf.bufnr)
        end
    end

    -- If there are other buffers available, switch to one before deleting
    if #loaded_buffers > 0 then
        vim.cmd("buffer " .. loaded_buffers[1])
        vim.cmd("bdelete " .. current_buf)
    else
        -- If no other buffers, just use regular bdelete which might close window
        vim.cmd("bdelete")
    end
end

-- Create user command for smart buffer delete
vim.api.nvim_create_user_command("Bd", smart_buffer_delete, { desc = "Smart buffer delete that preserves windows" })

-- Override default :bd mapping to use smart delete
vim.keymap.set("n", "<leader>q", ":Bd<CR>", { noremap = true, silent = true, desc = "Smart Buffer Delete" })

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
