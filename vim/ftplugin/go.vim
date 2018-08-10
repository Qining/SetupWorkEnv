"""" vim-go settings
"" use the same go-to-def keybinding as rtags for go
nnoremap <leader>rj :GoDef<CR>
nnoremap <leader>rf :GoReferrers<CR>
nnoremap <leader>i <Plug>(go-info)
"" Use quickfix list
let g:go_list_type="quickfix"
"" Do GoMetaLinter on save
let g:go_metalinter_autosave=0
"" enable goimports to automatically insert import paths
let g:go_fmt_command="goimports"
"" Auto format
let g:go_fmt_autosave=1
"" highlights
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"""" syntastic settings with vim-go
let b:syntastic_go_checkers=['go', 'golint', 'govet', 'errcheck']
let b:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
