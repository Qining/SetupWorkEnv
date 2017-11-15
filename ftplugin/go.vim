"""" vim-go settings
"" use the same go-to-def keybinding as rtags for go
nnoremap <leader>rj :GoDef<CR>
nnoremap <leader>rf :GoReferrers<CR>
nnoremap <leader>i <Plug>(go-info)

"""" YCM settings
let b:ycm_semantic_triggers = {
      \ 'go' : ['.'],
      \ }
