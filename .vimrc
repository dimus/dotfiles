" vim: set foldmarker={,} foldlevel=2 foldmethod=marker ts=2 shiftwidth=2:
"  za - unfold a fold, zR unfold all, zM close all

" Plugins {
call plug#begin('~/.vim/plugged')
  Plug 'ElmCast/elm-vim'
  Plug 'SirVer/ultisnips'
  Plug 'chr4/nginx.vim'
  Plug 'derekwyatt/vim-scala'
  Plug 'easymotion/vim-easymotion'
  Plug 'fatih/vim-go'
  Plug 'git@github.com:dimus/vim-snippets'
  Plug 'git@github.com:vim-airline/vim-airline.git'
  Plug 'kana/vim-textobj-user'
  Plug 'nelstrom/vim-textobj-rubyblock'
  Plug 'neomake/neomake'
  Plug 'sebdah/vim-delve'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-jdaddy'
  Plug 'tpope/vim-rails'
  Plug 'PotatoesMaster/i3-vim-syntax'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'Shougo/vimshell'
  Plug 'Shougo/vimproc'
  Plug 'chrisbra/Colorizer'
  Plug 'ervandew/supertab'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'mechatroner/rainbow_csv'
  Plug 'frazrepo/vim-rainbow'
  Plug 'amadeus/vim-convert-color-to'
  Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
  Plug '/usr/bin/fzf'
  Plug 'junegunn/fzf'
call plug#end()

" vim-rainbow parentheses

let g:rainbow_active = 1
" to do fine-grain:
" au FileType go,c,cpp,objc,objcpp call rainbow#load()

" Go Plugin
" autocmd FileType go nmap <leader>b  <Plug>(go-build)
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

set autowrite
let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled = 0
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd Filetype go command! -bang Alt call go#alternate#Switch(<bang>0, 'edit')

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" LanguageCLient
let g:LanguageClient_autoStart = 1

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ 'go': ['gopls'],
    \ }
let g:LanguageClient_diagnosticsEnable = 0
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" nnoremap <silent> <F8> :call LanguageClient#textDocument_rename()<CR>

