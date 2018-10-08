set nocompatible              " be iMproved, required
filetype off                  " required

" ///////
" Plugins
" ///////

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" package manager
Plugin 'VundleVim/Vundle.vim'

" colorscheme
Plugin 'jacoborus/tender'
Plugin 'altercation/vim-colors-solarized'

" utilitarian
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'dyng/ctrlsf.vim'
Plugin 'henrik/vim-indexed-search'              " <2 of 10>
Plugin 'vimwiki/vimwiki.git'                    " Notes
Plugin 'xolox/vim-misc'                         " Required for opening browser
Plugin 'xolox/vim-shell'

" taking search to next level
Plugin 'mileszs/ack.vim'                        " needs `ag` (preferred) or `ack`

" git
Plugin 'tpope/vim-fugitive'
Plugin 'shumphrey/fugitive-gitlab.vim'

" JS
" Plugin 'vim-syntastic/syntastic'
Plugin 'w0rp/ale'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'prettier/vim-prettier'

" HTML
" Plugin 'othree/html5.vim'
Plugin 'ap/vim-css-color'
Plugin 'Valloric/MatchTagAlways'
Plugin 'mattn/emmet-vim'

" autocomplete
" https://gregjs.com/vim/2016/neovim-deoplete-jspc-ultisnips-and-tern-a-config-for-kickass-autocompletion/
Plugin 'Shougo/deoplete.nvim'
Plugin 'carlitux/deoplete-ternjs'

" Spotify?!
Plugin 'HendrikPetertje/vimify'

" JSON parsing inside vimscript
Plugin 'vimlab/vim-json'

call vundle#end()

filetype plugin indent on
filetype plugin on

" ///////////////
" Configurations
" ///////////////
set cursorline                                  " highlight current line
set number                                      " set line numbers
syntax on                                       " enable syntax highlight
set background=dark
colorscheme solarized

set tabstop=2                                   " 2 space = 1 tab
set shiftwidth=2
set softtabstop=2
set expandtab

set mouse=a                                     " enable mouse scrolling
set scrolloff=5                                 " Keep a buffer of 5 lines top and bottom when scrolling

" spell check
set spelllang=en
" disabled for now
" set spell

" html has 4 space tab
autocmd Filetype html setlocal ts=4 sts=4 sw=4 expandtab
autocmd Filetype mason setlocal ts=4 sts=4 sw=4 expandtab

" search settings
set ignorecase                                  " case insensitive by default
set smartcase                                   " case sensitive if any letter is in CAPS
set hlsearch                                    " highlight search items
highlight Search cterm=NONE ctermfg=white ctermbg=blue

" .erb are html/javascript files
autocmd BufNewFile,BufRead *.html.erb set filetype=html
autocmd BufNewFile,BufRead *.js.erb set filetype=javascript
autocmd BufNewFile,BufRead *.es6.erb set filetype=javascript
autocmd BufNewFile,BufRead *.es6 set filetype=javascript

" fix for booking.vim plugin which sets file types to jstmpl, csstmpl
autocmd BufNewFile,BufRead *.js set filetype=javascript
autocmd BufNewFile,BufRead *.css set filetype=css

"inc files are mason types
autocmd BufNewFile,BufRead *.inc set filetype=mason

" save file automatically when buffer is hidden
set autowrite

" 120 chars warning
highlight ColorColumn ctermbg=black
set colorcolumn=100

" disable bell sound
set noerrorbells visualbell t_vb=

" highlight matching [{}]
set showmatch

" reload file automatically when they're update on disk
set autoread

" highlight trailing spaces
set list listchars=tab:>-,trail:•,extends:>

" persistent undo
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000

" ////////////
" Key mappings
" ////////////

" mapleader
let mapleader="g"

" esc is far
inoremap jk <esc>

" easy buffer movements
map <leader>n :bn<cr>
map <leader>p :bp<cr>
map <leader>h :bd<cr>

" moving lines in visual mode
" https://twitter.com/MasteringVim/status/800982553943543809
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" shift/no shift
command WQ wq
command Wq wq
command W w
command Q q

" disable search highlighting on Enter
:nnoremap <CR> :nohlsearch<CR><CR>

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" terminal mode fixes
:tnoremap <Esc> <C-\><C-n>

" easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

"better use of space in normal mode
nnoremap <space> viw

"better use of H and L
nnoremap H ^
nnoremap L $

nnoremap ggg gg

" auto complete for brackets
inoremap {<CR> {<CR>}<Esc>O
inoremap < <><Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i

"copy to outside buffer
vnoremap <leader>y "+y

" /////////////////////
" Plugin configurations
" /////////////////////

" NERDTree
map tt :NERDTreeFind<CR>                        " find current file in tree
map <leader>t :NERDTreeToggle<CR>               " toggle file browser
let g:NERDTreeWinSize = 45

" file highlighting in NERDTree
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('js', 'blue', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('tmpl', 'red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('inc', 'red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('pm', 'green', 'none', 'green', '#151515')

" JSDocs
map <C-d> :JsDoc<cr>
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1

" enable syntax highlighting for JSDocs
let g:javascript_plugin_jsdoc = 1

" autocomplete/deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = ['tern#Complete']

set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'buffer', 'ultisnips', 'ternjs']

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'mason': { 'left': '##' } }

" Ctrlsf
nmap <leader>s <Plug>CtrlSFCwordPath
map <C-f> :CtrlSFToggle<cr>

" javascript-libraries-syntax
let g:used_javascript_libs = 'jquery'

" vim-fugitive
map <leader>gb :Gbrowse<CR>
map <leader>gs :Gstatus<CR>
map <leader>gd :Gdiff<CR>
map <leader>gc :Gcommit<CR>
map <leader>gm :Gblame<CR>
map <Leader>ga <Plug>GitGutterStageHunk
map <Leader>gr <Plug>GitGutterUndoHunk

" fzf
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = { 'down': '~50%' }
map <C-p> :FZF<CR>
let g:fzf_history_dir = '~/.local/share/fzf-history'

" vim-indexed-search
let g:indexed_search_shortmess = 1
let g:indexed_search_numbered_only = 1
let g:indexed_search_line_info = 1

" vimify
" How to get token: https://github.com/HendrikPetertje/vimify#update-march-2018-vimify-now-requires-authentication
let g:spotify_token=$SPOTIFY_TOKEN
map <leader>mm :Spotify<CR>
map <leader>mn :SpNext<CR>
map <leader>mp :SpPrevious<CR>
map <leader>ms :SpSearch<space>

" airline
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" Prettier
nmap <Leader>yy <Plug>(Prettier)
let g:prettier#config#print_width = 100

" vim-ALE
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

let g:ale_linter_aliases = {
\   'jstmpl': 'javascript',
\   'csstmpl': 'css',
\}
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1

" editing vimrc in a jiffy
" source $MYVIMRC reloads the saved $MYVIMRC
nnoremap <Leader><Leader>s :source $MYVIMRC <CR>
" opens $MYVIMRC for editing, or use :tabedit $MYVIMRC
nnoremap <Leader><Leader>v :e $MYVIMRC <CR>

" Use ag for searching if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
