if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'folke/tokyonight.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()

" Basic
set mouse:a noswf nu rnu ls=0 shm=aIFWc tgc ts=2 sw=2 sts=2 et nofen fenc=utf-8 cb+=unnamedplus ut=300
set wig+=*/.git,*/node_modules,*/venv,*/tmp,*.so,*.swp,*.zip,*.pyc
set list lcs=tab:··,trail:·

" Theme Configs
colo tokyonight

" Bold and italic in tmux
set t_ZH=[3m
set t_ZR=[23m

hi Comment cterm=italic gui=italic

" Leader
let g:mapleader = ','

" Write and quit
nn <Leader>q :q<CR>
nn <Leader>w :w<CR>
nn <Leader>ws :noa w<CR>
nn <Leader>wa :wa<CR>

" Git
nn <silent> <Leader>gs :Git<CR>
nn <silent> <Leader>gp :Git push<CR>
nn <silent> <Leader>gf :Git push --force<CR>
nn <silent> <Leader>gu :Git pull<CR>

" Fzf lists
nn <silent> <space>p  :<C-u>Files<CR>
nn <silent> <space>f  :<C-u>Rg<CR>
nn <silent> <space>g  :<C-u>Commits<CR>
nn <silent> <space>r  :<C-u>Repos<CR>
