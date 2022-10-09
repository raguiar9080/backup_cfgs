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

" THEMES
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" GIT
Plug 'tpope/vim-fugitive'

" LANGUAGE SUPPORT
" Plug 'elixir-lang/vim-elixir'
" Plug 'derekwyatt/vim-scala'
" Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'rust-lang/rust.vim'

" DEBUGGING
"Plug 'puremourning/vimspector'

" CONFIGURATION FOR VIM-SCALA
"au BufRead,BufNewFile *.sbt set filetype=scala
"au! Syntax scala source ~/.vim/syntax/scala.vim

" CONFIGURATION JS ESLINT
Plug 'neoclide/coc-eslint'
Plug 'neoclide/coc-prettier'

" FUZZY SEARCH & tags
"Plug 'craigemery/vim-autotag'
Plug 'ctrlpvim/ctrlp.vim'

" FILE EXPLORER
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
set cmdheight=2 " Better display for messages
set updatetime=300 " You will have a bad experience with diagnostic messages with the default 4000.
set shortmess+=c " Don't give |ins-completion-menu| messages.
set signcolumn=yes " Always show signcolumns
set tabstop=2 shiftwidth=4 expandtab
set hlsearch
set noswapfile
set backspace=2 " Backspace behaves 'normally'
set whichwrap+=<,>,h,l,[,] " Change lines on arrow and h/l keys
set autoread " Don't ask if file has no unsaved changes, simply read anew
set t_Co=256
set laststatus=2
set tagfunc=CocTagFunc " NOT WORKING? Tag mechanism using coc

" --------------------------------------------SEARCH-------------------------------------------

let g:ctrlp_working_path_mode = 0
let g:ctrlp_show_hidden = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_match_window = 'results:5' " overcome limit imposed by max height
let g:ctrlp_use_caching = 0 " disable caching
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
let g:airline_section_z = '%p%%%#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#%#__accent_bold#|%v%#__restore__#'


" --------------------------------------------EXPLORER-------------------------------------------

let g:netrw_liststyle = 3
let g:netrw_banner = 0

" --------------------------------------------DEBUGGER-------------------------------------------

"let g:vimspector_enable_mappings = 'HUMAN'
"packadd! vimspector

" --------------------------------------------FOLDS-------------------------------------------

set nofoldenable    " disable folding
set foldmethod=manual
"set foldnestmax=10
"set foldlevel=2
" Save and restore code folds (and cursor position?)
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview

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

" --------------------------------------------OTHER-------------------------------------------

" Delete on buffer close if empty and last
autocmd BufDelete * if len(filter(range(1, bufnr('$')), 'empty(bufname(v:val)) && buflisted(v:val)')) == 1 | quit | endif

" Autotag issues on macos...
" let g:autotagStartMethod='fork'

let g:coc_global_extensions = [ 'coc-tsserver', 'coc-prettier', 'coc-eslint'] "COC server for TypeScript
command! -nargs=0 Prettier :CocCommand prettier.formatFile "Auto import order after save
" autocmd BufWritePost *.ts :CocCommand tsserver.organizeImports
autocmd BufWritePost *.rs :RustFmt

" --------------------------------------------PERFORMANCE--------------------------------------------

set timeoutlen=1000
set ttimeoutlen=0
"set maptimeout=0

" make Esc happen without waiting for timeoutlen
" fixes Powerline delay
augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=1000
augroup END
set ttyfast
set lazyredraw
let g:airline_highlighting_cache=1
set norelativenumber
set re=1

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

    " Remap keys for gotos
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gr <Plug>(coc-references)
    nmap <silent> gi <Plug>(coc-implementation)
    " nmap <silent> <C-]> <Plug>(coc-definition)
    " nmap <silent> gd :call CocAction('jumpDefinition', 'tab drop') <CR>
    " nmap <silent> <C-t> <Plug>(coc-references)
    " NOT SUPPORTED?
    "nmap <silent> <C-t> <C-o><C-o>

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
    "autocmd CursorHold * silent call CocActionAsync('highlight')

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
"
"    " Toggle panel with Tree Views
"    nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
"    " Toggle Tree View 'metalsBuild'
"    nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
"    " Toggle Tree View 'metalsCompile'
"    nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
"    " Reveal current current class (trait or object) in Tree View 'metalsBuild'
"    nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsBuild<CR>


" Allow CTRL+A to focus all text
map <C-a> <Esc>ggVG<CR>
" Reload everything
nnoremap <F5> :bufdo checktime<CR>
" Gitblame
nnoremap <F1> :Git blame<CR>
" Paste be faster
nnoremap <F2> :read !pbpaste<CR>
" Tab navigation like Firefox.
set hidden
nnoremap <C-PageDown> :bnext<CR>
nnoremap <C-PageUp>   :bprevious<CR>
"nnoremap <C-o>        :enew<CR>

" Change how things get closed
cnoreabbrev wq w<bar>bd
cnoreabbrev q bd

" QUICKFIX NAVIGATION
":echo len(getqflist())
" 'errorformat' matched %t as an error.
"let error_count = len(filter(getqflist(), { k,v -> v.type == 'E' }))
" Anything with a destination file.
"let jumpable_count = len(filter(getqflist(), { k,v -> v.bufnr != 0 }))
"map <C-l> :<C-u>execute :normal! len(getqflist()) :cn@a<CR><CR>
" https://stackoverflow.com/questions/1747091/how-do-you-use-vims-quickfix-feature
" http://vimdoc.sourceforge.net/htmldoc/quickfix.html
map <C-h> :cn<CR>:cp<CR>@a:cn<CR>
map <C-j> :cp<CR>
map <C-k> :cn<CR>
augroup vimrcQfClose
    autocmd!
    autocmd FileType qf if mapcheck('<esc>', 'n') ==# '' | nnoremap <buffer><silent> <esc> :cclose<bar>lclose<CR> | endif
augroup END


" Println made easy
"nnoremap <C-l> oprintln(s"${}")<left><left><left><left><left>
"imap <C-l> <ESC>oprintln(s"${}")<left><left><left><left><left>

" console.log made easy
xnoremap <C-l> y<Esc>oconsole.log(`####  ####: ${JSON.stringify(<Esc>pA)}`)<Esc>I<C-Right><Esc><right><right><right><right><right><right><right><right><right><right><right><right>i
inoremap <C-l> <Esc>oconsole.log(`#### :${JSON.stringify()}`)<left><left><left><left>
nnoremap <C-l> deP<Esc>oconsole.log(`#### <Esc>pA ####: ${JSON.stringify(<Esc>pA)}`)<Esc>I<Esc>
