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
    set tabstop=8 " real tabs should be 8, and they will show with
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
    ""set foldlevel=100 " Don't autofold anything (but I can still
                      "" fold manually)
    "set foldopen=block,hor,mark,percent,quickfix,tag " what movements
                                                      "" open folds
    ""function SimpleFoldText() " {
        ""return getline(v:foldstart).' '
    ""endfunction " }
    ""set foldtext=SimpleFoldText() " Custom fold text function
                                   """ (cleaner than default)
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

" VAM {
  fun! SetupVAM()
      let c = get(g:, 'vim_addon_manager', { })
      let g:vim_addon_manager = c
      let c.plugin_root_dir = expand('$HOME') . '/.vim/vim-addons'
      let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
      if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
          execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
                      \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
      endif
      " git related
      call vam#ActivateAddons(["fugitive", "extradite"
                  \], {'auto_install' : 1})
      " files and buffers related
      call vam#ActivateAddons(["The_NERD_tree", "bufexplorer.zip", "ctrlp"
                  \], {'auto_install' : 1})
      " tabs completion related
      call vam#ActivateAddons(["neocomplete", "neosnippet",
                  \"vim-snippets"
                  \], {'auto_install' : 1})
      " comments related
      call vam#ActivateAddons(["The_NERD_Commenter"
                  \], {'auto_install' : 1})
      " project and session related
      "call vam#ActivateAddons(["TaskList", "vim-rooter", "session%3150"
                  "\], {'auto_install' : 1})
      "" required for session%3150
      "call vam#ActivateAddons(["vim-misc"
                  "\], {'auto_install' : 1})
      call vam#ActivateAddons(["TaskList", "vim-rooter"
                  \], {'auto_install' : 1})
      " REPL related
      call vam#ActivateAddons(["conque-repl", "Conque_Shell"
                  \], {'auto_install' : 1})
      " folding related
      "call vam#ActivateAddons(["FastFold"
                  "\], {'auto_install' : 1})
      " colorscheme and UI related
      call vam#ActivateAddons(["Colour_Sampler_Pack", "vim-airline",
                  \"github:vim-airline/vim-airline-themes"
                  \], {'auto_install' : 1})
      " syntax checking and code analysis
      call vam#ActivateAddons(["ALE_-_Asynchronous_Lint_Engine", "Tagbar", "AutoTag"
                  \], {'auto_install' : 1})
      "" html related
      "call vam#ActivateAddons(["github:tristen/vim-sparkup"
                  "\], {'auto_install' : 0})
      "" javascript related
      "call vam#ActivateAddons(["vim-javascript",
                  "\"github:marijnh/tern_for_vim"
                  "\], {'auto_install' : 0})
      "" json related
      "call vam#ActivateAddons(["github:elzr/vim-json"
                  "\], {'auto_install' : 0})
      " parsting
      call vam#ActivateAddons(["YankRing", "github:junegunn/vim-peekaboo"
                  \], {'auto_install' : 1})
      " code search - TO BE Checked!!!!
      call vam#ActivateAddons(["EasyGrep" ,"Smartgf"
                  \], {'auto_install' : 1})
      " complete delimaters and unimpaired - should learn more about it
      call vam#ActivateAddons(["delimitMate", "unimpaired"
                  \], {'auto_install' : 1})
      " the rest utils
      call vam#ActivateAddons([
                  \"surround", "Tabular", "Gundo",
                  \"repeat", "SudoEdit", "Indent_Guides"
                  \], {'auto_install' : 1})
  endfun
  call SetupVAM()
  let ft_addons = {
              \ '^\%(html\|htm\)$': [ 'github:tristen/vim-sparkup' ],
              \ 'javascript': [ 'github:marijnh/tern_for_vim', 'Cosco', 'vim-javascript', 'vim-jsbeautify', 'vim-jsdoc' ],
              \ 'json': [ 'github:elzr/vim-json' ],
              \ 'python': ['Python-mode-klen']
              \ }
  au FileType * for l in values(filter(copy(ft_addons), string(expand('<amatch>')).' =~ v:key')) | call vam#ActivateAddons(l, {'force_loading_plugins_now':1}) | endfor
"}

" Plugin Settings {
    let b:match_ignorecase = 1 " case is stupid
    "let perl_extended_vars=1 " highlight advanced perl vars
                              " inside strings

    " Fugitive Settings {
        autocmd BufReadPost fugitive://* set bufhidden=delete
        autocmd User fugitive
                    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
                    \   nnoremap <buffer> .. :edit %:h<CR> |
                    \ endif
        " }

    "" Syntastic Settings {
        "let g:syntastic_check_on_open=1
        "let g:syntastic_echo_current_error=1
        "let g:syntastic_enable_signs=1
        "let g:syntastic_enable_highlighting = 1
        "let g:syntastic_auto_loc_list=1
        "let g:syntastic_loc_list_height=3
        "let g:syntastic_javascript_checkers = ['eslint']
        ""autocmd InsertLeave SyntasticCheck
    "" }

    " Yankring Settings {
        let g:yankring_manual_clipboard_check = 1
    " }

    " TaskList Settings {
    map <leader>T <Plug>TaskList
    " }

    " airline Settings {
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
    let g:airline_theme='simple'
    " }

    " JSComplete Settings {
        "let g:jscomplete_use = ['dom', 'moz', 'es6th', 'jscript', 'xpcom']
    " }

    " session Settings {
    set sessionoptions-=helptags
    set sessionoptions-=options
    "set sessionoptions-=buffers
    let g:session_autoload='no'
    let g:session_autosave='yes'
    noremap <Leader>o :OpenSession<CR>
    " }

    " ctrlp Settings {
    let g:ctrlp_map = '<Leader>f'
    " }

    " colorscheme Settings {
    colorscheme jellybeans
    " }

    " neocomplete Settings {
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 2
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Enable heavy features.
    "Use camel case completion. DELETED on neocomplete
    "let g:neocomplete_enable_camel_case_completion = 1
    "Use underbar completion. DELETED on neocomplete
    "let g:neocomplete_enable_underbar_completion = 1

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
                \ 'default' : ''
                \ }

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.javascript = '\h\w*\|[^. \t]\.\w*'

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

    " For cursor moving in insert mode(Not recommended)
    "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
    "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
    "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
    "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
    " Or set this.
    "let g:neocomplete#enable_cursor_hold_i = 1
    " Or set this.
    "let g:neocomplete#enable_insert_char_pre = 1

    " AutoComplPop like behavior.
    let g:neocomplete#enable_auto_select = 0
    " }

     "neosnippet Settings {
    " Plugin key-mappings.
     imap <C-k>     <Plug>(neosnippet_expand_or_jump)
     smap <C-k>     <Plug>(neosnippet_expand_or_jump)
     xmap <C-k>     <Plug>(neosnippet_expand_target)
    
     " SuperTab like snippets behavior.
     imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
     \ "\<Plug>(neosnippet_expand_or_jump)"
     \: pumvisible() ? "\<C-n>" : "\<TAB>"
     smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
     \ "\<Plug>(neosnippet_expand_or_jump)"
     \: "\<TAB>"
    
     " For snippet_complete marker.
     if has('conceal')
         set conceallevel=2 concealcursor=i
     endif

    " Enable snipMate compatibility feature.
     let g:neosnippet#enable_snipmate_compatibility = 1
     " Tell Neosnippet about the other snippets
     let g:neosnippet#snippets_directory='~/.vim/vim-addons/vim-snippets/snippets'"
    " }

    " marijnh/tern_for_vim Settings {
    let g:tern_map_keys=1
    let g:tern_show_argument_hints='on_hold'
    " }

    " Gundo Settings {
    nnoremap <F9> :GundoToggle<CR>
    " }
    
    " Conque_shell Settings {
    if has('win32unix')
        nnoremap <Leader>ctn :ConqueTermVSplit console node<CR>
    else
        nnoremap <Leader>ctn :ConqueTermVSplit node<CR>
    endif
    " }

    " Cosco Settings {
    autocmd FileType javascript,css, nnoremap <silent> <Leader>; :call cosco#commaOrSemiColon()<CR>
    autocmd FileType javascript,css, inoremap <silent> <Leader>; <c-o>:call cosco#commaOrSemiColon()<CR>
    " }

    " jsbeauitify Settings {
    autocmd FileType javascript noremap <buffer>  <Leader>sb :call JsBeautify()<cr>
    autocmd FileType html noremap <buffer> <Leader>sb :call HtmlBeautify()<cr>
    autocmd FileType css noremap <buffer> <Leader>sb :call CSSBeautify()<cr>
    autocmd FileType javascript vnoremap <buffer>  <Leader>sb :call RangeJsBeautify()<cr>
    autocmd FileType html vnoremap <buffer> <Leader>sb :call RangeHtmlBeautify()<cr>
    autocmd FileType css vnoremap <buffer> <Leader>sb :call RangeCSSBeautify()<cr>
    " }

    " jsdoc Settings {
     let g:jsdoc_allow_input_prompt=1
     let g:jsdoc_additional_descriptions=1
    " }

" }

" Autocommands {
    " Various Languages {
        autocmd FileType python set omnifunc=pythoncomplete#Complete
        autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
        autocmd FileType css set omnifunc=csscomplete#CompleteCSS
        autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
        autocmd FileType php set omnifunc=phpcomplete#CompletePHP
        autocmd FileType c set omnifunc=ccomplete#Complete
        autocmd filetype html,xml set listchars-=tab:>. "unhighlighting tabs
    " }
    " Javascript {
        "autocmd FileType javascript setl omnifunc=jscomplete#CompleteJS
        autocmd FileType javascript setl omnifunc=tern#Complete
        " folding from http://amix.dk/blog/post/19132
        au FileType javascript call JavaScriptFold()
        au FileType javascript setl fen
        autocmd FileType javascript set sw=4
        autocmd FileType javascript set ts=4
        autocmd FileType javascript set sts=4
        autocmd FileType javascript set textwidth=79
    " }
    " JSON {
        au! BufRead,BufNewFile *.json set filetype=json 
        augroup json_autocmd 
            autocmd! 
            autocmd FileType json set autoindent 
            autocmd FileType json set formatoptions=tcq2l 
            autocmd FileType json set textwidth=78 shiftwidth=2 
            autocmd FileType json set softtabstop=2 tabstop=8 
            autocmd FileType json set expandtab 
            "autocmd FileType json set foldmethod=syntax 
        augroup END 
        "autocmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS
        " folding from http://amix.dk/blog/post/19132
        au FileType json call JavaScriptFold()
        au FileType json setl fen
    " }
    " Python {
        " Use the below highlight group when displaying bad whitespace is desired.
        highlight BadWhitespace ctermbg=red guibg=red
        " Display tabs at the beginning of a line in Python mode as bad.
        au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
	" Make trailing whitespace be flagged as bad.
	au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
	au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix
        au BufNewFile,BufRead *.py set tabstop=4
        au BufNewFile,BufRead *.py set softtabstop=4
        au BufNewFile,BufRead *.py set shiftwidth=4
        au BufNewFile,BufRead *.py set textwidth=79
        au BufNewFile,BufRead *.py set expandtab
        au BufNewFile,BufRead *.py set autoindent
    " }
    " vimrc {
        " from vim cast 24
        " Source the vimrc file after saving it
        if has("autocmd")
            autocmd! bufwritepost .vimrc source $MYVIMRC
        endif
        " source vimrc"
        nmap sv :so $MYVIMRC<CR>
    " }
"  }

"" GUI Settings {
"if has("gui_running")
"    " Basics {
"        colorscheme metacosm " my color scheme (only works in GUI)
"        set columns=180 " perfect size for me
"        set guifont=Consolas:h10 " My favorite font
"        set guioptions=ce 
"        "              ||
"        "              |+-- use simple dialogs rather than pop-ups
"        "              +  use GUI tabs, not console style tabs
"        set lines=55 " perfect size for me
"        set mousehide " hide the mouse cursor when typing
"    " }
"
"    " Font Switching Binds {
"        map <F8> <ESC>:set guifont=Consolas:h8<CR>
"        map <F9> <ESC>:set guifont=Consolas:h10<CR>
"        map <F10> <ESC>:set guifont=Consolas:h12<CR>
"        map <F11> <ESC>:set guifont=Consolas:h16<CR>
"        map <F12> <ESC>:set guifont=Consolas:h20<CR>
"    " }
"endif
"" }
