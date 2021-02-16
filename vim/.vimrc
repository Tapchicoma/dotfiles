"Мышь в текстовом режиме"
set mouse=a

set winminheight=0
set winminwidth=0
"Всегда отоброжать статусную строку для каждого окна"
set laststatus=2

"Размер табуляции"
set tabstop=4
set softtabstop=4
"Преобразование таба в пробелы"
set expandtab
"Размер сдвига при нажатии на клавиши << и >>"
set shiftwidth=4
"Отключаем совместимость с настройками Vi"
set nocompatible
"Show cursor position"
set ruler
"Копирует отступ от предыдущей строки"
set autoindent
"Включаем автоматическую расстановку отступов"
set smartindent
"Включаем подсветку синтаксиса"
syntax on
"Включаем отоброжение номеров линий"
set number
"Включаем перенос строк"
set wrap
" Перенос строк по словам"
set linebreak
"Включаем отображение исполняемой команды"
set showcmd 
"Сворачивание по отступам"
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1
"кодировка текста по умлочанию"
set termencoding=utf-8
"Не выгружать буфер, когда переключаешься на другой"
set hidden
"Hide panel in gui version"
set guioptions-=T
"Сделать строку команд высотой в одну строку"
set ch=1
" дополнение дополнительной информации в статусной строке"
set statusline=%<%f%h%m%r%=format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %b\ 0x%b\ %l,%c%v\ %p

"Set font and size"
set guifont=Droid\ Sans\ Mono\ 16
"Set colorscheme"
set background=light
colorscheme charon
"Включаем подсветку искомого выражения"
set hlsearch
"поиск по набору слова"
set incsearch
" Останавливать поиск при достижении конца оборудования"
set nowrapscan
"Игнорировать регистр букв при поиске"
set ignorecase

"Disable backups"
set nobackup
"Disable swap files"
"set noswapfile"
"Swap dir location"
set dir=~/.vim/swp
"History size"
set undolevels=1000
" File types autoindetination"
filetype plugin indent on
"List of autoencoding"
set fileencodings=utf-8,cp1251,koi8-r,cp866
"Enable visualbell"
set novisualbell
"перемещать курсор на следующую строку при нажатии на клавиши вправо-влево"
set whichwrap=b,s,<,>,[,],l,h
"Russian keymap (switch C-^)"
"set keymap=russian-jcukenwin
"English keymap default"
"set iminsert=0
" Fix <Enter> for comment"
set fo+=cr
" Pydiction comlete-dict location "
let g:pydiction_location='~/.vim/pydiction/complete-dict'

" +++++ Taglist +++++ "
" Taglist variables
" Display function name in status bar:
let g:ctags_statusline=1
" Automatically start script
let generate_tags=1
" Displays taglist results in a vertical window:
let Tlist_Use_Horiz_Window=0
" Shorter commands to toggle Taglist display
nnoremap TT :TlistToggle<CR>
map <F4> :TlistToggle<CR>
" Various Taglist diplay config:
let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1

" +++++ Eclimd ++++++"
" Use default taglist instead of Eclim "
"let g:EclimTaglistEnabled=0"
"let g:taglisttoo_disabled=1"
" if current file in eclipse project, open project tree automaticly "
"let g:EclimProjectTreeAutoOpen=1"
"let g:EclimProjectTreeExpandPathOnOpen=1"
"let g:EclimProjectTreeSharedInstance=1 share tree instance through all tabs "
" use tabnew instead of split for new action "
"let g:EclimProjectTreeActions = [ {'pattern':'.*','name':'Tab','action':'tabnew'} ]"
" for tabn tabp "
" tab navigation like firefox "
"nmap <C-Left> :tabprevious<CR>"
"nmap <C-Right> :tabnext<CR>"
"nmap <C-t> :tabnew<CR>"

" +++++ SuperTab +++++ "
"let g:SuperTabDefaultCompletionType =<c-x><c-u>"

" +++++ Filetypes +++++ "
autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(
" Session options
set sessionoptions=curdir,buffers,tabpages

" +++++ Hotkeys +++++ "
" Space lists pages in normal mode "
nmap <Space> <PageDown>
"quick text moving"
nmap <C-H> 5h
nmap <C-J> 5j
nmap <C-K> 5k
nmap <C-L> 5l
" C-c and C-v in global clipboard "
vmap <C-C> "+yi
imap <C-V> <esc>"+gPi
" Shift-insert as in xterm "
map <S-Insert> <MiddleMouse>
" <F2> quick save "
nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>i
imap <F2> <esc>:w<cr>i
" <F3> call ant task "
nmap <F3> ,z
vmap <F3> <esc>,z
imap <F3> <esc>,z
" <F11> NERDTree plugin"
nmap <F11> :NERDTree<cr>
vmap <F11> <esc>:NERDTree<cr>i
imap <F11> <esc>:NERDTree<cr>i
" <F9> Minibufexplorer"
nmap <F9> :MiniBufExplorer<cr>
vmap <F9> <esc>:MiniBufExplorer<cr>i
imap <F9> <esc>:MiniBufExplorer<cr>i
"Insert comments"
map - $a --><Esc>
map = $a <--<Esc>

" +++++ Different functions +++++ "
command Pylint :call Pylint()
function! Pylint()
        setlocal makeprg=(echo\ '[%]';\ pylint\ %)
        setlocal efm=%+P[%f],%t:\ %#%l:%m
        silent make
        cwindow
        endfunction
