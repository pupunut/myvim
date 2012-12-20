""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"------------------------------------------------
" => General
"------------------------------------------------

set nocompatible " Get out of VI's compatible mode
filetype plugin indent on " Enable filetype
let mapleader=',' " Change the mapleader
let maplocalleader='\' " Change the maplocalleader
set timeoutlen=500 " Time to wait for a command

" Source the vimrc file after saving it
autocmd BufWritePost .vimrc source $MYVIMRC
" Fast edit the .vimrc file using ',x'
nnoremap <Leader>x :tabedit $MYVIMRC<CR>

set autoread " Set autoread when a file is changed outside
set autowrite " Write on make/shell commands
set hidden " Turn on hidden"

set history=1000 " Increase the lines of history
set clipboard+=unnamed " Yanks go on clipboard instead
"set spell " Spell checking on
set modeline " Turn on modeline
set encoding=utf-8 " Set utf-8 encoding
set completeopt+=longest " Optimize auto complete
set completeopt-=preview " Optimize auto complete

"set mousehide " Hide mouse after chars typed
"set mouse=a " Mouse in all modes

set backup " Set backup
set undofile " Set undo

" Set directories
function! InitializeDirectories()
    "let parent=$HOME
    let parent="/tmp"
    let prefix='.vim.$UID'
    let dir_list={
                \ 'backup': 'backupdir',
                \ 'view': 'viewdir',
                \ 'swap': 'directory',
                \ 'undo': 'undodir'}

    let directory=parent.'/'.prefix
    if !isdirectory(directory)
        call mkdir (directory)
    endif

    for [dirname, settingname] in items(dir_list)
        let directory=parent.'/'.prefix.'/'.dirname.'/'
        if !isdirectory(directory)
            if exists('*mkdir')
                call mkdir (directory)
                exec 'set '.settingname.'='.directory
            else
                echo "Warning: Unable to create directory: ".directory
                echo "Try: mkdir -p ".directory
            endif
        else
            exec 'set '.settingname.'='.directory
        endif
    endfor
endfunction
call InitializeDirectories()

autocmd BufWinLeave *.* silent! mkview " Make Vim save view (state) (folds, cursor, etc)
autocmd BufWinEnter *.* silent! loadview " Make Vim load view (state) (folds, cursor, etc)

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Platform Specific Configuration
"-------------------------------------------------

" On Windows, also use '.vim' instead of 'vimfiles'
if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

set viewoptions+=slash,unix " Better Unix/Windows compatibility
set fileformats=unix,mac,dos " Auto detect the file formats

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Plugin
"--------------------------------------------------

filetype off " Required!
let g:vundle_default_git_proto='git'
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" UI Additions
Bundle 'w0ng/vim-hybrid'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'altercation/vim-colors-solarized'
Bundle 'nanotech/jellybeans.vim'
"Bundle 'Lokaltog/vim-powerline'
Bundle 'vim-scripts/cscope.vim'
Bundle 'majutsushi/tagbar'
Bundle 'fholgado/minibufexpl.vim'

filetype plugin indent on " Required!

"-------------------------------------------------
" => Vim User Interface
"-------------------------------------------------

" Set title
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}

" Set tabline
set showtabline=2 " Always show tab line
" Set up tab tooltips with every buffer name
set guitabtooltip=%F

" Set status line
set laststatus=2 " Show the statusline
" Set the style of the status line
" Use vim-powerline to modify the statuls line
"
" Only have cursorline in current window and in normal window
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline
auto InsertEnter * set nocursorline
auto InsertLeave * set cursorline
set wildmenu " Show list instead of just completing
set wildmode=list:longest,full " Use powerful wildmenu
set shortmess=at " Avoids 'hit enter'
set showcmd " Show cmd

set backspace=indent,eol,start " Make backspaces delete sensibly
set whichwrap+=h,l,<,>,[,] " Backspace and cursor keys wrap to
set virtualedit=block,onemore " Allow for cursor beyond last character
set scrolljump=5 " Lines to scroll when cursor leaves screen
set scrolloff=3 " Minimum lines to keep above and below cursor
set sidescroll=1 " Minimal number of columns to scroll horizontally
set sidescrolloff=10 " Minimal number of screen columns to keep away from cursor

