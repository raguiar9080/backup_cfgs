set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins: call vundle#begin('~/some/path/here')

" --------------------------------------------PLUGINS-------------------------------------------

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" themes
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" git
Plugin 'tpope/vim-fugitive'

" language support
Plugin 'elixir-lang/vim-elixir'
Plugin 'derekwyatt/vim-scala'

" fuzzy search
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'craigemery/vim-autotag'

" file explorer
Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"

" --------------------------------------------DEFS-------------------------------------------

colorscheme desert

syntax on
set synmaxcol=200
set noshowmatch
set ruler
set tags+=tags;$HOME
set nu
set nobackup
set tabstop=2 shiftwidth=2 expandtab
set hlsearch
set noswapfile
" Backspace behaves 'normally'
set backspace=2
" Change lines on arrow keys
set whichwrap+=<,>,[,]
" Don't ask if file has no unsaved changes, simply read anew
set autoread
set t_Co=256
set laststatus=2

" --------------------------------------------SEARCH-------------------------------------------

let g:ctrlp_working_path_mode = 0
let g:ctrlp_show_hidden = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_match_window = 'results:10' " overcome limit imposed by max height
let g:ctrlp_use_caching = 0 " enable caching
"let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
"let g:ctrlp_clear_cache_on_exit = 0
let g:ctrl_max_files = 10000
let g:ctrlp_mruf_max = 20 " number of recently opened files
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|tmp|log)|(\.(swp|ico|git|svn|xml))$'
let g:ctrlp_max_depth = 10

"if exists('g:ctrlp_user_command')
"  unlet g:ctrlp_user_command
"end
"if exists('g:ctrlp_custom_ignore')
"    unlet g:ctrlp_custom_ignore
"end
"if executable('ag')
"  set grepprg=ag\ --nogroup\ --nocolor
"  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"  let g:ctrlp_use_caching = 1
"  autocmd VimEnter * echo 'ag ON'
"else
"  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
"  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
"  autocmd VimEnter * echo 'git ON'
"endif

" --------------------------------------------THEME-------------------------------------------

let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#fnamemod = ':.'
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline_section_c = '%t'
let g:airline_section_x = ''
let g:airline_section_y = ''

" --------------------------------------------EXPLORER-------------------------------------------

let g:netrw_liststyle = 3
let g:netrw_banner = 0

" --------------------------------------------FOLDS-------------------------------------------

set nofoldenable    " disable folding
set foldmethod=manual
"set foldnestmax=10
"set foldlevel=2
" Save and restore code folds (and cursor position?)
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" --------------------------------------------HIGHLIGHTING-------------------------------------------

highlight ExtraWhitespace ctermbg=darkred guibg=#382424
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Highlight long lines
highlight OverLength ctermbg=DarkGray ctermfg=white guibg=#592929
2match OverLength /\%151v.\+/
autocmd BufWinEnter * 2match OverLength /\%151v.\+/
autocmd InsertEnter * 2match OverLength /\%151v.\+/
autocmd InsertLeave * 2match OverLength /\%151v.\+/
autocmd BufWinLeave * call clearmatches()

" --------------------------------------------HIGHLIGHTING-------------------------------------------

" Delete on buffer close if empty and last
autocmd BufDelete * if len(filter(range(1, bufnr('$')), 'empty(bufname(v:val)) && buflisted(v:val)')) == 1 | quit | endif

" ----------------------------------------KEYBOARD SHORTCUTS-------------------------------------------

" Allow CTRL+A to focus all text
map <C-a> <esc>ggVG<CR>
" Reload everything
nnoremap <F5> :bufdo checktime<CR>
" Gitblame
nnoremap <F1> :Gblame<CR>
" Paste be faster
nnoremap <F2> :read !pbpaste<CR>
" Tab navigation like Firefox.
set hidden
nnoremap <C-PageDown> :bnext<CR>
nnoremap <C-PageUp>   :bprevious<CR>
" nnoremap <C-o>        :enew<CR>

" Change how things get closed
cnoreabbrev wq w<bar>bd
cnoreabbrev q bd

" Println made easy
nnoremap <C-l> oprintln("" + )<left><left><left><left><left>
imap <C-l> <ESC>oprintln("" + )<left><left><left><left><left>
