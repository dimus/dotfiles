lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  incremental_selection = {enable = true},
  indent = {enable = true},
}
EOF

" nvim-colorizer
set termguicolors
lua require'colorizer'.setup()

" vim-rainbow parentheses
let g:rainbow_active = 1

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

