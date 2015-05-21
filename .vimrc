" vim: set foldmarker={,} foldlevel=0 foldmethod=marker ts=2 shiftwidth=2 spell: "  configuration file from Encyclopedia of Life team "  based on .vimrc of Steve Francia.  "  To use it copy this file to
"    for Unix and OS/2:  ~/.vimrc
"    for MS-DOS and Win32:  $VIM\_vimrc
"  za - unfold a fold, zR unfold all

" Configure neobundle {
" Note: Skip initialization for vim-tiny or vim-small.
 if !1 | finish | endif

 if has('vim_starting')
   set nocompatible               " Be iMproved

   " Required:
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'
 NeoBundle 'fatih/vim-go', {'name': 'go'}
 NeoBundle 'tpope/vim-surround', {'name': 'surround'}
 NeoBundle 'tomtom/tcomment_vim', {'name': 'tcomment'}
 NeoBundle 'tpope/vim-rails', {'name': 'rails'}
 NeoBundle 'ervandew/supertab', {'name': 'supertab'}
 NeoBundle 'SirVer/ultisnips', {'name': 'ultisnips'}
 NeoBundle 'honza/vim-snippets', {'name': 'snippets'}
 NeoBundle 'kana/vim-textobj-user', {'name': 'textobj-user'}
 NeoBundle 'nelstrom/vim-textobj-rubyblock', {'name': 'textobj-rubyblock'}
 " NeoBundle 'Shougo/neocomplete.vim', {'name': 'neocomplete'}
 call neobundle#end()

 " Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck
" }

" Matchit Macro {
" Expands % character to move between not only matching () or {} but also def, if, while etc.
  runtime macros/matchit.vim
" }

" Tabs, Indentations {
  set ts=2            " makes tabulation to work as 2 spaces
  set softtabstop=2
  set shiftwidth=2    " sets indentation 2 spaces
  set expandtab       " tabs from spaces use CTRL_V_TAB to insert real tab

  set ai              " always set autoindenting on
  set nocin "no indent c-style
  set smartindent
  set smarttab
  set colorcolumn=81
  set nospell
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

" General {
  let mapleader=","
  set nocompatible    " Use Vim defaults (much better!)

  "wrapping
  set wrap
  set linebreak
  set showbreak=…

  set fileencodings=utf-8,default,latin1
  set encoding=utf-8
  set termencoding=utf-8
  set viminfo='20,\"50  " read/write a .viminfo file, don't store more
        " than 50 lines of registers
  set history=50    " keep 50 lines of command line history
  set bs=indent,eol,start " allow backspacing over everything in insert mode
  set hidden " removes warning when switching between buffers without saving them first
  set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
  filetype plugin indent on   " Automatically detect file types.
  syntax on           " syntax highlighting
  set mouse=a         " automatically enable mouse usage
  set vb "makes visual bell instead of sound
  set t_Co=256

  " Setting up the directories {
    " set backup            " backups are nice ...
    " set backupdir=$HOME/.vimbackup  " but not when they clog .
    set nobackup    "backups are nice but not if files are huge
    set directory=$HOME/.vimswap  " Same for swap files
    set viewdir=$HOME/.vimviews   " same but for view files

    " Creating directories if they don't exist
    " silent execute '!mkdir -p $HOME/.vimbackup'
    silent execute '!mkdir -p $HOME/.vimswap'
    silent execute '!mkdir -p $HOME/.vimviews'
    " au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
    " au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)
  " }
" }

" Status Bar {
  set ruler   " show the cursor position all the time
  "shows encoding of the file
  set statusline=%<%f%h%m%r%=%b\ %{&encoding}\ 0x%B\ \ %l,%c%V\ %P
  set laststatus=2
" }

" Search {
  set nohls "no highlits for search
  set incsearch "search incrementally
  set ignorecase smartcase " ignore case if only small case letters are in search pattern
" }

" Folding {
  set foldmethod=marker " define fold method as manual
  set foldlevel=0
" }

" Invisibles {
  nmap <leader>l :set list!<CR>
  set listchars=tab:▸\ ,eol:¬
