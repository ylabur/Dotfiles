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

set viminfo='20,\"500
set backupdir=$HOME/.vim/_backup             " store backup files here
set directory=$HOME/.vim/_temp,/var/tmp,/tmp " store swap files here

" Low priority for these files in tab-completion.
set suffixes+=.aux,.bbl,.blg,.dvi,.log,.pdf,.fdb_latexmk
set suffixes+=.info,.out,.o,.lo,.bak,~,.swp,.o,.info,.log


" =============================================================================
"                                  Formatting
" =============================================================================
set autoindent          " Copy indent from current line on starting a new line.
set smartindent         " Indent in an extra level in some cases
set copyindent          " Copy the structure of existing indentation
set expandtab           " Expand tabs to spaces.
set tabstop=2           " number of spaces for a <Tab>.
set shiftwidth=2        " Tab indention

" Indentation Tweaks.
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
set showbreak=↪         " Highlight non-wrapped lines.
set showcmd             " Display incomplete command in bottom right corner.
set showmatch           " Show matching brackets
set number              " Display line numbers

set t_Co=256            " We use 256 color terminal emulators these days.

if exists('+colorcolumn')
  set colorcolumn=81    " Highlight column 81 " if supported, use colorcolumn
  highlight colorcolumn ctermbg=238 " zenburn sets red columns for reasons? Let's make that gray.
else
	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1) " alt to colorcolumn
endif

scriptencoding utf-8    " Use unicode characters
set encoding=utf-8      " Also required to use unicode characters
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\  " representing tab with the special triangle unicode char


" =============================================================================
"                                   Syntax
" =============================================================================
syntax on
