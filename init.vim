set shell=/bin/sh
set nocompatible              " be iMproved, required
filetype off                  " required
set encoding=UTF-8
set conceallevel=2

" ///////
" Plugins
" ///////

" vim-plug: https://github.com/junegunn/vim-plug
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" colorscheme
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'cocopon/iceberg.vim'
Plug 'skbolton/embark'

" utilitarian
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'henrik/vim-indexed-search'              " <2 of 10>
Plug 'vimwiki/vimwiki'                        " Notes
Plug 'jiangmiao/auto-pairs'

" taking search to next level
Plug 'mileszs/ack.vim'                        " needs `ag` (preferred) or `ack`

" JS
Plug 'heavenshell/vim-jsdoc', {'do': 'make install'}
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'mxw/vim-jsx'
Plug 'jxnblk/vim-mdx-js'

" TypeScript
" The syntax hightlight doesn't work as expected
" Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'

" HTML
Plug 'ap/vim-css-color'
Plug 'Valloric/MatchTagAlways'

" autocomplete + linting
" https://medium.freecodecamp.org/a-guide-to-modern-web-development-with-neo-vim-333f7efbf8e2
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fzf for file search
Plug 'junegunn/fzf.vim'

Plug 'ruanyl/vim-gh-line'

" Nvim > 0.5
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" better markdown support
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vimlab/vim-json'

" GraphQL highlighting
Plug 'jparise/vim-graphql'

call plug#end()

filetype plugin indent on
filetype plugin on

" ///////////////
" Configurations
" ///////////////
set cursorline                                  " highlight current line
set number                                      " set line numbers
syntax on                                       " enable syntax highlight
set hidden
set background=dark
colorscheme gruvbox

set tabstop=2                                   " 2 space = 1 tab
set shiftwidth=2
set softtabstop=2
set expandtab

set mouse=a                                     " enable mouse scrolling
set scrolloff=5                                 " Keep a buffer of 5 lines top and bottom when scrolling
set nostartofline                               " Don't move cursor to start of the line
set showcmd                                     " Show the input of incomplete command

" html has 4 space tab
autocmd Filetype html setlocal ts=4 sts=4 sw=4 expandtab
autocmd Filetype mason setlocal ts=4 sts=4 sw=4 expandtab

" search settings
set ignorecase                                  " case insensitive by default
set smartcase                                   " case sensitive if any letter is in CAPS
set hlsearch                                    " highlight search items
highlight Search cterm=NONE ctermfg=white ctermbg=blue

"inc files are mason types
autocmd BufNewFile,BufRead *.inc set filetype=mason

" save file automatically when buffer is hidden
set autowrite

" show incomplete commnad
set showcmd

" Allow h,l and left/right keys to overflow to next/previous line
 set ww=<,>,h,l

" 100 chars warning
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

" no backup files
set nobackup
set noswapfile

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
map <leader>h :bp\|bd #<cr>
" most recent buffer, similar to cd -
map <leader>v :b#<cr>

" shift/no shift
command WQ wq
command Wq wq
command W w
command Q q

" disable search highlighting on Enter
nnoremap <CR> :nohlsearch<CR><CR>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" terminal mode fixes
:tnoremap <Esc> <C-\><C-n>

"better use of H and L
nnoremap H ^
nnoremap L $

"copy to outside buffer
vnoremap <leader>y "+y

" /////////////////////
" Plugin configurations
" /////////////////////

" NERDTree
map tt :NERDTreeFind<cr>                        " find current file in tree
map <leader>t :NERDTreeToggle<cr>               " toggle file browser
let g:NERDTreeWinSize = 45
let g:NERDTreeShowHidden=1

" Close vim if NERDTree is the only thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
let g:javascript_plugin_tsdoc = 1
let g:jsdoc_formatter='tsdoc'

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'mason': { 'left': '##' } }

" javascript-libraries-syntax
let g:used_javascript_libs = 'jquery,react'

" fzf
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
" Required:
" - width [float range [0 ~ 1]]
" - height [float range [0 ~ 1]]
"
" Optional:
" - xoffset [float default 0.5 range [0 ~ 1]]
" - yoffset [float default 0.5 range [0 ~ 1]]
" - highlight [string default 'Comment']: Highlight group for border
" - border [string default 'rounded']: Border style
"   - 'rounded' / 'sharp' / 'horizontal' / 'vertical' / 'top' / 'bottom' / 'left' / 'right'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9, 'yoffset': 0.1 } }
" let g:fzf_layout = { 'down': '70%' }
let g:fzf_preview_window = 'up:50%'
" To clear preview pane in fzf text search
" let g:fzf_preview_window = ''

let $FZF_DEFAULT_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}" --preview-window "up:50%"'
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" https://github.com/junegunn/fzf/issues/453#issuecomment-700943343
" Prevent FZF commands from opening in none modifiable buffers
function! FZFOpen(cmd)
    " If more than 1 window, and buffer is not modifiable or file type is
    " NERD tree or Quickfix type
    if winnr('$') > 1 && (!&modifiable || &ft == 'nerdtree' || &ft == 'qf')
        " Move one window to the right
        wincmd l
    endif
    exe a:cmd
endfunction

" FZF Search for Files
nnoremap <silent> <C-p> :call FZFOpen(":Files")<CR>

" FZF in Open buffers
nnoremap <silent> <C-b> :call FZFOpen(":Buffers")<CR>

" FZF Search for contents
nnoremap <silent> <C-f> :call FZFOpen(":Ag")<CR>

" vim-indexed-search
let g:indexed_search_shortmess = 1
let g:indexed_search_numbered_only = 1
let g:indexed_search_line_info = 1

" vim-airline
let g:airline#extensions#tabline#formatter = 'jsformatter'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_theme='molokai'

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" Use ag for searching if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

map <Leader>b gg0veyo<CR>WBSO-Time-Spent: _h<CR>WBSO-Topic: <ESC>p

"coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
map rr :Prettier<CR>

"eslint-fix
command! -nargs=0 Eslint :CocCommand eslint.executeAutofix
map ee :Eslint<CR>

" https://github.com/neoclide/coc.nvim/

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" nmap <silent> gk :CocAction<CR>
nmap <silent> gk <Plug>(coc-codeaction-selected)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Not every .md file is vimwiki
let g:vimwiki_global_ext = 0

" Auto-format markdown files leaving insert mode
" https://vi.stackexchange.com/a/11611
set formatoptions+=aw

" Add new date header
nnoremap pp "=strftime("## %A, %d/%m/%Y")<CR>P

" don't fold markdown headers by default
let g:vim_markdown_folding_disabled = 1
