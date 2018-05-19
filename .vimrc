syntax enable 

colorscheme Tomorrow-Night   
set t_Co=256		   
set term=rxvt-unicode-256color

set mouse=a    " enable the mouse
set number     " show linenumbers
set cursorline " highlight current line
set showmatch  " highlight matching [{()}]
set clipboard=unnamedplus " use X clipboard

" searching
set hlsearch   " highlight all search results
set incsearch  " search as we type
set ignorecase " case-insensitive search
set smartcase  " uppercase causes case-sensitive search

" custom status line
set statusline=\ \%f%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\ "

cmap w!! w !sudo tee % > /dev/null
