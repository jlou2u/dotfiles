set t_Co=256
colorscheme darkblue
syntax on

" customize some colors
hi Normal ctermbg=NONE  " use background color from terminal
hi Visual ctermbg=0     " black instead of light text 
hi VisualNOS ctermbg=0  
hi DiffChange ctermfg=0 
hi DiffText ctermfg=0 
hi MatchParen ctermfg=0 
hi PmenuSBar ctermfg=0 
hi Ignore ctermfg=236

noremap ; :
noremap : ;

set nocompatible              " be iMproved, required
filetype off                  " required
set laststatus=2
set showmatch
set hls
set number
set ruler
set directory=~/.vimtmp
set backupdir=~/.vimbackup
set backup

"set statusline=%F       "tail of the filename
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}] "file format
"set statusline+=%h      "help file flag
"set statusline+=%m      "modified flag
"set statusline+=%r      "read only flag
"set statusline+=%y      "filetype
"set statusline+=%=      "left/right separator
"set statusline+=%c,     "cursor column
"set statusline+=%l/%L   "cursor line/total lines
"set statusline+=\ %P    "percent through file

set rtp+=/usr/local/opt/fzf

set shortmess+=r
set showmode
set showcmd
set listchars=eol:$
set nowrap

set shiftwidth=4
set tabstop=4
set shiftround
set expandtab
set autoindent
set ignorecase
set smartcase
set incsearch
set backspace=2

hi ColorColumn ctermbg=DarkBlue
au FileType python setlocal colorcolumn=80 expandtab

map N Nzz
map n nzz

" remove trailing whitespace with F5 key
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

set shell=/bin/bash

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'junegunn/fzf.vim'
Plugin 'VundleVim/Vundle.vim'
Plugin 'nvie/vim-flake8'
Plugin 'mileszs/ack.vim'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'airblade/vim-gitgutter'
call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