set showmatch " Show matching brackets/parenthesis
set matchtime=2 " Decrease the time to blink
" Use Tab instead of % to switch among brackets/parenthesis
vnoremap <Tab> %

set formatoptions+=rnlmM " Optimize format options
set wrap " Set wrap
set textwidth=80 " Change text width
set colorcolumn=+1 " Indicate text border
"set list " Show these tabs and spaces and so on
"set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮ " Change listchars
set linebreak " Wrap long lines at a blank
set showbreak=↪  " Change wrap line break
set fillchars=diff:⣿,vert:│ " Change fillchars

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Colors and Fonts
"-------------------------------------------------

syntax on " Enable syntax
set background=dark " Set background
if !has('gui_running')
    set t_Co=256 " Use 256 colors
endif
colorscheme hybrid " Load a colorscheme

nnoremap <silent>\t :colorscheme Tomorrow-Night-Eighties<CR>
nnoremap <silent>\j :colorscheme jellybeans<CR>
nnoremap <silent>\h :colorscheme hybrid<CR>
nnoremap <silent>\s :colorscheme solarized<CR>

"-------------------------------------------------
" => Indent and Tab Related
"-------------------------------------------------

set autoindent " Preserve current indent on new lines
set cindent " set C style indent
set expandtab " Convert all tabs typed to spaces
set softtabstop=4 " Indentation levels every four columns
set shiftwidth=4 " Indent/outdent by four columns
set shiftround " Indent/outdent to nearest tabstop

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Search Related
"-------------------------------------------------

set ignorecase " Case insensitive search
set smartcase " Case sensitive when uc present
set hlsearch " Highlight search terms
set incsearch " Find as you type search
set gdefault " turn on 'g' flag

" Use sane regexes
nnoremap / /\v
vnoremap / /\v
cnoremap s/ s/\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap s? s?\v

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g* g*zzzv
nnoremap g# g#zzzv

" Visual search mappings
function! s:VSetSearch()
    let temp=@@
    normal! gvy
    let @/='\V'.substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@=temp
endfunction
vnoremap * :<C-U>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-U>call <SID>VSetSearch()<CR>??<CR>

" Use ,Space to toggle the highlight search
nnoremap <Leader><Space> :set hlsearch!<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => filename completion
"-------------------------------------------------
" Low priority filename suffixes for filename completion {{{
set suffixes-=.h        " Don't give .h low priority
set suffixes+=.aux
set suffixes+=.log
set wildignore+=*.dvi
set suffixes+=.bak
set suffixes+=~
set suffixes+=.swp
set suffixes+=.o
set suffixes+=.class
" }}}

set showfulltag         " Get function usage help automatically
set showcmd             " Show current vim command in status bar
set showmatch           " Show matching parentheses/brackets
set showmode            " Show current vim mode

" Make tab perform keyword/tag completion if we're not following whitespace
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" Make F7 spellcheck the buffer
noremap <F7> <Esc>:call IspellCheck()<CR><Esc>

" Programming Keys:
"   F9  = Make
"   F10 = Next Error
"   F11 = Prev Error
inoremap <F9> <Esc>:make<CR>
inoremap <F10> <Esc>:cnext<CR>
inoremap <F11> <Esc>:cprev<CR>
noremap <F9> <Esc>:make<CR>
noremap <F10> <Esc>:cnext<CR>
noremap <F11> <Esc>:cprev<CR>

" Buffer Switching:
"   F2 = next buffer
"   F3 = previous buffer
"   F4 = kill buffer
inoremap <F2> <Esc>:bn<CR>
inoremap <F3> <Esc>:bp<CR>
inoremap <F4> <Esc>:bd<CR>
noremap <F2> <Esc>:bn<CR>
noremap <F3> <Esc>:bp<CR>
noremap <F4> <Esc>:bd<CR>

" When vim is used in a console window, set the title bar to the
" name of the buffer being editted.
if !has("gui_running")
    auto BufEnter * let &titlestring="VIM - ".expand("%:p")
endif

" In text and LaTeX files, always limit the width of text to 76
" characters.  Also perform logical wrapping/indenting.
autocmd BufRead *.txt set tw=76 formatoptions=tcroqn2l
autocmd BufRead *.tex set tw=76

