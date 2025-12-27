" --- UI & Visuals ---
set number relativenumber
set scrolloff=8
set list            " Show hidden characters (tabs, trailing spaces)
set listchars=tab:→\ ,trail:· " Customize how hidden chars look
syntax on

" --- Search ---
set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <leader><space> :nohlsearch<CR>

" --- Indentation ---
set expandtab
set shiftwidth=4
set softtabstop=4
set smartindent
filetype plugin indent on

" --- System ---
set clipboard+=unnamedplus
