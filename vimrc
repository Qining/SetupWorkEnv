"" Enable modern Vim features not compatible with Vi spec.
set nocompatible " be iMproved, required
filetype off " required
set noswapfile " disable swap file

call plug#begin('~/.vim/plugged')

"" theme, colorscheme
Plug 'flazz/vim-colorschemes'
Plug 'kien/rainbow_parentheses.vim'
Plug 'sheerun/vim-polyglot'
Plug 'mhinz/vim-hugefile'

"" motion, repeating
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'terryma/vim-multiple-cursors'
Plug 'ntpeters/vim-better-whitespace'

"" IDE
Plug 'ctrlpvim/ctrlp.vim'
  " by default use <leader>ig to toggle vim indent guides plugin.
  " or just use :IndentGuidesToggle
Plug 'nathanaelkane/vim-indent-guides'
  " Toggle comments faster
  " <leader>cc : set to comment
  " <leader>cu : cancel comment
Plug 'scrooloose/nerdcommenter'
  " project specific vim settings, this is much better than :set exrc
Plug 'thinca/vim-localrc'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
" Plug 'majutsushi/tagbar'

"" language
Plug 'Valloric/YouCompleteMe', {'for': ['cpp', 'c']}
  " vim rtags binding
  " common usage:
  " <leader>rf : find references
  " <leader>rj : go to definition
  " <leader>rS : go to definition, open in horizontal split
  " <leader>rV : go to definition, open in vertical split
  " <leader>rr : reindex current file
  " <leader>rw : rename symbol under cursor (not tested)
  " Note, only work in C family language.
Plug 'lyuts/vim-rtags', {'for': ['cpp', 'c']}
  " It seems 'google' package already contains 'clang linter'.
  " And adding it again will cause some conflit, check the existence before
  " installing this plugin.
Plug 'rhysd/vim-clang-format', {'for': ['cpp', 'c']}
  " Simplify Doxygen documentation in C, C++, Python.
  " Use :Dox command with cursor on the function declaration would generate
  " doxygen style comments.
Plug 'vim-scripts/DoxygenToolkit.vim', {'for': ['cpp', 'c']}
  " A vim plugin that applies yapf to the current file.
Plug 'pignacio/vim-yapf-format', {'for': 'python'}
Plug 'klen/python-mode', {'for': 'python'}
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'fatih/vim-go', {'for': 'go'}

call plug#end()

"""" colorscheme
"" not fully understood
set background=dark
colorscheme desertEx
highlight Normal ctermbg=none
set t_Co=256

"""" vim-easymotion settings
"" disable default mapping first
let g:EasyMotion_do_mapping=0
"" map easymotion prefix to <leader>
map <leader> <plug>(easymotion-prefix)
"" turn on smart case for vim-easymotion
"" just like set ignorecase and set smartcase
let g:EasyMotion_smartcase=1
"" set f to bi-directional and over-windows search
"" need 2 char to trigger, i.e. <leader>s{char}{char}{label}
"" This is exactly what I want!
"" Give me a tag for every word, it is like vimium in Chrome now.
nmap f <plug>(easymotion-bd-w)
"" jk motions, use when in easymotion mode
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymotion-k)
"" use easymotion for incremental search
map / <Plug>(easymotion-sn)
"" should be used together with the map above, but not sure what it is.
" omap / <Plug>(easymotion-tn)
"" Set easymotion to shade text for search.
let g:EasyMotion_do_shade=1

"""" vim-sneak settings
" follow generic settings for the case-sensitivity
let g:sneak#use_ic_scs=1

"""" syntastic settings
"" populate location list
let g:syntastic_always_populate_loc_list=1

"""" vim-indent-guide settings
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
"" color of indent strips
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=red ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=darkgrey

"""" NerdTree settings
"" Toggle folder tree split
map <leader>ne :NERDTree<CR>

"""" NerdCommenter settings
"" Add a blank space before commented content
let g:NERDSpaceDelims=1

"""" tagbar settings
"" use <F8> to toggle
nnoremap <F8> :TagbarToggle<CR>

"""" ctrlp settings
"" Use <leader>f to trigger fuzzy buffer search of CtrlP
nnoremap F :CtrlPLine<CR>

"################################
"####### generic settings #######
"################################

"" Rational way to move between splits
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"" Use * in visual mode to search selected word
vnoremap * y/<C-R>"<CR>

"" enable mouse
if has('mouse')
  set mouse=a
endif

"" how many lines of history VIM should remember
set history=1000

"" Rational backspace
set backspace=indent,eol,start

"" show line number
set nu

"" show me a bar at col 80
set colorcolumn=80

"" incremental search and highlight search result
set incsearch
set hlsearch

"" if /<lower case>, return both upper case and lower case results.
"" if /<upper case>, only return upper case results.
set ignorecase
set smartcase

"" Enable the autocompletion little menu
set wildmenu
set wildmode=longest:full,full

"" show match parenthesis
set showmatch

"" show title in terminal
set title

"" set highlight on the current line
set cursorline
hi CursorLine term=bold cterm=bold gui=bold ctermbg=237

"" Move vertically by visual line
noremap j gj
noremap k gk

"" At least 15 lines before and after cursor
set scrolloff=15

"" Use system clipboard with 'intuitive' keys
"" These maps work in visual and insert mode, so I
"" don't need to worry about conflicts.
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

"" keep search result at the center
nnoremap n nzz
nnoremap N Nzz

"" Wrap paragraphs with Q
map Q gq

"" To make undo work correctly
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

"" Sets the copy paste buffer large enough
set viminfo-='20,<9000,s9000

"" Sets the split to be open at below or right
set splitbelow
set splitright

"" Shift+Tab to switch to previous buffer, and Tab to the next buffer
nnoremap <s-tab> :bprevious<CR>
nnoremap  <tab> :bnext<CR>