" Programming settings {{{
augroup prog
    au!
    au BufRead *.c,*.cc,*.cpp,*.h,*.java,*.sh set formatoptions=croql cindent nowrap nofoldenable

    " Don't expand tabs to spaces in Makefiles
    au BufEnter  [Mm]akefile*  set noet
    au BufLeave  [Mm]akefile*  set et

    autocmd FileType c,cpp  set formatoptions=croql comments=sr:/*,mb:*,el:*/,://
augroup END
" }}}

" Functions {{{

" IspellCheck() {{{
function! IspellCheck()
    let l:tmpfile = tempname()

    execute "normal:w!" . l:tmpfile . "\<CR>"
    if has("gui_running")
        execute "normal:!xterm -e ispell " . l:tmpfile . "\<CR>"
    else
        execute "normal:! ispell " . l:tmpfile . "\<CR>"
    endif
    execute "normal:%d\<CR>"
    execute "normal:r " . l:tmpfile . "\<CR>"
    execute "normal:1d\<CR>"
endfunction
" IspellCheck }}}

" InsertTabWrapper() {{{
" Tab completion of tags/keywords if not at the beginning of the
" line.  Very slick.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
" InsertTabWrapper() }}}

" Functions }}}

" Settings for specific syntax files {{{
let c_gnu=1
let c_comment_strings=1
let c_space_errors=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"-------------------------------------------------
" => Fold Related
"-------------------------------------------------

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Filetype Specific
"-------------------------------------------------

"-------------------------------------------------
" => Key Mapping
"-------------------------------------------------

" Make j and k work the way you expect
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Remap ; to :
nnoremap ; :
vnoremap ; :

" Repeat last substitution, including flags, with &.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG

" Strip all trailing whitespace in the current file
nnoremap <Leader>q :%s/\s\+$//<CR>:let @/=''<CR>

" See the differences between the current buffer and the file it was loaded from
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
    \ | diffthis | wincmd p | diffthis

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Local Setting
"--------------------------------------------------

" Use local vimrc if available
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" Use local gvimrc if available and gui is running
if has('gui_running')
    if filereadable(expand("~/.gvimrc.local"))
        source ~/.gvimrc.local
    endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Tagbar
"--------------------------------------------------

"--------------------------------------------------
" => NERD_tree
"--------------------------------------------------

"--------------------------------------------------
" => NERD_commenter
"--------------------------------------------------

"--------------------------------------------------
" => Neocomplcache
"--------------------------------------------------

"--------------------------------------------------
" => delimitMate
"--------------------------------------------------

"--------------------------------------------------
" => Ctrlp
"--------------------------------------------------

"--------------------------------------------------
" => Ack
"--------------------------------------------------

"--------------------------------------------------
" => Syntastic
"--------------------------------------------------

"--------------------------------------------------
" => Indent Guides
"--------------------------------------------------

"--------------------------------------------------
" => fugitive
"--------------------------------------------------

"--------------------------------------------------
" => Gundo
"--------------------------------------------------

"--------------------------------------------------
" => EasyTags
"--------------------------------------------------

"--------------------------------------------------
" => SingleCompile
"--------------------------------------------------

"--------------------------------------------------
" => Zencoding
"--------------------------------------------------

"--------------------------------------------------
" => Golden Ratio
"--------------------------------------------------

"--------------------------------------------------
" => Splitjoin
"--------------------------------------------------

"--------------------------------------------------
" => Unite
"--------------------------------------------------

"--------------------------------------------------
" => vimux
"--------------------------------------------------

let g:clang_user_options='|| exit 0' 
nmap <F8> :TagbarToggle<CR>

if has("cscope")
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
    set cscopeverbose 


	map g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
	map g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
endif

" MiniBufExpl Colors
hi MBEVisibleActive guifg=#A6DB29 guibg=fg
hi MBEVisibleChangedActive guifg=#F1266F guibg=fg
hi MBEVisibleChanged guifg=#F1266F guibg=fg
hi MBEVisibleNormal guifg=#5DC2D6 guibg=fg
hi MBEChanged guifg=#CD5907 guibg=fg
hi MBENormal guifg=#808080 guibg=fg

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1

" Modeline {{{
" " vim:set ts=4:
" " }}}
