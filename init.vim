call plug#begin()
Plug 'airblade/vim-gitgutter'

Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'

Plug 'gruvbox-community/gruvbox'
call plug#end()

set title
set ignorecase
set incsearch
set smartcase
set nohlsearch

set splitbelow splitright
set scrolloff=2
set laststatus=2

set nowrap
set shiftwidth=2
set tabstop=2 softtabstop=2

set noswapfile
set nobackup

" visual settings
set showcmd
set noshowmode
set wildmenu
set number relativenumber
set mouse=a
set cursorline
set colorcolumn=80
set signcolumn=yes

highlight Normal guibg=None
colorscheme gruvbox
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly','gitbranch', 'filename', 'modified', ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

