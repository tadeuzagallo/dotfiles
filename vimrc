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
NeoBundle 'mxw/vim-jsx'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'fatih/vim-go'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'bling/vim-airline'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'wavded/vim-stylus'
NeoBundle 'Rip-Rip/clang_complete'

NeoBundleLazy 'b4winckler/vim-objc', {'autoload':{'filetypes':['objc']}}
NeoBundleLazy 'eraserhd/vim-ios.git', {'autoload':{'filetypes':['objc']}}

call neobundle#end()

" Required:

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

let mapleader=","
let g:airline_powerline_fonts = 1
let g:jsx_ext_required = 0

filetype plugin indent on

syntax enable

let g:solarized_termcolors = 16
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
source ~/dotfiles/solarized/vim-colors-solarized/colors/solarized.vim

set noshowmode
set backspace=indent,eol,start
set timeoutlen=1000 ttimeoutlen=0
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
set wildignore+=*.o,*.obj,.git,node_modules,_site,*.class,*.zip,*.aux

inoremap jk <Esc>
inoremap kj <Esc>

nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <silent> <F8> mmgg=G'm^

nnoremap <F6> <C-W>w
nnoremap <S-F6> <C-W>W

nnoremap <silent>` :Errors<CR>
nnoremap <leader><leader> :
nnoremap <silent><leader>q :q<cr>
nnoremap <silent><leader>w :w<cr>
nnoremap <silent><leader>r :redraw!<CR>

" pane navigation

function! Navigate(direction)
  let nr = winnr()
  exec 'wincmd ' . a:direction

  if nr == winnr()
    let nr = tabpagenr()

    if a:direction == 'h' && nr > 1
      exec 'tabprevious'
    elseif a:direction == 'l' && tabpagewinnr(nr + 1) > 0
      exec 'tabnext'
    endif

    if nr == tabpagenr()
      let cmd = 'tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR')
      call system(cmd)
    endif
  endif
endfunction

nnoremap <silent><C-h> :call Navigate('h')<CR>
nnoremap <silent><C-l> :call Navigate('l')<CR>
nnoremap <silent><C-k> :call Navigate('k')<CR>
nnoremap <silent><C-j> :call Navigate('j')<CR>

"unite

let g:unite_source_history_yank_enable = 1
let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
let g:unite_source_grep_command = 'ag --nocolor --nogroup'

nnoremap <leader>d :Unite -start-insert line<cr>
nnoremap <leader>f :<C-u>Unite -no-split file_rec/async:!<CR>
nnoremap <space>/ :Unite grep:.<cr>
nnoremap <space>y :Unite history/yank<cr>
nnoremap <space>s :Unite -quick-match buffer<cr>

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  nmap <silent><buffer> <esc> <Plug>(unite_exit)
endfunction
"
"syntastic

let g:syntastic_enable_signs=1
let g:syntastic_objc_config_file = ".clang_complete"
let g:syntastic_javascript_checkers = ['jsxhint']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" YouCompleteMe

let g:ycm_key_list_select_completion=['<C-n>']
let g:ycm_key_list_previous_completion=['<C-p>']

" vim-fugitive

nnoremap <silent><leader>b :Gblame<cr>
nnoremap <silent><leader>a :Gwrite<CR>
nnoremap <silent><leader>o :Gread<CR>
"nnoremap <silent><leader>s :Gstatus<CR>
nnoremap <silent><leader>c :Gcommit<CR>

" NerdTREE

noremap <silent><leader><tab> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"autocmd vimenter * if !argc() | NERDTree | endif

" Tabular
if exists(":Tabularize")
  nmap <Leader>= :Tabularize /=<CR>
  vmap <Leader>= :Tabularize /=<CR>
  nmap <Leader>; :Tabularize /:\zs<CR>
  vmap <Leader>; :Tabularize /:\zs<CR>
endif

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
    if part[0] =~ '\v[%#<]'
      let expanded_part = fnameescape(expand(part))
      let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
    endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction
