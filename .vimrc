".vimrc för Linux Terminal"

"Att göra innan användning"

"1. Ändra CapsLock till Esc: gå till menu->keyboard->keyboard layouts->
"   CapsLock behavior->swap Esc and CapsLock"

"2. Ladda ner vim-gnome för att använda samma clipboard"
"   sudo apt-get install -y vim-gnome

"3. För coc.nvim behövs nodejs >= 10.12 och vim >= 8.0.1453"
"   Ladda ner nodejs:"
"   sudo apt-get install curl python-software-properties"
"   curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -"
"   sudo apt-get install nodejs"

"   Senaste vim:"
"   sudo add-apt-repository ppa:jonathonf/vim"
"   sudo apt update"
"   sudo apt install vim"

"4. Ladda om .vimrc och :PlugInstall för att ladda ner plugins"

set number "Rad nummer"
set noshowmode "Fix för lightline"
set laststatus=2 "fix för lightline"
set nowrap "texten kommer inte på en ny rad om den inte syns"
set clipboard=unnamedplus "kopiera och klistra in fungerar som det ska. kontrollera: vim --version | grep clip"
set incsearch "livesearch"
set ttimeoutlen=50 "Ingen label-delay när man går från INSERT till NORMAL"

"Indrag är 4 istället för 8"
set tabstop=4
set shiftwidth=4
set expandtab

"Skapa katalogerna automatisk om de inte finns."
if !isdirectory($HOME . '/.vim/backup//')
    call mkdir($HOME . '/.vim/backup//', "p")
endif
if !isdirectory($HOME . '/.vim/swap//')
    call mkdir($HOME . '/.vim/swap//', "p")
endif
if !isdirectory($HOME . '/.vim/undo//')
    call mkdir($HOME . '/.vim/undo//', "p")
endif

"Swap, backup och undo filer hamnar i dessa kataloger, istället för samma
"katalog som filen. (//) gör att filen inte kan heta likadant."
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" commands required after installing color coded
function! BuildColor_Coded(info)
  if a:info.status != 'installed'
    !cd ~/.vim/plugged/color_coded
    !mkdir build && cd build
    !cmake ..
    !make && make install
  endif
endfunction

"Ladda ner automatiskt vim-plug"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Vim-plug: från github Plug 'namn/projekt'"
call plug#begin() 
"trädvy av filer"
Plug 'preservim/NERDTree'
"Tema"
Plug 'joshdick/onedark.vim'
"Statusbar"
Plug 'itchyny/lightline.vim'
"T.ex. vilka paranteser som hör ihop"
Plug 'tpope/vim-surround'
"Intellisense"
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'jackguo380/vim-lsp-cxx-highlight'

Plug 'jeaye/color_coded', {
    \ 'do': function('BuildColor_Coded')
    \ }
call plug#end()

"Ctrl-n för nerdtree"
map <C-n> :NERDTreeToggle<CR>

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"Dölj end-of-buffer filler lines (~)"
let g:onedark_hide_endofbuffer = 1

"lightline onedark theme"
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

"syntax i språk"
syntax on
"Atom One Dark UI"
colorscheme onedark
