"""" Filetype plugin file for c and cpp files
"" use c indent
set cindent

"""" YCM settings
"" Set goto def/decl with <leader>jd
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaratioin<CR>
"" F5 to force recompilation
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
"" Auto load config file, 'b' for buffer local, 'g' for global
let g:ycm_confirm_extra_conf=0
"" Set to collect tags from tag files (:h 'tags' for more info)
let g:ycm_collect_identifiers_from_tags_files=1
"" turn on/off YCM auto completion
nnoremap <leader>y :let b:ycm_auto_trigger=0<CR>
nnoremap <leader>Y :let b:ycm_auto_trigger=1<CR>

"""" syntastic settings
"" turn on syntax checking for c/cpp headers
let g:syntastic_cpp_check_header=1

"""" vim-clang-format settings
"" use google style
let g:clang_format#code_style="google"
let g:clang_format#command="clang-format"
