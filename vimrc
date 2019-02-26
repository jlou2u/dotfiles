
set nocompatible
" colorscheme darkblue

hi Normal ctermbg=NONE  " use background color from terminal

" only good for dark backgrounds
" hi Visual ctermbg=0     " black instead of light text
" hi VisualNOS ctermbg=0
" hi DiffChange ctermfg=0
" hi DiffText ctermfg=0
" hi MatchParen ctermfg=0
" hi PmenuSBar ctermfg=0
" hi Ignore ctermfg=236
" hi ColorColumn ctermbg=DarkBlue

" good for light backgrounds
hi DiffAdd      cterm=bold ctermfg=white ctermbg=blue gui=none guifg=bg guibg=Red
hi DiffDelete   cterm=bold ctermfg=white ctermbg=magenta gui=none guifg=bg guibg=Red
hi DiffChange   cterm=bold ctermfg=black ctermbg=gray gui=none guifg=bg guibg=Red
hi DiffText     cterm=bold ctermfg=black ctermbg=red gui=none guifg=bg guibg=Red

noremap ; :
noremap : ;

map N Nzz
map n nzz


set laststatus=2

" 2019-Feb: started to find this annoying
" set showmatch 

set hls
set number
set ruler
set directory=~/.vimtmp
set backupdir=~/.vimbackup
set backup
" set cursorline   " underlines current line

set shiftwidth=4
set tabstop=4
set colorcolumn=80

set shortmess+=r
set showmode
set showcmd
set listchars=eol:$
set nowrap
set expandtab
set incsearch
set ignorecase
" set rtp+=~/.nix-profile/bin/fzf

nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

let g:pymode_python = 'python3'

autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 tw=80
autocmd FileType perl   setlocal expandtab tabstop=3 shiftwidth=3 softtabstop=3 tw=80

""""""" Markdown
" Markdown is now included in vim, but by default .md is read as Modula-2
"   " files.  This fixes that, because I don't ever edit Modula-2 files :)
autocmd BufNewFile,BufReadPost *.md,*.markdown set filetype=markdown
autocmd FileType markdown set tw=80

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'tpope/vim-fugitive'
    let g:easytags_async = 1
    let g:easytags_by_filetype = '~/.vim/tags'
    autocmd FileType python set tags='~/.vim/tags/python'
    autocmd FileType ruby set tags='~/.vim/tags/ruby'
    autocmd FileType groovy set tags='~/.vim/tags/groovy'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
    set laststatus=2               " enable airline even if no splits
    let g:airline_theme='base16'
    " TODO: why removed?
    " let g:airline_powerline_fonts=1
    let g:airline#extensions#tabline#enabled = 1

  " TODO: why removed?
  " Plug 'chriskempson/base16-vim' " base16 theme
  " Plug 'dandorman/vim-colors'
  " Plug 'KKPMW/moonshine-vim'
  " Plug 'junegunn/seoul256.vim'
  " Plug 'rakr/vim-one'
  " Plug 'NLKNguyen/papercolor-theme'
  " Plug 'rafi/awesome-vim-colorschemes'

  Plug 'nvie/vim-flake8'
    au FileType python setlocal colorcolumn=80 expandtab
    autocmd BufWritePost *.py call Flake8()

  Plug 'airblade/vim-gitgutter'
  Plug '/home/jlewis/.nix-profile/bin/fzf'
  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
  Plug 'junegunn/fzf.vim'
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'ivanov/vim-ipython'
  Plug 'scrooloose/nerdtree'
    let g:NERDTreeDirArrowExpandable = '--'
    let g:NERDTreeDirArrowCollapsible = '\/'
    map <C-n> :NERDTreeToggle<CR>

call plug#end()
