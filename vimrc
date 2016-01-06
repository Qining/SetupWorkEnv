" Enable modern Vim features not compatible with Vi spec.
"
" source to this file after:
" set nocompatible
" <source-to-google.vim>

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
" It seems 'google' package already contains 'clang linter'.
" And adding it again will cause some conflit, check the existence before
" installing this plugin.
if !exists(':ClangFormat')
  Plugin 'rhysd/vim-clang-format'
  let g:clang_format#code_style = "google"
endif

" airline settings
set laststatus=2
set t_Co=256

" NerdTree settings
map <leader>ne :NERDTree<CR>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Wrap paragraphs
map Q gq

" To make undo work correctly
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" YCM settings
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_tags_files=1

" syntastics settings
let g:syntastic_always_populate_loc_list=1

call vundle#end()            " required
" Personal plugins end

" Enable file type based indent configuration and syntax highlighting.
filetype plugin indent on
syntax on

" Personal settings
if has('mouse')
  set mouse=a
endif
set backspace=indent,eol,start
set nu
set tabstop=4
set shiftwidth=4
set softtabstop=4
set background=dark
set incsearch
set hlsearch
set ignorecase
set smartcase
