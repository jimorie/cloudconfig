" Vundle setup first!

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins!
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'hdima/python-syntax'
Plugin 'junegunn/vim-easy-align'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'chriskempson/base16-vim'
Plugin 'vim-scripts/xoria256.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



" Copied settings from Korp =)
set nobackup
set hidden
set noswapfile
set wildignore=*.pyc
set foldmethod=indent
set foldnestmax=2
set foldlevel=99

set tabstop=4 expandtab shiftwidth=4 softtabstop=4 autoindent smartindent

autocmd FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 autoindent smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with omnifunc=pythoncomplete#Complete
autocmd FileType php setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 autoindent smartindent omnifunc=phpomplete#Complete
autocmd FileType sh setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 autoindent smartindent omnifunc=phpomplete#Complete
autocmd FileType cucumber setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4
"autocmd BufRead,BufNewFile *pl,*.py setlocal filetype=python
"autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost,Syntax * SpaceHi
"autocmd FileType help NoSpaceHi
"autocmd BufRead,BufNewFile *php,*.module,*.test setlocal filetype=php



" Status line stuff
set laststatus=2  " Always display the status line
set ruler         " show the cursor position all the time
set number

" Make it obvious where 80 characters is
"set textwidth=80
"set colorcolumn=+1

" Color scheme

syntax on
set t_Co=256
color xoria256
"color base16-default-dark
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

" Python syntax

let python_highlight_all = 1



" Lightline

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

"let g:tagbar_status_func = 'TagbarStatusFunc'
"
"function! TagbarStatusFunc(current, sort, fname, ...) abort
"    let g:lightline.fname = a:fname
"  return lightline#statusline(0)
"endfunction

"augroup AutoSyntastic
"  autocmd!
"  autocmd BufWritePost *.c,*.cpp call s:syntastic()
"augroup END
"function! s:syntastic()
"  SyntasticCheck
"  call lightline#update()
"endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

""" CtrlP settings from Korp

let g:ctrlp_max_height = 71
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_lazy_update = 10

""" CTAGS

let mapleader = ' '

nnoremap <leader>j :call JumpToTag(0)<CR>

function! JumpToTag(preview)
    let ic = &ic
    set noic
    if a:preview
        let jump_command = 'ptjump ' . expand('<cword>')
    else
        let jump_command = 'tjump ' . expand('<cword>')
    endif
    try
        if &filetype == 'behave'
            execute 'BehaveJump'
        else
            execute jump_command
        endif
    catch /tag not found/
        try
            let first_exception = v:exception
            execute jump_command . '.py'
        catch /tag not found/
            echohl WarningMsg
            echom first_exception
            echohl None
        endtry
    finally
        let &ic = ic
    endtry
endfunction



""" Personal key bindings

" WASD style movement
noremap i <Up>
noremap j <Left>
noremap k <Down>
noremap l <Right>
noremap h i
noremap H I

" Above works better with a short keystroke timeout

" Let us wrap around line endings
set whichwrap+=<,>,h,l,[,]

" Page up and page down with CTRL modifier
noremap <C-i> 5<Up>
noremap <C-k> 5<Down>

" Move to top or bottom of screen
noremap <S-i> 5<C-y>
noremap <S-k> 5<C-e>h 

" Move by words with CTRL modifier
noremap <C-j> b
noremap <C-l> e

" Start and end of line with SHIFT modifier
noremap <S-l> $
noremap <S-j> ^

" Window navigation
noremap <C-w>i <C-w>k
noremap <C-w><C-i> <C-w>k
noremap <C-w>j <C-w>h
noremap <C-w><C-j> <C-w>h
noremap <C-w>k <C-w>j
noremap <C-w><C-k> <C-w>j
noremap <C-w><C-l> <C-w>l

" Delete without yanking
noremap <leader>d "_d

" Replace selected text without yanking it
vnoremap <leader>p "_dP

" CtrlP extras
noremap <C-b> :CtrlPBuffer<CR>

" Search
noremap <C-f> /
nnoremap <leader>f :xa<cr>

" Redo on same key
noremap <C-u> <C-r>

" Ctrl-C ftw
noremap <silent> <C-c> <Esc>:noh<CR>

" Colon is hard
noremap <CR> :

" Goto the next occurence of a just deleted text 
noremap <silent> - :exe '/' . @-<CR>n

" Repeat last change and go to next occurence
noremap _ .n

" Mode shortcuts
"nmap \l :setlocal number!<CR>
"nmap \o :set paste!<CR>

" Search for current selection
vnoremap // y/<C-R>"<CR>

" Backspace everything
set backspace=indent,eol,start

" Highlight search
set hlsearch

" Keep 3 lines below and above the cursor
set scrolloff=10
