let mapleader=","

set encoding=utf-8
cmap w!! %!sudo tee > /dev/null %
let g:Powerline_symbols = 'fancy'

set rtp+=~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim

call pathogen#infect()
call pathogen#helptags()

set clipboard+=unnamed
set ic
set ai

filetype plugin indent on
syntax enable
color railscasts

set nocompatible
set expandtab
set smarttab
set smartindent
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2

set number
set cursorline
set linespace=4
set laststatus=2
set colorcolumn=81

set pastetoggle=<f2>
nnoremap <F4> :Kwbd<CR>
nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <silent> <F8> mmgg=G'm^

function! CleverTab()
  if pumvisible()
    return "\<C-N>"
  endif
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
  else
    return "\<C-N>"
  endif
endfunction

function! OmniComplete()
  if exists('&omnifunc') && &omnifunc != ''
    return "\<C-X>\<C-O>"
  endif
endfunction

inoremap jk <Esc>
inoremap <Nul> <C-R>=CleverTab()<CR>

" FROM https://github.com/jgoulah/dotfiles/blob/master/vimrc#L178

" ,w to open a split window and switch to it
nnoremap <leader>w <C-w>v<C-w>l
" use <F6> to cycle through split windows
nnoremap <F6> <C-W>w
" <Shift>+<F6> to cycle backwards
nnoremap <S-F6> <C-W>W

" remap leader to comma 
let mapleader=","

" map jj to escape key
inoremap jj <ESC>

vmap  o  :call NERDComment(1, 'toggle')<CR>
vmap  O  :call NERDComment(1, 'toggle')<CR>

vmap <leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
nnoremap <leader>f :CtrlP<cr>

" vim-ios
nnoremap <leader>s :A<CR>
nnoremap <leader>j :R<CR>

"syntastic

let g:syntastic_enable_signs=1

let g:syntastic_objc_config_file = ".clang_complete"

set statusline+=%#warningmsg# 
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
nnoremap <silent>` :Errors<CR>


" cocoa.vim

nnoremap <silent> <leader>l :ListMethods<CR>