" }

" Mappings {
  " visual select of a line without trailing spaces
  let g:UltiSnipsExpandTrigger="<F1>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"
  map vv ^vg_
  " map R :!ruby % <cr>
  " map S :!spec % <cr>
  nmap <leader>v :sp $MYVIMRC<CR>
  nmap <leader>s :tabedit ~/.vim/bundle/snipmate/snippets/ruby.snippets<CR>
  nmap <C-j> <C-W><Down>
  nmap <C-k> <C-W><Up>
  nmap <C-l> <C-W><right>
  nmap <C-h> <C-W><left>
  " imap <M-h> <left>
  " imap <M-j> <down>
  " imap <M-k> <up>
  " imap <M-l> <right>
  inoremap jj <Esc>
  " current file edit dir
  map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
  map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
  map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
  map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
" }

" Commands {
  " allows to save buffer with sudo
  command W w !sudo tee % >/dev/null
  autocmd BufWritePre *.rb,*.treetop,*.md :%s/\v\s+$//e
" }

" Rails {
  if has("autocmd")
    autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
    autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
    autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
    autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
    autocmd User Rails Rnavcommand spm spec/models -glob=**/* -suffix=_spec.rb -default=model()
    autocmd User Rails Rnavcommand sph spec/helpers -glob=**/* -suffix=_helper_spec.rb -default=controller()
    autocmd User Rails Rnavcommand spc spec/controllers -glob=**/* -suffix=_controller_spec.rb -default=controller()
    autocmd User Rails Rnavcommand spv spec/views -glob=**/* -suffix=_view_spec.rb
    autocmd User Rails Rnavcommand spf spec/fixtures -glob=**/* -suffix=.yml
    autocmd User Rails Rnavcommand cfg config -glob=**/* -suffix=.rb
  endif
" }

" Rotate encoding {
  map <F8> :execute RotateEnc()<CR>
  map <F7> :let &fileencoding=&encoding<CR>
  map <F6> :%s/├Т/"/ge<CR>:%s/├У/"/ge<CR> :%s/├Х/'/ge<CR>
  " some funcs

  let b:encindex=0
  function! RotateEnc()
      let y = -1
      while y == -1
          let encstring = "#utf-8#koi8-r#default#latin1#"
          let x = match(encstring,"#",b:encindex)
          let y = match(encstring,"#",x+1)
          let b:encindex = x+1
          if y == -1
              let b:encindex = 0
          else
              let str = strpart(encstring,x+1,y-x-1)
              return ":set encoding=".str
          endif
      endwhile
  endfunction
" }

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
  color ron
  if &diff
      colorscheme evening
  endif
  hi Comment    term=NONE cterm=NONE ctermfg=Cyan
  hi Constant   ctermfg=gray
  hi String     ctermfg=green
  hi Folded     ctermbg=black ctermfg=green guibg=black guifg=green
  hi FoldColumn guibg=black guifg=green
  hi NonText    ctermfg=blue guifg=#4a4a59
  hi SpecialKey ctermfg=blue guifg=#4a4a59
  hi ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\v\s+$/
" }

" Diffs {
" Disable one diff window during a three-way diff allowing you to cut out the
" noise of a three-way diff and focus on just the changes between two versions
" at a time. Inspired by Steve Losh's Splice
function! DiffToggle(window)
  " Save the cursor position and turn on diff for all windows
  let l:save_cursor = getpos('.')
  windo :diffthis
  " Turn off diff for the specified window (but keep scrollbind) and move
  " the cursor to the left-most diff window
  exe a:window . "wincmd w"
  diffoff
  set scrollbind
  set cursorbind
  exe a:window . "wincmd " . (a:window == 1 ? "l" : "h")
  " Update the diff and restore the cursor position
  diffupdate
  call setpos('.', l:save_cursor)
endfunction
" Toggle diff view on the left, center, or right windows
nmap <silent> <leader>dl :call DiffToggle(1)<cr>
nmap <silent> <leader>dc :call DiffToggle(2)<cr>
nmap <silent> <leader>dr :call DiffToggle(3)<cr>
" }
