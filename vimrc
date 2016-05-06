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

NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'terryma/vim-multiple-cursors'

NeoBundleLazy 'pangloss/vim-javascript', {'autoload':{'filetypes':['javascript']}}
NeoBundleLazy 'tadeuzagallo/vim-jsx', {'autoload':{'filetypes':['javascript']}}
NeoBundleLazy '1995eaton/vim-better-javascript-completion', {'autoload':{'filetypes':['javascript']}}
NeoBundleLazy 'moll/vim-node', {'autoload':{'filetypes':['javascript']}}
NeoBundleLazy 'octol/vim-cpp-enhanced-highlight', {'autoload':{'filetypes':['cpp']}}

NeoBundle 'kien/ctrlp.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'rdnetto/YCM-Generator'
NeoBundle 'bling/vim-airline'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-surround'
NeoBundle "gilligan/vim-lldb"
NeoBundle 'rizzatti/dash.vim'
NeoBundle 'zenorocha/dracula-theme', { 'rtp': 'vim/' }

NeoBundleLazy 'b4winckler/vim-objc', {'autoload':{'filetypes':['objc']}}
NeoBundleLazy 'eraserhd/vim-ios.git', {'autoload':{'filetypes':['objc']}}

NeoBundle 'neovimhaskell/haskell-vim'

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

colorscheme dracula

set mouse=a
set clipboard=unnamed
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
set splitbelow
set incsearch
set foldmethod=marker
set pastetoggle=<f2>
set wildignore+=*.o,*.a,*.obj,*/.git/*,*/node_modules/*,*.class,*.zip,*.aux

" spell check
set spell spelllang=en_us
hi clear SpellBad
hi clear SpellCap
hi clear SpellLocal
hi clear SpellRare
hi SpellBad cterm=underline
function! Trim()
  let lnum = line('.')
  let cnum = col('.')
  exe ':%s/\s\+$//e'
  exe 'normal ' . lnum . 'G'
  exe 'normal ' . cnum . '|'
endfunction

nnoremap <silent><leader><leader>t :call Trim()<CR>

inoremap jk <Esc>

nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <silent> <F8> mmgg=G'm^

" pane splitting shortcuts
nnoremap <silent><leader>v :vnew<cr>
nnoremap <silent><leader>s :new<cr>
nnoremap <silent><leader>q :q<cr>
nnoremap <silent><leader>w :w<cr>
nnoremap <silent><leader>r :redraw!<CR>

" tabs shortcuts
nnoremap <silent><leader>t :tabnew<cr>
nmap <silent><C-}> :tabnext<cr>
nmap <silent><C-{> :tabprev<cr>
nnoremap <silent><leader>c :tabclose<cr>
nnoremap <silent><leader>1 :tabnext 1<cr>
nnoremap <silent><leader>2 :tabnext 2<cr>
nnoremap <silent><leader>3 :tabnext 3<cr>
nnoremap <silent><leader>4 :tabnext 4<cr>
nnoremap <silent><leader>5 :tabnext 5<cr>
nnoremap <silent><leader>6 :tabnext 6<cr>
nnoremap <silent><leader>7 :tabnext 7<cr>
nnoremap <silent><leader>8 :tabnext 8<cr>
nnoremap <silent><leader>9 :tablast <cr>

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
nnoremap <leader>f :execute 'Unite -no-split file_rec/async:'.getcwd()<CR>
nnoremap <space>/ :Unite grep:.<cr>
nnoremap <space>y :Unite history/yank<cr>
nnoremap <space>s :Unite -quick-match buffer<cr>

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  nmap <silent><buffer> <esc> <Plug>(unite_exit)
endfunction

"syntastic

let g:syntastic_enable_signs=1
"let g:syntastic_objc_config_file = ".clang_complete"
let g:syntastic_javascript_checkers = ['eslint']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

nnoremap <silent>` :Errors<CR>
nnoremap <silent><leader>` :lclose<CR>

" ctrl+p

"let g:ctrlp_by_filename=1
let g:ctrlp_regexp=0
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_match_window_reversed=0
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_prompt_mappings = {
    \ 'PrtSelectMove("j")':   ['<c-n>'],
    \ 'PrtSelectMove("k")':   ['<c-p>'],
    \ 'PrtHistory(-1)':       ['<c-j>'],
    \ 'PrtHistory(1)':        ['<c-k>']
    \}

" filetype format

autocmd BufRead,BufNewFile *.m set filetype=objc
autocmd BufRead,BufNewFile BUCK set filetype=python
autocmd FileType markdown setlocal textwidth=80 formatoptions+=t

" YouCompleteMe

let g:ycm_key_list_select_completion=['<C-n>']
let g:ycm_key_list_previous_completion=['<C-p>']

" Tabular
if exists(":Tabularize")
  nmap <Leader>= :Tabularize /=<CR>
  vmap <Leader>= :Tabularize /=<CR>
  nmap <Leader>; :Tabularize /:\zs<CR>
  vmap <Leader>; :Tabularize /:\zs<CR>
endif

" switch between source and header

function! Switch()
  let file = expand('%')
  let header_pattern = '\.h\(pp\)\{0,1}'
  let source_pattern = '\(\.c\(pp\)\{0,1}\|\.m\{1,2}\)$'
  if match(file, source_pattern) > 0
    let header = substitute(file, source_pattern, '.h', '')
    execute ":find " header
  elseif match(file, header_pattern) > 0
    let source = substitute(file, header_pattern, '.c', '')
    if findfile(source) == ""
      let source = substitute(file, header_pattern, '.m', '')
    endif
    if findfile(source) == ""
      let source = substitute(file, header_pattern, '.cpp', '')
    endif
    if findfile(source) == ""
      let source = substitute(file, header_pattern, '.mm', '')
    endif
    execute ":edit " findfile(source)
  endif
endfunction

nnoremap <silent><leader><tab> :call Switch()<CR>

" dash.vim

:nmap <silent> <leader>d <Plug>DashSearch

" flow-vim

let g:flow#autoclose = 1
