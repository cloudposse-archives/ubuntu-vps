" Great VIMRC resource http://eseth.org/filez/prefs/vimrc

let php_sql_query=1
let php_htmlInStrings=1
let php_folding=1

syntax enable
set expandtab
set tabstop=2
set shiftwidth=2        " display \t as 2 spaces
set softtabstop=2       " makes spaces feel like real tabs
set smarttab            " insert blank space at the beginning of the line with tab
set autoindent
set backspace=eol,indent,start
set cindent

" Prevent # from causing leading whitespace from getting removed
set cinkeys-=0#
set indentkeys-=0#

set hls
set showmatch           " sm:    flashes matching brackets or parentheses
"set foldclose=all
set foldenable
set foldmethod=indent
set foldlevel=1000
set viminfo='10,\"100,:20,%,n~/.viminfo 

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 
au BufNewFile,BufRead *.thtml setfiletype php
au BufNewFile,BufRead *.ctp setfiletype php

set cursorline                  "cul:   highlights the current line
"set number                      "nu:    numbers lines
set ttyfast                     "tf:    improves redrawing for newer computers
set showmode                    "smd:   shows current vi mode in lower left
set viminfo='500,f1,:100,/100   "vi:    For a nice, huuuuuge viminfo file

set pastetoggle=<F7>            "pt:    useful so auto-indenting doesn't mess up code when pasting
" Toggle spell-checking with F8
map <silent> <F8> :set nospell!<CR>:set nospell?<CR>

fun! ToggleFold() 
  if foldlevel('.') == 0 
    normal! l 
  else 
    if foldclosed('.') < 0 
      . foldclose 
    else 
      . foldopen 
    endif 
  endif 
  " Clear status line 
 echo 
endfun 

" Map this function to Space key. 
noremap <space> :call ToggleFold()<CR> 


set incsearch                   "is:    automatically begins searching as you type
set ignorecase                  "ic:    ignores case when pattern matching
set smartcase                   "scs:   ignores ignorecase when pattern contains uppercase ch
set hlsearch                    "hls:   highlights search results
" Use ctrl-n to unhighlight search results in normal mode:
nmap <silent> <C-N> :silent noh<CR>


map <Tab>qq <Esc>:w<Enter>
hi IncSearch    cterm=none ctermbg=blue ctermfg=grey guifg=slategrey guibg=khaki
"hi LineNr
hi Search   ctermbg=blue ctermfg=grey guibg=peru guifg=wheat
hi Comment  ctermfg=lightblue guifg=SkyBlue
"hi Constant     ctermfg=darkcyan guifg=#ffa0a0
"hi Identifier   ctermfg=darkgreen cterm=none guifg=palegreen
hi Statement    ctermfg=brown guifg=khaki
hi PreProc  ctermfg=darkmagenta guifg=indianred
hi Type     ctermfg=darkgreen guifg=darkkhaki
hi Special  ctermfg=darkmagenta guifg=navajowhite
"hi Underlined  
hi Ignore   guifg=grey40
"hi Error       
hi Todo     ctermfg=darkred ctermbg=yellow guifg=orangered guibg=yellow2

augroup encrypted
  au!
  " Disable swap files, and set binary file format before reading the file
  autocmd BufReadPre,FileReadPre *.gpg
    \ setlocal noswapfile bin
  " Decrypt the contents after reading the file, reset binary file format
  " and run any BufReadPost autocmds matching the file name without the .gpg
  " extension
  autocmd BufReadPost,FileReadPost *.gpg
    \ execute "'[,']!gpg --decrypt --default-recipient-self" |
    \ setlocal nobin |
    \ execute "doautocmd BufReadPost " . expand("%:r")
  " Set binary file format and encrypt the contents before writing the file
  autocmd BufWritePre,FileWritePre *.gpg
    \ setlocal bin |
    \ '[,']!gpg --encrypt --default-recipient-self                                                                                                                                                                                        
  " After writing the file, do an :undo to revert the encryption in the
  " buffer, and reset binary file format
  autocmd BufWritePost,FileWritePost *.gpg
    \ silent u |
    \ setlocal nobin
augroup END


