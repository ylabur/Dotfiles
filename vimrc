" =============================================================================
"                               Pathogen settings
" =============================================================================
execute pathogen#infect()
filetype plugin indent on
" =============================================================================
"                               General settings
" =============================================================================

set backspace=indent,eol,start " Backspacing over everything in insert mode.
set history=1024        " Lines of command history
set ignorecase          " Case-insensitive search
set smartcase           " Override ignorecase when searching uppercase.
set incsearch           " Jumps to search word as you type.
set wildmode=longest,list:full " How to complete <Tab> matches.
set wildmenu
set virtualedit=block   " Support moving in empty space in block mode.
set magic               " Improves default search
set autoread            " Prompt to reread a file if it changes
set wrap                " Wraps long lines
set scrolloff=5         " Always shows five lines of vertical context around the cursor
set autochdir           " set cwd to that of the currently displayed file

set viminfo='20,\"500
set backupdir=$VIMBACKUPDIR//             " store backup files here
set directory=$VIMDIRECTORY//,/var/tmp,/tmp " store swap files here

" Low priority for these files in tab-completion.
set suffixes+=.aux,.bbl,.blg,.dvi,.log,.pdf,.fdb_latexmk
set suffixes+=.info,.out,.o,.lo,.bak,~,.swp,.o,.info,.log

"##############################################################################
"" a wise man once told me... (Stack Overflow 6053301)
"" Easier split navigation
"##############################################################################
"" Use ctrl-[hjkl] to select the active split!
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-l> <c-w>l


" =============================================================================
"                                  Formatting
" =============================================================================
" Indentation Tweaks.
" set autoindent          " copy indent from current line on starting a new line.
" set smartindent         " indent in an extra level in some cases
" set copyindent          " copy the structure of existing indentation
" set tabstop=80           " number of spaces for a <tab>.
" set smarttab            " tab inserts indents instead of tabs
set expandtab           " expand tabs to spaces.
" set softtabstop=2       " simulate tab stops

" e-s = do not indent if opening bracket is not first character in a line.
" g0  = do not indent C++ scope declarations.
" t0  = do not indent a function's return type declaration.
" (0  = line up with next non-white character after unclosed parentheses...
" W4  = ...but not if the last character in the line is an open parenthesis.
set cinoptions=e-s,g0,t0,(0,W4


" =============================================================================
"                                   Styling
" =============================================================================
set background=dark     " Syntax highlighting for a dark terminal background.
set hlsearch            " Highlight search results.
set ruler               " Show the cursor position all the time.
" set showbreak=↪         " Highlight non-wrapped lines.
set showcmd             " Display incomplete command in bottom right corner.
set showmatch           " Show matching brackets
set number              " Display line numbers

set t_Co=256            " We use 256 color terminal emulators these days.


scriptencoding utf-8    " Use unicode characters
set encoding=utf-8      " Also required to use unicode characters
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\  " representing tab with the special triangle unicode char


" =============================================================================
"                                   Syntax
" =============================================================================
syntax on
au BufRead,BufNewFile *.json set filetype=javascript


" =============================================================================
"                                   Plugins
" =============================================================================
" zenburn
" colors zenburn
" column coloring needs to happen after loading colors
if exists('+colorcolumn')
  let &colorcolumn=join(range(121,999),",")
  highlight colorcolumn ctermbg=235
else
	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1) " alt to colorcolumn
endif

" NERDTree
map <F2> :NERDTreeToggle<CR>

" vim-airline
set laststatus=2       " enable staus line
set ttimeoutlen=50     " not sure what this is
let g:airline_powerline_fonts = 1         " enable powerline fonts
let g:airline_theme = 'powerlineish'      " pretty status
let g:airline#extensions#hunks#enabled=0  " enable scm stuff
let g:airline#extensions#branch#enabled=1 " enable scm stuff
let g:airline#extensions#tabline#enabled=1 " add buffer status line
let g:airline#extensions#tabline#fnamemod=':t' " only the filename

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" Python-mode, stolen from http://unlogic.co.uk/2013/02/08/vim-as-a-python-ide/
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
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'
"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "flake8"
let g:pymode_lint_ignore="C901,E111,E114,E121,E501"
" Auto check on save
let g:pymode_lint_write = 1
" Support virtualenv
let g:pymode_virtualenv = 1
" Enable breakpoints plugin
" let g:pymode_breakpoint = 1
" let g:pymode_breakpoint_bind = '<leader>b'
" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
" Don't autofold code
let g:pymode_folding = 0


" Taken from https://github.com/carlhuda/janus/blob/master/janus/vim/tools/janus/after/plugin/nerdtree.vim
" Pins NERDTree to the left hand side
augroup AuNERDTreeCmd
autocmd AuNERDTreeCmd FocusGained * call s:UpdateNERDTree()
augroup END

function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif
endfunction

set shiftwidth=2        " tab indention
" set NERDTree ignore files
let NERDTreeIgnore=['\.pyc$']
" turn on if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std:in") | NERDTree | endif

" tmuxline
let g:tmuxline_preset = 'tmux'
