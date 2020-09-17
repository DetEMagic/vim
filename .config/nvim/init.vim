"~/.config/nvim/init.vim för Linux Terminal"
"TODO  och plugins
"Att göra innan användning"

"1. Ändra CapsLock till Esc: gå till menu->keyboard->keyboard layouts->
"   CapsLock behavior->swap Esc and CapsLock"

"2. För kopiera och klistra in: sudo apt-get install xclip"

"3. För coc.nvim behövs nodejs >= 10.12 och vim >= 8.0.1453"
"   Ladda ner nodejs:"
"   sudo apt-get install curl python-software-properties"
"   curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -"
"   sudo apt-get install nodejs"

"4. Ladda om init.vim och :PlugInstall för att ladda ner plugins"
"
"5. Kör :checkhealth inuti nvim

set number "Rad nummer"
set noshowmode "Fix för lightline"
set laststatus=2 "fix för lightline"
set nowrap "texten kommer inte på en ny rad om den inte syns"
set clipboard+=unnamedplus "kopiera och klistra in fungerar som det ska."
set incsearch "livesearch"
set ttimeoutlen=50 "Ingen label-delay när man går från INSERT till NORMAL"

"Indrag är 4 istället för 8"
set tabstop=4
set shiftwidth=4
set expandtab

let g:coc_global_extensions = [
\ 'coc-snippets',
\ 'coc-json',
\ 'coc-clangd',
\ 'coc-java',
\ 'coc-html',
\ 'coc-css',
\ 'coc-tsserver'
\ ]

"Skapa katalogerna automatisk om de inte finns."
if !isdirectory($HOME . '/.config/nvim/backup//')
    call mkdir($HOME . '/.config/nvim/backup//', "p")
endif
if !isdirectory($HOME . '/.config/nvim/swap//')
    call mkdir($HOME . '/.config/nvim/swap//', "p")
endif
if !isdirectory($HOME . '/.config/nvim/undo//')
    call mkdir($HOME . '/.config/nvim/undo//', "p")
endif

"Swap, backup och undo filer hamnar i dessa kataloger, istället för samma
"katalog som filen. (//) gör att filen inte kan heta likadant."
set backupdir=~/.config/nvim/backup//
set directory=~/.config/nvim/swap//
set undodir=~/.config/nvim/undo//

"Ladda ner automatiskt vim-plug"
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
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
"Bättre clangd syntax highlight"
Plug 'jackguo380/vim-lsp-cxx-highlight'

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
