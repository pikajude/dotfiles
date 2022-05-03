" vi: set ft=viml

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'Raimondi/delimitMate'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'LnL7/vim-nix'
Plug 'neovimhaskell/haskell-vim'
call plug#end()

let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'active': {
    \   'left': [ ['mode', 'paste'],
    \             ['fugitive', 'readonly', 'filename', 'modified'] ],
    \   'right': [ ['lineinfo'],
    \              ['percent'],
    \              ['fileformat', 'fileencoding', 'filetype'] ]
    \ },
    \ 'component': {
    \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒 ":""}',
    \   'modified': '%{&filetype=="help"?"":&modified?"✎ ":&modifiable?"":"-"}',
    \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
    \ },
    \ 'component_visible_condition': {
    \   'readonly': '(&filetype!="help"&& &readonly)',
    \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
    \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
    \ }
    \ }

let mapleader = ','

syntax enable
colorscheme solarized
set background=dark t_Co=256
set number shiftwidth=2 tabstop=2 textwidth=90 colorcolumn=90
set formatoptions+=t expandtab showcmd list
set listchars=tab:▸\ ,eol:\ ,trail:‗
set fillchars+=vert:\ 
set dir=~/.vim/swap//,/var/tmp//,/tmp//,.
set foldmethod=indent

set hlsearch incsearch ignorecase smartcase
nnoremap <leader><space> :noh<cr>

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ $*
set grepformat=%f:%l:%c:%m,%f:%l:%m

augroup myvimrc
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

nnoremap <leader>s :silent grep!<space><C-r><C-w><cr>
nnoremap <leader>a :silent grep!<space>

nnoremap <C-c> <esc>

nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-x> <C-w><C-c>

set clipboard=unnamed

nnoremap <silent> ; :<c-u>CtrlP<cr>
inoremap zz <esc>:w<cr>
nnoremap zz :w<cr>

au BufEnter *.rs set ft=rust shiftwidth=2
au BufEnter *.nix set smartindent ft=nix
au BufEnter *.hs set shiftwidth=2
au BufEnter *.scss set shiftwidth=2

let g:flow#enable = 0

" ctrlp
let g:ctrlp_extensions = ['tag']
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/](dist|vendor\/Pluginr\?|\.git)$',
      \ 'file': '\v\.o$',
      \ }
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard'],
    \ 2: ['.hg', 'hg --cwd %s locate -f -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

" delimitMate
set bs=2
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" lightline
set laststatus=2

" nerdtree
map <C-n> :NERDTreeToggle<cr>
map <leader>nn :NERDTreeFind<cr>

hi Normal ctermbg=none

au Filetype * if getfsize(@%) > 1000000 | setlocal syntax=OFF | endif
