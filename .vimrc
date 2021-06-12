" vim: set foldmarker={,} foldlevel=2 foldmethod=marker ts=2 shiftwidth=2:
"  za - unfold a fold, zR unfold all, zM close all

" Plugins {
call plug#begin('~/.vim/plugged')
" highlight
  Plug 'cespare/vim-toml' " syntax highlighting for toml files
  Plug 'chr4/nginx.vim' " syntax highlight for nginx
  Plug 'lifepillar/pgsql.vim' " postgresql synthax highlight
  Plug 'jparise/vim-graphql' "graphql syntax and file detection
  Plug 'pest-parser/pest.vim' " syntax highlighting for pest parser
  " Plug 'gruvbox-community/gruvbox' " colorscheme
" other
  Plug 'SirVer/ultisnips' " snippets
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'frazrepo/vim-rainbow' " colorize brackets
  Plug 'git@github.com:dimus/vim-snippets' " my custom snippets
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim' " fuzzy search
  Plug 'machakann/vim-highlightedyank' " highlights yank command
  Plug 'mbbill/undotree' " nonlinear undo UI
  Plug 'mechatroner/rainbow_csv' " color csv fields
  Plug 'mzlogin/vim-markdown-toc' "TOC for markdown
  Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
  Plug 'tomtom/tcomment_vim' " auto commenting/uncommenting
  Plug 'tpope/vim-eunuch' " Unix commands like :Delete :Move for buf and file.
  Plug 'tpope/vim-fugitive' " git
  Plug 'tpope/vim-repeat' " add . command to some plugins
  Plug 'tpope/vim-surround' " surround something with characters like )]} etc.
  Plug 'tpope/vim-unimpaired' " move to next/previous shortcuts
  Plug 'itchyny/lightline.vim' " status bar
  Plug 'dbeniamine/cheat.sh-vim' " cheat sheet incorporation
  " Debugging
  " Plug 'puremourning/vimspector'
  Plug 'szw/vim-maximizer' " toggle window from bigto small
  Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
  Plug 'voldikss/vim-translator'
  " Plug 'nvim-treesitter/playground'
call plug#end()

" nvim-colorizer
set termguicolors
lua require'colorizer'.setup()

" vim-rainbow parentheses
let g:rainbow_active = 1

" vim translator

let g:translator_target_lang = "en"
let g:translator_default_engines = ['bing', 'google']
" Echo translation in the cmdline
nmap <silent> tt <Plug>Translate
vmap <silent> tt <Plug>TranslateV

" pgsql plugin for sql queries
let g:sql_type_default = 'pgsql'

" UltiSnips
nmap <F1> <nop>
imap <F1> <nop>
let g:UltiSnipsExpandTrigger="<F1>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Lightline
" let g:lightline = {
"       \ 'colorscheme': 'wombat'
"       \}

" Neomake
" autocmd! BufWritePost * Neomake

" General {
  
  " set guifont=FiraCode:h14
  let mapleader="\<Space>"
  let maplocalleader=","
  set nocompatible    " Use Vim defaults (much better!)
  set path+=** " make path for find recursive
  " fix vsp and sp to be more reasonable
  set splitright splitbelow

  "search
  " use \c to search capitalized words
  " /\chelloworld
  set ignorecase
  " set smartcase

  " search with fzf
  " let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  let $FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
  " search current buffer
  nmap // :BLines<CR>
  " search whole project
  nmap ?? :Rg<CR>
  " search vim/plugin commands
  nmap cc :Commands<CR>

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
  " let base16colorspace=256
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
  set undodir=~/.vim/undodir
  set undofile
" }

" Tabs
noremap <C-h> :tabp<CR> " to the rithgt tab
noremap <C-l> :tabn<CR> " to the left tab
noremap <C-J> :tabc<CR> " close current tab

" Clipboard {
  " sets the system's clipboard 'default'
  " '+' register becomes the uunamed register
  set clipboard+=unnamedplus
" }

" Mappings {
  " faster escape
  " inoremap jk <esc>
  inoremap jj <esc>
  " fuzzy search for file
  nnoremap <C-p> :Files<CR>
  nnoremap <leader>; :Buffers<CR>
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
  " autocmd ColorScheme * highlight Normal ctermbg=black
  " autocmd ColorScheme * highlight NonText ctermbg=black
  " colorscheme gruvbox

  " 80 column border is grey
  hi ColorColumn ctermbg=236 guibg=#303030
  " trailing spaces are red
  hi ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\v\s+$/
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
  nnoremap <leader>u :UndotreeShow<CR>
" }

" Search {
  set nohls "no highlights for search
  set incsearch "search incrementally
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

"===============================================================================
" Coc Settings
"===============================================================================
" Give more space for displaying messages.
" set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"===============================================================================
" End Coc settings
"===============================================================================

" Commands {
  " allows to save buffer with sudo
  command! W w !sudo tee % >/dev/null
  " delete trailing space
  autocmd BufWritePre *.rb,*.treetop,*.md,*.scala,*.xml,*.hs,*.lhs,*.pl,*.py,*.tex,*.lsl,*.gemspec,*.haml,*.yml,*.json,*.rs :%s/\v\s+$//e
  " autoformat Go files on save
  autocmd BufWritePre *.go,*.rs,*.rb :Format
  " cleans git-related buffers opened by fugitive plugin
  autocmd BufReadPost fugitive://* set bufhidden=delete
  " maps `..` to going level up in a fugitive representation of git tree
  autocmd BufRead,BufNewFile *.lhs set filetype=markdown
  autocmd User fugitive
    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif
" }

" noremap <silent><leader>jl :!wal --theme random_dark<cr><cr>
command! Case lua require('test').changeCase()
" command! Case lua print("hi")

" MaximizeToggle from vim-maximizer
nnoremap <leader>m :MaximizerToggle<CR>

" Debugger from vimspector
nnoremap <leader>dd call :vimspector#Launch()<CR>
nnoremap <leader>de call :vimspector#Reset()<CR>

nnoremap <leader>dc call :vimspector#GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt call :vimspector#GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv call :vimspector#GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw call :vimspector#GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds call :vimspector#GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do call :vimspector#GotoWindow(g:vimspector_session_windows.output)<CR>

nnoremap <leader>dtcb call :vimspector#CleanLineBreakpoint()<CR>

nnoremap <leader>dl <Plug>VimspectorStepInto
nnoremap <leader>dj <Plug>VimspectorStepOver
nnoremap <leader>dk <Plug>VimspectorStepOut
nnoremap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> call :vimspector#Continue()<CR>

nnoremap <leader>drc <Plug>VimspectorRunToCursor
nnoremap <leader>dbp <Plug>VimspectorToggleBreakpoint
nnoremap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint


