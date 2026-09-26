let mapleader = " "
let maplocalleader = " "

set nocompatible
set number
set relativenumber
set cursorline
set signcolumn=yes
set mouse=a
set hidden

if exists('+termguicolors')
  set termguicolors
endif

if has('clipboard')
  set clipboard=unnamedplus
endif

call mkdir(expand('~/.vim/swap'), 'p')
call mkdir(expand('~/.vim/undo'), 'p')

execute 'set directory^=' . fnameescape(expand('~/.vim/swap')) . '//'
execute 'set undodir=' . fnameescape(expand('~/.vim/undo'))

set swapfile
set undofile
set nobackup
set nowritebackup

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set smartindent

set ignorecase
set smartcase
set incsearch
set hlsearch
set completeopt=menu,menuone,noselect,noinsert

set backspace=indent,eol,start
set timeoutlen=500
set updatetime=300

set nowrap
set scrolloff=8
set sidescrolloff=8
set splitbelow
set splitright
set wildmenu
set wildmode=longest:full,full

colorscheme habamax

let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_browse_split = 4

nnoremap <leader>w :write<CR>
nnoremap <leader>q :quit<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>h :nohlsearch<CR>

nnoremap <leader>s :split<CR>
nnoremap <leader>v :vsplit<CR>

nnoremap <leader>S :%s//g<Left><Left>
xnoremap <leader>S :s//g<Left><Left>

nnoremap <leader>e :Lexplore<CR>
nnoremap <C-n> :Lexplore<CR>

inoremap jk <Esc>

let g:terminal_buf = -1
let g:terminal_win = -1

function! ToggleTerminal(vertical) abort
  if g:terminal_win != -1 && win_id2win(g:terminal_win)
    call win_gotoid(g:terminal_win)
    close
    let g:terminal_win = -1
    return
  endif

  let g:terminal_win = -1

  if a:vertical
    botright vertical new
  else
    botright new
    resize 12
  endif

  let g:terminal_win = win_getid()

  if g:terminal_buf != -1 && bufexists(g:terminal_buf)
    execute 'buffer ' . g:terminal_buf
  else
    terminal
    let g:terminal_buf = bufnr('%')
    setlocal bufhidden=hide
    setlocal nobuflisted
    setlocal noswapfile
  endif

  startinsert
endfunction

tnoremap <Esc> <C-\><C-n>

nnoremap <leader>t :call ToggleTerminal(0)<CR>
nnoremap <leader>vt :call ToggleTerminal(1)<CR>

augroup terminal_cleanup
  autocmd!
  autocmd BufWipeout *
        \ if bufnr('%') == g:terminal_buf |
        \ let g:terminal_buf = -1 |
        \ let g:terminal_win = -1 |
        \ endif
augroup END

augroup restore_cursor_position
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 1 &&
        \ line("'\"") <= line("$") &&
        \ &filetype !=# "commit" &&
        \ index(["xxd", "gitrebase"], &filetype) == -1 |
        \ execute "normal! g`\"" |
        \ endif
augroup END

augroup english_spell_checking
  autocmd!
  autocmd FileType markdown,text,gitcommit
        \ setlocal spell spelllang=en
augroup END

augroup open_directory_in_netrw
  autocmd!
  autocmd VimEnter *
        \ if argc() == 1 && isdirectory(argv(0)) |
        \ execute 'cd ' . fnameescape(argv(0)) |
        \ Lexplore |
        \ endif
augroup END
