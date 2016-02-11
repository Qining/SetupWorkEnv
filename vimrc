" Enable modern Vim features not compatible with Vi spec.
"
" source to this file after:
" set nocompatible
" <source-to-google.vim>
" filetype plugin indent on
" syntax on

" All of your plugins must be added before the following line.

" Personal plugins begin
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" theme, colorscheme
Plugin 'flazz/vim-colorschemes'
Plugin 'kien/rainbow_parentheses.vim'

" motion, repeating
Plugin 'easymotion/vim-easymotion'
  " lighter search tool alternative to easymotion
  " <s> to search next, <S> to search previous
" Plugin 'justinmk/vim-sneak'
  " fuzzy file search
Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'terryma/vim-multiple-cursors'
Plugin 'ntpeters/vim-better-whitespace'

" programming
Plugin 'Valloric/YouCompleteMe'
Plugin 'nathanaelkane/vim-indent-guides'
  " vim rtags binding
  " common usage:
  " <leader>rf : find references
  " <leader>rj : go to definiation
  " <leader>rw : rename symbol under cursor (not tested)
Plugin 'lyuts/vim-rtags'
  " It seems 'google' package already contains 'clang linter'.
  " And adding it again will cause some conflit, check the existence before
  " installing this plugin.
" Plugin 'rhysd/vim-clang-format'
" let g:clang_format#code_style = "google"

  " Toggle comments faster
  " <leader>cc : set to comment
  " <leader>cu : cancel comment
Plugin 'scrooloose/nerdcommenter'
  " Simplify Doxygen documentation in C, C++, Python.
  " Use :Dox command with cursor on the function declaration would generate
  " doxygen style comments.
Plugin 'vim-scripts/DoxygenToolkit.vim'

" language support
Plugin 'klen/python-mode'
Plugin 'plasticboy/vim-markdown'

" IDE
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'

call vundle#end()            " required
" Personal plugins end

"""" airline settings
set laststatus=2

"""" NerdTree settings
" Toogle folder tree split
map <leader>ne :NERDTree<CR>
" Rational way to move between splits, this is not only for NerdTree.
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"""" NerdCommenter settings
" Add a blank space before commented content
let g:NERDSpaceDelims=1

"""" YCM settings
" Set goto def/decl with <leader>jd
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" F5 to force recompilation
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
" Auto load config file
let g:ycm_confirm_extra_conf=0
" Set to collect tags from tag files (:h 'tags' for more info)
let g:ycm_collect_identifiers_from_tags_files=1

" Don't forget to use cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON to generate
" compile command json file, then set 'compilation_data_base_folder' to the
" directory of the generated json file.

"""" syntastic settings
let g:syntastic_always_populate_loc_list=1

" set python linter
let g:syntastic_python_checkers=["flake8", "pep8"]
" I need to set ignore rules for each checker.
" E501: panic when line length >= 80
" C0111: (propably only valid for pylint), panic when no doc string found for a
" class.
let g:syntastic_python_flake8_args='--ignore=E501,C0111'
let g:syntastic_python_pep8_args='--ignore=E501,C0111'


"""" vim-indent-guide options
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

"""" vim-easymotion settings
" disable default mapping first
let g:EasyMotion_do_mapping=0
" map easymotion prefix to <leader>
map <leader> <plug>(easymotion-prefix)
" turn on smart case for vim-easymotion
" just like set ignorecase and set smartcase
let g:EasyMotion_smartcase=1
" set s to bi-directional and over-windows search
" need 2 char to trigger, i.e. <leader>s{char}{char}{label}
nmap s <plug>(easymotion-overwin-f2)
" jk motions, use when in easymotion mode
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymotion-k)

"""" python-mode settings
" turn off rope script
let g:pymode_rope=0
" show document
let g:pymode_doc=1
" bind 'K' to show doc
let g:pymode_doc_bind='K'
" don't need python linter support, I prefer syntastics now.
let g:pymode_lint=0
" " select default lint checker
" let g:pymode_lint_checkers=['pyflakes', 'pep8', 'pylint']
" " please don't panic if I don't add doc string to functions and classes
" let g:pymode_lint_ignore="C0111,E501"

""" vim-markdown options
" disable folding
let g:vim_markdown_folding_disabled=1

"""" generic settings

" Enable file type based indent configuration and syntax highlighting.
filetype plugin indent on
syntax on

" enable mouse
if has('mouse')
  set mouse=a
endif

" Useful if you want to edit multiple buffers without saving the modifications
" made to a buffer while loading other buffers.
set hidden

" how many lines of history VIM should remember
set history=1000

set backspace=indent,eol,start

" autoindent (short for ai), copy indent from current line when starting a new
" line.
set autoindent
" smartindent (short for si), do smart auto indenting when starting a new line.
set smartindent

" show line number
set nu

" the kind of folding used for the current window
set foldmethod=syntax
" the higher the foldlevel, the more folded regions are open
" when set to 0, no fold is open.
set foldlevel=100

" tabstop=X (short for ts), number of spaces that a 'tab' counts
" shiftwidth=X (short for sw), number of spaces to use for each step of auto
" indent.
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab

" incremental search and highlight search result
set incsearch
set hlsearch

" if /<lower case>, return both upper case and lower case results.
" if /<upper case>, only return upper case results.
set ignorecase
set smartcase

" auto read when a file is changed outside
set autoread

set wildmenu
set showmatch
set title

" set colorscheme, still not understood
 set background=dark
" let g:solarized_termmcolors=256
" colorscheme solarized
highlight Normal ctermbg=none
colorscheme desertEx
" to make vim color works correctly, have to tell vim we have a 256 color
" terminal.
set t_Co=256

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Need at least 15 lines before and after my cursor
set scrolloff=15

" Use system clipboard with 'intuitive' keys
" These maps work in visual and insert mode, so I
" don't need to worry about conflicts.
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" keep search result at the center
nnoremap n nzz
nnoremap N Nzz

" Wrap paragraphs
map Q gq

" To make undo work correctly
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" Sets the copy paste buffer large enough
set viminfo-='20,<1000,s1000

"""" programming helpers based on file type

augroup CSourceFile
  au!
  " Set to cindent for c family language.
  au FileType c,cpp set cindent
augroup END

augroup PythonFile
  au!
  " Set <leader>y to format current python file.
  " Assume the yapf lib directory is at $HOME/Workspace/lib/yapf
  au FileType python nnoremap <leader>y :0,$!python $HOME/Workspace/lib/yapf<Cr>
augroup END

augroup NasmFile
  au!
  " Automatically set file type to nasm if file extension is '.nasm'.
  " Syntastics checker also relies on this to enable nasm checker.
  " au is short for autocmd
  au BufRead,BufNewFile *.nasm set filetype=nasm
augroup END

augroup MakeFile
  au!
  " in Makefile, don't expand tabs to spaces, we need REAL tabs.
  au FileType make set noexpandtab
augroup END
