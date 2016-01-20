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
Plugin 'scrooloose/nerdtree'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'Valloric/YouCompleteMe'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'bling/vim-airline'
Plugin 'tell-k/vim-autopep8'
Plugin 'scrooloose/syntastic'

" Toggle comments faster
" <leader>cc : set to comment
" <leader>cu : cancel comment
Plugin 'scrooloose/nerdcommenter'

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

call vundle#end()            " required
" Personal plugins end

" Enable file type based indent configuration and syntax highlighting.
filetype plugin indent on
syntax on

"""" airline settings
set laststatus=2
set t_Co=256

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
let g:ycm_confirm_extra_conf = 0
" Set to collect tags from tag files (:h 'tags' for more info)
let g:ycm_collect_identifiers_from_tags_files=1

" Don't forget to use cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON to generate
" compile command json file, then set 'compilation_data_base_folder' to the
" directory of the generated json file.

"""" syntastics settings
let g:syntastic_always_populate_loc_list=1

" Personal settings
if has('mouse')
  set mouse=a
endif

"set hidden
set backspace=indent,eol,start
set autoindent
set copyindent
set nu
set tabstop=4
set shiftwidth=4
set softtabstop=4
set background=dark
set incsearch
set hlsearch
set ignorecase
set smartcase
set autoread
set wildmenu
set showmatch
set title

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

" Automatically set file type to nasm if file extension is '.nasm'.
" Syntastics checker also relies on this to enable nasm checker.
" au is short for autocmd
au BufRead,BufNewFile *.nasm set filetype=nasm
