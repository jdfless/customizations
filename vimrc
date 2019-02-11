set nocompatible
set background=dark
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE
set pastetoggle=<f5>

set tabstop=4
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set number

" have no delay when exiting visual mode
set timeoutlen=1000
set ttimeoutlen=0

" Trim trailing whitespace on save
" autocmd BufWritePre *.py :%s/\s\+$//e

" http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list:full
set wildmenu
" Use tab in insert mode to complete
imap <Tab> <C-P>

" New splits should open below/right of current buffer.
set splitbelow
set splitright

" use monokai color scheme
syntax on
colorscheme nachtleben

" Use enter and ctrl-o (to insert line above) to insert lines in normal mode w/o entering insert mode
nmap <CR> o<Esc>
nmap <C-O> O<Esc>

" Syntax for unknown filetypes
au BufRead,BufNewFile *.gvy set filetype=java
au BufRead,BufNewFile *.pp  set filetype=puppet
au BufRead,BufNewFile *.k?b set filetype=python
