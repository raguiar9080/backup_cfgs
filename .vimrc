set nocompatible              " be iMproved, required
" Switching from vundle to vim-plug. This will load and install vim-plug if it isn't already installed.
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/Vundle.vim

" --------------------------------------------PLUGINS-------------------------------------------
" begin vim-plug section
" Directions are here: https://github.com/junegunn/vim-plug.
" Basically, first initialize using curl -fLo ~/.vim/autoload/plug.vim
" --create-dirs \
"      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim and
" This section is for vim-plug managed plugins.
" :PlugInstall to install them.
call plug#begin('~/.vim/plugged')

" themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" git
Plug 'tpope/vim-fugitive'

" language support
Plug 'elixir-lang/vim-elixir'
Plug 'derekwyatt/vim-scala'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}

" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

" fuzzy search
Plug 'ctrlpvim/ctrlp.vim'
Plug 'craigemery/vim-autotag'

" file explorer
Plug 'scrooloose/nerdtree'

" Add plugins to &runtimepath
" All of your Plugs must be added before the following line
call plug#end()

" --------------------------------------------DEFS-------------------------------------------

colorscheme desert

syntax on
set synmaxcol=200
set noshowmatch
set ruler
set tags+=tags;$HOME
set nu
set nobackup
set nowritebackup
" Better display for messages
set cmdheight=2
" You will have a bad experience with diagnostic messages with the default 4000.
set updatetime=300
" Don't give |ins-completion-menu| messages.
set shortmess+=c
" Always show signcolumns
set signcolumn=yes
set tabstop=2 shiftwidth=2 expandtab
set hlsearch
set noswapfile
" Backspace behaves 'normally'
set backspace=2
" Change lines on arrow and h/l keys
set whichwrap+=<,>,h,l,[,]
" Don't ask if file has no unsaved changes, simply read anew
set autoread
set t_Co=256
set laststatus=2

" --------------------------------------------SEARCH-------------------------------------------

let g:ctrlp_working_path_mode = 0
let g:ctrlp_show_hidden = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_match_window = 'results:5' " overcome limit imposed by max height
let g:ctrlp_use_caching = 0 " enable caching
"let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
"let g:ctrlp_clear_cache_on_exit = 0
let g:ctrl_max_files = 10000
let g:ctrlp_mruf_max = 5 " number of recently opened files
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = '\v[\/](bloop|metals|node_modules|target|dist|tmp|log)|(\.(bloop|swp|ico|git|svn|xml))$'
let g:ctrlp_max_depth = 10
"open in new tab
"let g:ctrlp_prompt_mappings = {
"    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
"    \ 'AcceptSelection("t")': ['<cr>'],
"    \ }

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

" Metals comment highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+

" --------------------------------------------HIGHLIGHTING-------------------------------------------

" Delete on buffer close if empty and last
autocmd BufDelete * if len(filter(range(1, bufnr('$')), 'empty(bufname(v:val)) && buflisted(v:val)')) == 1 | quit | endif

" --------------------------------------------PERFORMANCE--------------------------------------------
set timeoutlen=1000
set ttimeoutlen=0
"set maptimeout=0

" ----------------------------------------KEYBOARD SHORTCUTS-----------------------------------------
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Used in the tab autocompletion for coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
"nmap <silent> [c <Plug>(coc-diagnostic-prev)
"nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> ]c <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> [c <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

" Used to expand decorations in worksheets
nmap <Leader>ws <Plug>(coc-metals-expand-decoration)

" Use K to either doHover or show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType scala setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Notify coc.nvim that <enter> has been pressed.
" Currently used for the formatOnType feature.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Toggle panel with Tree Views
nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
" Toggle Tree View 'metalsBuild'
nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" Toggle Tree View 'metalsCompile'
nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" Reveal current current class (trait or object) in Tree View 'metalsBuild'
nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsBuild<CR>


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
nnoremap <C-l> oprintln(s"${}")<left><left><left><left><left>
imap <C-l> <ESC>oprintln(s"${}")<left><left><left><left><left>
