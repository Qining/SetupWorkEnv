"""" python-mode settings
"" turn off rope script
let g:pymode_rope=0
"" show documents
let g:pymode_doc=1
"" bind 'K' to show doc
let g:pymode_doc_bind='K'
"" Don't use python linter here, will use syntastics later
let g:pymode_lint=0
"" default lint checker
let g:pymode_lint_checkers=['pyflakes', 'pep8', 'pylint']
"" do not panic:
""   no doc str to classes/funcs
""   80 char length
let g:pymode_lint_ignore="C0111,E501"
"" disable python folding
let g:pymode_folding=0

"""" syntastic settings for python
"" set python linter
let g:syntastic_python_checkers=["flake8", "pep8"]
"" ignore E501: panic when line length >=80
"" ignore C0111: (only valid for pylint?) panic when no doc for cls and func
let g:syntastic_python_flake8_args='--ignore=E501,C0111'
let g:syntastic_python_pep8_args='--ignore=E501,C0111'
"" enable checking on saving
let g:syntastic_check_on_wq=1

"""" vim-yapf-format settings
"" use google style
let g:yapf_format_style="google"
"" use <leader>y to format
nnoremap <leader>y :YapfFormat<CR>

"""" vim-ployglot settings for python
"" enable all highlights
let g:python_highlight_all=1
