" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim', { 'build': { 'mac' : 'make -f make_mac.mak'  } }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'jsx/jsx.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'fatih/vim-go'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'bling/vim-airline'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'scrooloose/nerdtree'

call neobundle#end()

" Required:

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

let mapleader=","

filetype plugin indent on
syntax enable
color railscasts

set timeoutlen=100 ttimeoutlen=0
set backupdir=/tmp
set directory=/tmp
set ignorecase
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
set colorcolumn=80
set splitright
set incsearch
set foldmethod=marker
set pastetoggle=<f2>

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

inoremap jj <Esc>
inoremap kk <Esc>
inoremap jk <Esc>
inoremap kj <Esc>
inoremap <Tab> <C-R>=CleverTab()<CR>

nnoremap <F4> :Kwbd<CR>
nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <silent> <F8> mmgg=G'm^

nnoremap <F6> <C-W>w
nnoremap <S-F6> <C-W>W

nnoremap <silent>` :Errors<CR>
nnoremap <leader><leader> :
nnoremap <silent><leader>q :q<cr>
nnoremap <silent><leader>w :w<cr>
nnoremap <silent><leader>r :redraw!<CR>

nnoremap <silent><leader>v <C-w>v<C-w>l
nnoremap <silent><leader>s <C-w>v<C-w>j

cabbrev ! VimProcBang
nnoremap <leader>1 :VimProcBang

vmap <leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

"unite

let g:unite_source_history_yank_enable = 1
let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'

nnoremap <leader>d :Unite -start-insert line<cr>
nnoremap <leader>f :<C-u>Unite -no-split file_rec/async:!<CR>
nnoremap <space>/ :Unite grep:.<cr>
nnoremap <space>y :Unite history/yank<cr>
nnoremap <space>s :Unite -quick-match buffer<cr>

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  nmap <silent><buffer> <esc> <Plug>(unite_exit)
endfunction

"syntastic

let g:syntastic_enable_signs=1
let g:syntastic_objc_config_file = ".clang_complete"

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" YouCompleteMe

let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

" vim-fugitive
nnoremap <silent><leader>b :Gblame<cr>
nnoremap <silent><leader>a :Gwrite<CR>
nnoremap <silent><leader>o :Gread<CR>
"nnoremap <silent><leader>s :Gstatus<CR>
nnoremap <silent><leader>c :Gcommit<CR>

" NerdTREE

"noremap <silent><leader><tab> :NERDTreeToggle<CR>
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"autocmd vimenter * if !argc() | NERDTree | endif

" Tabular
if exists(":Tabularize")
  nmap <Leader>= :Tabularize /=<CR>
  vmap <Leader>= :Tabularize /=<CR>
  nmap <Leader>; :Tabularize /:\zs<CR>
  vmap <Leader>; :Tabularize /:\zs<CR>
endif
