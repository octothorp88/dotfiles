set nocompatible
filetype off

set backspace=indent,eol,start

set rtp+=~/.vim/bundle/vundle/
set cm=blowfish2
call vundle#rc()
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
":BundleList        <- to list your bundles
":BundleInstall     <- to install Bundle
"
" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %
" autocmd FileType py :let b:AutoCloseOn = 1

set pastetoggle=<F2>
set clipboard=unnamed
set relativenumber

" The bundles you install will be listed here
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-powerline'
" Bundle 'tpope/vim-fugitive'
" Bundle 'jiangmiao/auto-pairs'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-ragtag'
Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'
Bundle 'Shougo/neocomplete.vim'
" Bundle 'joonty/vdebug.git'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'rizzatti/dash.vim'

" Bundle 'davidhalter/jedi-vim'
" Bundle 'Valloric/YouCompleteMe'
" Bundle 'ervandew/supertab'
" Bundle 'Townk/vim-autoclose' <--Slows down <esc>

let g:AutoPairsFlyMode = 1

" IGNORE MAPPINGS FOR CTRLP
set wildignore+=*/venv/*,*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
" unlet g:ctrlp_custom_ignore
nmap ; :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(venv|git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" Settings for jedi-vim
" cd ~/.vim/bundle
" git clone git://github.com/davidhalter/jedi-vim.git
" let g:jedi#usages_command = "<leader>z"
" let g:jedi#popup_on_dot = 0
" let g:jedi#popup_select_first = 0
" map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
"
"VIM RAGTAG
inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1
"
"Mapping       Changed to   (cursor = ^) ~
"<C-X>=        foo<%= ^ %>                               *ragtag-CTRL-X_=*
"<C-X>+        <%= foo^ %>                               *ragtag-CTRL-X_+*
"<C-X>-        foo<% ^ %>                                *ragtag-CTRL-X_-*
"<C-X>_        <% foo^ %>                                *ragtag-CTRL-X__*
"<C-X>'        foo<%# ^ %>                               *ragtag-CTRL-X_'*
"              (mnemonic: ' is a comment in ASP VBS)
"<C-X>"        <%# foo^ %>                               *ragtag-CTRL-X_quote*
"<C-X><Space>  <foo>^</foo>                              *ragtag-CTRL-X_<Space>*
"<C-X><CR>     <foo>\n^\n</foo>                          *ragtag-CTRL-X_<CR>*
"<C-X>/        Last HTML tag closed                      *ragtag-CTRL-X_/*
"<C-X>!        <!DOCTYPE...>/<?xml ...?> (menu)          *ragtag-CTRL-X_!*
"<C-X>@        <link rel="stylesheet" ...>               *ragtag-CTRL-X_@*
"              (mnemonic: @ is used for importing in a CSS file)
"<C-X>#        <meta http-equiv="Content-Type" ... />    *ragtag-CTRL-X_#*
"<C-X>$        <script src="/javascripts/^.js"></script> *ragtag-CTRL-X_$*
"              (mnemonic: $ is valid in javascript identifiers)

" bind Ctrl+<movement> keys to move around the windows, instead of using
" Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)

" imap jk <ESC>
" imap kj <ESC>
" imap <SHIFT-space> <Esc>

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
map ,, :only <CR>

" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
" for use before a colorscheme definition
" highlight unwanted(trailing) whitespace
" + have this highlighting not appear whilst you are typing in insert mode
" + have the highlighting of whitespace apply when you open new buffers
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" for use when not using a colorscheme
" highlight ExtraWhitespace ctermbg=red guibg=red

" show unwanted whitespace

colorscheme murphy

" strip unwanted trailing whitespace on save
" autocmd BufWritePre * :%s/\s\+$//e

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on

" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Useful settings
set history=900
set undolevels=900

" change TABs to spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make search case insensitive instead of :set ic
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

augroup vimrc_autocmds
	autocmd!
	" highlight characters past column 120
	autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
	autocmd FileType python match Excess /\%120v.*/
	autocmd FileType python set nowrap
	augroup END

" "Powerline options
set laststatus=2
set encoding=utf-8
set t_Co=256
let g:Powerline_symbols = 'unicode'

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0 

" Documentation
let g:pymode_doc = 0
" set completeop=menu is hack to stop doc from poppingup 
set completeopt=menu
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 1

"=== Key mappings
let mapleader=","

function! Comment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    silent s/^/\# /
  elseif ext == 'js' || ext == 'scala'
    silent s:^:\/\/:g
  elseif ext == 'vim'
    silent s:^:\":g
  endif
endfunction

function! Uncomment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    silent s/^\# //
  elseif ext == 'js' || ext == 'scala'
    silent s:^\/\/::g
  elseif ext == 'vim'
    silent s:^\"::g
  endif
endfunction

map <F3> :call Comment()<CR>
map <F4> :call Uncomment()<CR>
map <F2> :NERDTreeToggle<CR>

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

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
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
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
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ neocomplete#start_manual_complete()
function! s:check_back_space() "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}


