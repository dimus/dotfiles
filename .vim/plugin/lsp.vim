" set completeopt=menuone,noinsert,noselect
"
" nnoremap <silent>gd :lua vim.lsp.buf.definition()<CR>
" nnoremap <silent>gi :lua vim.lsp.buf.implementation()<CR>
" nnoremap <leader>k :lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent>gr :lua vim.lsp.buf.references()<CR>
" nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
" nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
" nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
" nnoremap <silent>]g :lua vim.lsp.diagnostic.show_line_diagnostics(); vim.lsp.diagnostic.show_line_diagnostics()<CR>
"
" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
" lua require'lspconfig'.clangd.setup{ on_attach=require'completion'.on_attach }
" lua require'lspconfig'.pyls.setup{ on_attach=require'completion'.on_attach }
" lua require'lspconfig'.solargraph.setup{ on_attach=require'completion'.on_attach }
" lua require'lspconfig'.gopls.setup{ on_attach=require'completion'.on_attach }
" lua require'lspconfig'.rust_analyzer.setup{ on_attach=require'completion'.on_attach }
" " lua require'nvim_lsp'.sumneko_lua.setup{ on_attach=require'completion'.on_attach }
"
