
set nocompatible
colorscheme darkblue

hi Normal ctermbg=NONE  " use background color from terminal
hi Visual ctermbg=0     " black instead of light text 
hi VisualNOS ctermbg=0  
hi DiffChange ctermfg=0 
hi DiffText ctermfg=0 
hi MatchParen ctermfg=0 
hi PmenuSBar ctermfg=0 
hi Ignore ctermfg=236
hi ColorColumn ctermbg=DarkBlue

noremap ; :
noremap : ;

map N Nzz
map n nzz


set laststatus=2
set showmatch
set hls
set number
set ruler
set directory=~/.vimtmp
set backupdir=~/.vimbackup
set backup

set shortmess+=r
set showmode
set showcmd
set listchars=eol:$
set nowrap
set expandtab
set incsearch
" set rtp+=~/.nix-profile/bin/fzf

nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

let g:pymode_python = 'python3'

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
set laststatus=2               " enable airline even if no splits
  "let g:airline_theme='luna'
  let g:airline_theme='papercolor'
  let g:airline_powerline_fonts=1
  let g:airline_enable_branch=1
  let g:airline_enable_syntastic=0
  let g:airline#extensions#ale#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline_linecolumn_prefix = '␊ '
  let g:airline_linecolumn_prefix = '␤ '
  let g:airline_linecolumn_prefix = '¶ '
  let g:airline_branch_prefix = '⎇ '
  let g:airline_paste_symbol = 'ρ'
  let g:airline_paste_symbol = 'Þ'
  let g:airline_paste_symbol = '∥'
  let g:airline#extensions#tabline#enabled = 0
  let g:airline_mode_map = {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'REPLACE',
        \ 'v' : 'VISUAL',
        \ 'V' : 'V-LINE',
        \ 'c' : 'CMD   ',
        \ '': 'V-BLCK',
        \ }
  Plug 'chriskempson/base16-vim' " base16 theme
  Plug 'dandorman/vim-colors'
  Plug 'KKPMW/moonshine-vim'
  Plug 'junegunn/seoul256.vim'
  Plug 'rakr/vim-one'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'rafi/awesome-vim-colorschemes'

  Plug 'nvie/vim-flake8'
    au FileType python setlocal colorcolumn=80 expandtab
    autocmd BufWritePost *.py call Flake8()

  Plug 'airblade/vim-gitgutter'
  Plug '/home/jlewis/.nix-profile/bin/fzf'
  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
  Plug 'junegunn/fzf.vim'
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'ivanov/vim-ipython'

call plug#end()
