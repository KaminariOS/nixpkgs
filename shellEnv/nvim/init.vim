" =============================================================================
" # Editor settings
" =============================================================================
set encoding=utf-8
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line

" Sane splits
set splitright
set splitbelow

set cursorline
set noswapfile
set shell=fish
" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

set clipboard+=unnamedplus
set autoread
set autowriteall
set undofile
set undodir=~/.config/nvim
augroup jump_last_position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
augroup END

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set ignorecase              " case insensitive
set smartcase
set mouse=v                 " middle-click paste with
set hlsearch                " highlight search
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
"set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
" set spell                 " enable spell check (may need to download language package)
set relativenumber
set visualbell
map <C-c> <Esc>

if has('ide')
    let mapleader=" "

    """ Plugins
    set surround
    set multiple-cursors
    set commentary
    set argtextobj
    set easymotion
    set textobj-entire
    set ReplaceWithRegister
    set exchange
    " Trying the new syntax
Plug 'machakann/vim-highlightedyank'
  " mappings and options that exist only in IdeaVim
  map <leader>f <Action>(GotoFile)
  map <leader>g <Action>(FindInPath)
  map <leader>b <Action>(Switcher)

  """ IdeaVim options
  " Smart join for <C-J>
  set ideajoin
  " Map vim marks to IDEA global marks
  set ideamarks

   set clipboard+=ideaput
  if &ide =~? 'intellij idea'
    if &ide =~? 'community'
      " some mappings and options for IntelliJ IDEA Community Edition
    elseif &ide =~? 'ultimate'
      " some mappings and options for IntelliJ IDEA Ultimate Edition
    endif
  elseif &ide =~? 'pycharm'
    " PyCharm specific mappings and options
  endif
else
  " some mappings for Vim/Neovim
  nnoremap <leader>f <cmd>Telescope find_files<cr>
  nnoremap <leader><leader> <cmd>bn<cr>
endif

" Ctrl+j and Ctrl+k as Esc
" Ctrl-j is a little awkward unfortunately:
" https://github.com/neovim/neovim/issues/5916
" So we also map Ctrl+k
nnoremap <C-j> <Esc>
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
snoremap <C-j> <Esc>
xnoremap <C-j> <Esc>
cnoremap <C-j> <C-c>
onoremap <C-j> <Esc>
lnoremap <C-j> <Esc>
tnoremap <C-j> <Esc>

nnoremap <S-j> <Esc>
inoremap <S-j> <Esc>
vnoremap <S-j> <Esc>
snoremap <S-j> <Esc>
xnoremap <S-j> <Esc>
cnoremap <S-j> <C-c>
onoremap <S-j> <Esc>
lnoremap <S-j> <Esc>
tnoremap <S-j> <Esc>

nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <C-c>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

tnoremap <Esc> <C-\><C-n>

" https://stackoverflow.com/questions/16134457/insert-a-newline-without-entering-in-insert-mode-vim
nmap oo o<Esc>k 
nmap OO O<Esc>j


" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

luafile ~/.config/nvim/config.lua
