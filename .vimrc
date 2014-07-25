set nocompatible

set background=dark
set scrolloff=10
colorscheme grb256


execute pathogen#infect()

syntax on
filetype plugin indent on
set tabstop=2
set softtabstop=2
set shiftwidth=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
set expandtab
let mapleader=","
let g:buffergator_suppress_keymaps=1

noremap <leader>b :BuffergatorToggle<cr>

noremap <leader>rf :call RenameFile()<cr>
noremap <leader>n :NERDTreeToggle<cr>

map <leader>r :NERDTreeFind<cr>

" Make ,w split window vertically then focus on new window
nnoremap <leader>w <C-w>v<C-w>l

" Make ,e split window horizontally then focus on new window
nnoremap <leader>e <C-w>s<C-w>j

autocmd BufEnter * :call OnEnterBuffer()

function! OnEnterBuffer()
  :call EnableRelativeNumber()
  :call SetBuffergatorSettings()
endfunction

function! SetBuffergatorSettings()
  let g:buffergator_viewport_split_policy="B"
  let g:buffergator_hsplit_size=10
endfunction

function! EnableRelativeNumber()
  " Don't do it for the NERDTree buffer
  if bufname('%') !~ 'NERD'
    set relativenumber
  endif
endfunction

" Tab autocomplete unless at beginning of line
function! InsertTabWrapper()
  let line = getline('.')                     " current line

  let substr = strpart(line, -1, col('.')+1)  " from the start of the current
                                              " line to one character right
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  endif

  return "\<C-n>"                     " existing text matching
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-p>