" CtrlP Plugin
let g:ctrlp_show_hidden = 1
set wildignore+=bin/*,*/target/*,*.o,*.hi,*.class,*.pdf,*.jpg
let g:ctrlp_custom_ignore = '\v[\/](\.(git|stack-work)|coverage|elm-stuff)$'

" UltiSnips
  nmap <F1> <nop>
  imap <F1> <nop>
  let g:UltiSnipsExpandTrigger="<F1>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Airline Plugin
  let g:airline_powerline_fonts = 1

" Neomake
autocmd! BufWritePost * Neomake

" vim-scala
autocmd BufNewFile,BufRead *.scala   set ft=scala " Set syntax highlighting for .scala files
autocmd BufNewFile,BufRead *.sc      set ft=scala " Set syntax highlighting for scala worksheet files
autocmd BufNewFile,BufRead *.peg     set ft=pigeon " pigeon syntax hl

" Ensime
" autocmd BufWritePost *.scala silent :EnTypeCheck
nnoremap <leader>t :EnType<CR>

" elm
let g:elm_detailed_complete = 0
let g:elm_format_autosave = 0

" }

" General {

  let mapleader=" "
  let maplocalleader=","
  let g:elm_setup_keybindings = 1
  set nocompatible    " Use Vim defaults (much better!)
  set path+=** " make path for find recursive
  " fix vsp and sp to be more reasonable
  set splitright splitbelow

  "wrapping
  set wrap
  set linebreak
  " set showbreak=…
  " set tw=79 " hard wrap after 79 columns

  set pastetoggle=<F2> " toggles paste mode

  if !has('nvim')
    set encoding=utf-8
  endif

  set fileencodings=utf-8,default,latin1
  set termencoding=utf-8
  set viminfo='20,\"50  " read/write a .viminfo file, don't store more
        " than 50 lines of registers
  set history=1000  " keep 1000 lines of command line history
  set undolevels=1000
  set bs=indent,eol,start " allow backspacing over everything in insert mode
  set hidden " removes warning when switching between buffers without saving them first
  set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
  filetype plugin indent on   " Automatically detect file types.
  syntax on           " syntax highlighting
  set visualbell " makes visual bell instead of sound
  set noerrorbells " no beep on errors
  set t_Co=256 " 256 colors in vim
  set lazyredraw " remove lag: makes vertical scrolling faster

  set ts=2            " makes tabulation to work as 2 spaces
  set softtabstop=2
  set shiftwidth=2    " sets indentation 2 spaces
  set shiftround      " use multiple of shiftwidth for > and <
  set expandtab       " tabs from spaces use CTRL_V_TAB to insert real tab

  set ai              " always set autoindenting on
  set nocin "no indent c-style
  set smartindent
  set smarttab
  set colorcolumn=81
  set nospell
" }

" Clipboard {
  " sets the system's clipboard 'default'
  " '+' register becomes the uunamed register
  set clipboard+=unnamedplus
" }

" Mappings {
  " faster escape
  inoremap jk <esc>
  " fuzzy search for file
  nnoremap <C-p> :FZF<CR>
  " Remove one window shortcut
  noremap <C-o>o <nop>
  " visual select for one line
  noremap vv ^vg
    " map R :!ruby % <cr>
    " map S :!spec % <cr>

  " edit .vimrc/init.vim
  noremap <leader>v :e $MYVIMRC<CR>
  " reload .vimrc/init.vim
  noremap <leader>vv :so $MYVIMRC<CR>
  " show the path to the current file
  noremap <leader>f :echo expand('%:p')<CR>
  " open snippets dir
  noremap <leader>s :e ~/.vim/plugged/vim-snippets/UltiSnips<CR>
  " reloads all opened windows in all tabs
  noremap <leader>r :tabdo exec 'windo e'<CR>

  " current file edit dir
  noremap <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
  noremap <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
  noremap <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
  noremap <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
  noremap <leader><leader>o :! zathura "%:r".pdf &<CR>
  nnoremap K :help <C-r><C-w><CR>

" Toggles SpecialKeys (paragraph, new line etc)
" should be after colors
  noremap <leader>l :set list!<CR>
  set listchars=trail:.,extends:#,nbsp:.,tab:▸\ ,eol:¬
  hi SpecialKey ctermfg=94
" }

" OTHER SETTINGS

" Augroups {
  if has("autocmd")

   " In text files, always limit the width of text to 78 characters
   " autocmd BufRead *.txt set tw=78


   augroup pyprog
     au!
     autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
     autocmd BufRead *.py set tabstop=4
     autocmd BufRead *.py set shiftwidth=4
     autocmd BufRead *.py set smarttab
     autocmd BufRead *.py set expandtab
     autocmd BufRead *.py set softtabstop=4
     autocmd BufRead *.py set autoindent
     " autocmd BufRead *.py set foldlevel=1
     " autocmd BufRead *.py set foldmethod=indent

     " autocmd FileType * set ts=2 shiftwidth=2
     " autocmd FileType py set ts=4 shiftwidth=4
   augroup END

   augroup cprog
    " Remove all cprog autocommands
    au!
    " When starting to edit a file:
    "   For C and C++ files set formatting of comments and set C-indenting on.
    "   For other files switch it off.
    "   Don't change the order, it's important that the line with * comes first.
    autocmd FileType *      set formatoptions=tcql nocindent comments&
    " autocmd FileType tex    set formatoptions=tcqj nocindent comments&
    autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
   augroup END

   augroup gzip
    " Remove all gzip autocommands
    au!

    " Enable editing of gzipped files
    " set binary mode before reading the file
    autocmd BufReadPre,FileReadPre  *.gz,*.bz2 set bin
    autocmd BufReadPost,FileReadPost  *.gz call GZIP_read("gunzip")
    autocmd BufReadPost,FileReadPost  *.bz2 call GZIP_read("bunzip2")
    autocmd BufWritePost,FileWritePost  *.gz call GZIP_write("gzip")
    autocmd BufWritePost,FileWritePost  *.bz2 call GZIP_write("bzip2")
    autocmd FileAppendPre     *.gz call GZIP_appre("gunzip")
    autocmd FileAppendPre     *.bz2 call GZIP_appre("bunzip2")
    autocmd FileAppendPost    *.gz call GZIP_write("gzip")
    autocmd FileAppendPost    *.bz2 call GZIP_write("bzip2")

    " After reading compressed file: Uncompress text in buffer with "cmd"
    fun! GZIP_read(cmd)
      let ch_save = &ch
      set ch=2
      execute "'[,']!" . a:cmd
      set nobin
      let &ch = ch_save
      execute ":doautocmd BufReadPost " . expand("%:r")
    endfun

    " After writing compressed file: Compress written file with "cmd"
    fun! GZIP_write(cmd)
      if rename(expand("<afile>"), expand("<afile>:r")) == 0
        execute "!" . a:cmd . " <afile>:r"
      endif
    endfun

    " Before appending to compressed file: Uncompress file with "cmd"
    fun! GZIP_appre(cmd)
      execute "!" . a:cmd . " <afile>"
      call rename(expand("<afile>:r"), expand("<afile>"))
    endfun

   augroup END

   " This is disabled, because it changes the jumplist.  Can't use CTRL-O to go
   " back to positions in previous files more than once.
   if 0
    " When editing a file, always jump to the last cursor position.
    " This must be after the uncompress commands.
     autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
   endif

  endif " has("autocmd")
" }

" Colors {
  colorscheme jellybeans
  " 80 column border is grey
  hi ColorColumn ctermbg=236 guibg=#303030
  " trailing spaces are red
  hi ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\v\s+$/
" }

" Commands {
  " allows to save buffer with sudo
  command! W w !sudo tee % >/dev/null
  " delete trailing space
  autocmd BufWritePre *.rb,*.treetop,*.md,*.scala,*.xml,*.hs,*.lhs,*.pl,*.py,*.rst,*.tex,*.lsl,*.gemspec,*.haml,*.yml,*.json :%s/\v\s+$//e
  " autoformat Go files on save
  autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
  " cleans git-related buffers opened by fugitive plugin
  autocmd BufReadPost fugitive://* set bufhidden=delete
  " maps `..` to going level up in a fugitive representation of git tree
  autocmd BufRead,BufNewFile *.lhs set filetype=markdown
  autocmd User fugitive
    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif
" }

" Custom vimrc {
if filereadable(".vim.custom")
    so .vim.custom
endif
" }

" Directories {
" set backup            " backups are nice ...
" set backupdir=$HOME/.vimbackup  " but not when they clog .
set nobackup    " backups are nice but not if files are huge
set noswapfile  " stop making swp files
set directory=$HOME/.vimswap  " Same for swap files
set viewdir=$HOME/.vimviews   " same but for view files

" Creating directories if they don't exist
" silent execute '!mkdir -p $HOME/.vimbackup'
silent execute '!mkdir -p $HOME/.vimswap'
silent execute '!mkdir -p $HOME/.vimviews'
" au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
" au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)

" }

" File browser {
let g:netrw_banner = 0 " disable banner
" let g:netrw_browse_split = 4 " open in prior window
let g:netrw_altv = 1 " open splits to the right
let g:netrw_liststyle = 3 " tree view
" let g:netrw_list_hide = netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s)\zs\.\S\+'
"}

" Folding {
  set foldmethod=marker " define fold method as manual
  set foldlevel=0
" }

" Line Numbering {
set relativenumber
set number
set numberwidth=3 " to save space
" nnoremap <C-n> :set relativenumber!<CR>
" set nonumber
" " }

" Matchit Macro {
" Expands % character to move between not only matching () or {} but also def, if, while etc.
  runtime macros/matchit.vim
" }

" Movements/Navigation {
  " Kill old habits using arrow keys
  "noremap <up> <nop>
  "noremap <down> <nop>
  "noremap <left> <nop>
  "noremap <right> <nop>
  "inoremap <up> <nop>
  "inoremap <down> <nop>
  "inoremap <left> <nop>
  "inoremap <right> <nop>

  " Long line movement up down
  " nnoremap j gj
  " nnoremap k gk
  nnoremap $ g$
  nnoremap 0 g0
" }

" Search {
  set nohls "no highlights for search
  set incsearch "search incrementally
  set ignorecase smartcase " ignore case if only small case letters are in search pattern
" }

" Tmux-like Mappings {
if has('nvim') && !exists('$TMUX')
   nnoremap <C-w>c :tabe<CR>
   nnoremap <C-w>! :tabe %<CR>
   nnoremap <C-w>% :vspl<CR>
   nnoremap <C-w>" :spl<CR>
   nnoremap <C-w>; <C-w><C-w>
   nnoremap <C-w>g <C-w>W
   nnoremap <C-w>1 1gt
   nnoremap <C-w>2 2gt
   nnoremap <C-w>3 3gt
   nnoremap <C-w>4 4gt
   nnoremap <C-w>5 5gt
   nnoremap <C-w>6 6gt
   nnoremap <C-w>7 7gt
   nnoremap <C-w>8 8gt
   nnoremap <C-w>9 9gt
   nnoremap <C-w>0 0gt
   " tnoremap <C-w>n <C-\><C-n> "normal mode
   tnoremap <C-w>c <C-\><C-n>:tabe<CR>
   tnoremap <C-w>! <C-\><C-n>:tabe %<CR>
   tnoremap <C-w>% <C-\><C-n>:vnew<CR>
   tnoremap <C-w>" <C-\><C-n>:new<CR>
   tnoremap <C-w>h <C-\><C-n><C-w><C-h>
   tnoremap <C-w>j <C-\><C-n><C-w><C-j>
   tnoremap <C-w>k <C-\><C-n><C-w><C-k>
   tnoremap <C-w>l <C-\><C-n><C-w><C-l>
   tnoremap <C-w>o <C-\><C-n><C-w><C-w>
   tnoremap <C-w>i <C-\><C-n><C-w>W
   tnoremap <C-w>1 <C-\><C-n>1gt
   tnoremap <C-w>2 <C-\><C-n>2gt
   tnoremap <C-w>3 <C-\><C-n>3gt
   tnoremap <C-w>4 <C-\><C-n>4gt
   tnoremap <C-w>5 <C-\><C-n>5gt
   tnoremap <C-w>6 <C-\><C-n>6gt
   tnoremap <C-w>7 <C-\><C-n>7gt
   tnoremap <C-w>8 <C-\><C-n>8gt
   tnoremap <C-w>9 <C-\><C-n>9gt
   tnoremap <C-w>0 <C-\><C-n>0gt
   tnoremap jk <C-\><C-n>
endif
" }

" Word Completion {
  set complete=.,w,b,u,t
  " complete=.,w,b,u,t,i
  " codes to add to the autocomplete sequence
  " .      Current file
  " b      Files in loaded buffers, not in a window
  " d      Definitions in the current file and in files included by a #include directive
  " i      Files included by the current file through the use of a #include directive
  " k      The file defined by the ‘dictionary’ option (discussed later in this chapter)
  " kfile  The file named {file}
  " t      The “tags” file. (The ] character can be used as well.)
  " u      Unloaded buffers
  " w      Files in other windows
  set wildmenu " in command mode allows to see other options of completion
  set wildmode=list:longest " in command mode bash-like completion to the unubigious part
" }


" Mouse {
  set mouse=a
"}

" psql
au BufRead /tmp/psql.edit.* set syntax=sql
