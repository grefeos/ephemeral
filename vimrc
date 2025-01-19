" Устанавливаем переменные окружения, если они не заданы
if empty($VIMHOME)
  let $VIMHOME = expand('~/.vim')
endif

if empty($MYVIMRC)
  let $MYVIMRC = expand('%:p')
endif

" Проверяем, есть ли уже путь в runtimepath
if index(split(&runtimepath, ','), expand('$VIMHOME')) == -1
  " Если пути нет, добавляем его
  set runtimepath+=$VIMHOME
endif

" Проверяем, установлен ли vim-plug, и устанавливаем его при необходимости
" filereadable не умеет работать с путями, начинающимися с '~', поэтому
" используется странная конструкция empty(glob('...'))
if empty(glob($VIMHOME . '/autoload/plug.vim')) && !filereadable('/usr/share/vim/vimfiles/autoload/plug.vim')
  silent !curl -fLo $VIMHOME/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Автоматически ставим отсутствующие плагины
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | source $MYVIMRC
  \| endif

" Инициализируем vim-plug
call plug#begin('$VIMHOME/plugged')

" Добавляем плагины
Plug 'tpope/vim-sensible'  " Настройки по умолчанию для Vim
Plug 'scrooloose/nerdtree' " Файловый менеджер
" Плагин может установить fzf, если того нет
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " Нечеткий поиск строк
Plug 'jiangmiao/auto-pairs' " Автоматическое закрытие скобок и кавычек
Plug 'tpope/vim-surround' " Добавляет, изменяет, удаляет закрывающие скобки, кавычки и тд
Plug 'ervandew/supertab' " Автодополнение с использованием <Tab>
Plug 'tpope/vim-commentary' " Комментирование строк кода
Plug 'airblade/vim-gitgutter' " Показываем изменения в Git
Plug 'dense-analysis/ale' " Линтинг и форматирование
Plug 'ryanoasis/vim-devicons' " Иконки для файлов и папок
Plug 'nathanaelkane/vim-indent-guides' " Визуальное отделение отступов
Plug 'luochen1990/rainbow' " Разноцветная подсветка скобок
Plug 'vim-airline/vim-airline' " Airline status bar
Plug 'vim-airline/vim-airline-themes' " Airline themes
Plug 'joshdick/onedark.vim' " One Dark theme
Plug 'editorconfig/editorconfig-vim'
Plug 'will133/vim-dirdiff'
" Завершаем инициализацию vim-plug
call plug#end()

" А тут пользовательские настройки и настройки плагинов

" Базовые настройки

" Настройки ввода

" В coc.nvim прокрутка с помощью клавиш C-f и C-b не работает в vim
set mouse=a

" Включаем использование системного буфера
set clipboard=unnamedplus

" Задержка в мс для сочетаний клавиш
set timeoutlen=500


" Работа с текстом

" Табуляция и отступы
set tabstop=2
set shiftwidth=2
set expandtab

" Python использует 4 пробела для отступов
autocmd FileType python setlocal tabstop=4 shiftwidth=4

" Кодировка текста
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp1251,koi8-r,cp866

" Поиск по тексту
set hlsearch " подсвечивать результаты поиска

" Перемещение по тексту
" Когда достигаем границ строки, то перемещаемся на предыдующую/следующую
set whichwrap+=h,l,<,>,[,]

" Визуальные настройки

" Включаем номера строк
set number

" Отображение скрытых символов
set list
set listchars=tab:»·,trail:·,nbsp:␣,extends:>,precedes:<

" Ширина строки и красная линия
set textwidth=80
set cc=+1

" Если мешает отображение режима в поле для команд
set noshowmode

" Настройки автодополнения
set completeopt=menu,menuone,noselect

" Разделение экрана
set splitbelow " разбивать вниз
set splitright " разбивать вправо

" Задержка CursorHold
set updatetime=100

" Настройки поведения
" Отключаем visual bell
set noerrorbells
set novisualbell
set t_vb=

" Игнорировать 'No write since last change' (буфер не сохранен)
set hidden

" Отключить создание бекапов, своп-файлов и файлов отмены
set nobackup noundofile noswapfile

" Эти комментарии потенциально опасны
set nomodeline

" Включаем автоматическое обновление буфера
set autoread

" Обновляем буфер при изменении файла внешними инструментами
autocmd FocusGained,BufEnter * checktime

" Переход в нормальный режим
inoremap <C-s> <Esc>
vnoremap <C-s> <ESC>

" Копирование в системный буфер
vnoremap <C-c> "+y

" Выделение всего текста
nnoremap <C-a> ggVG
inoremap <C-a> <Esc>ggVG

" Использование h, j, k, l для перемещения с зажатым Ctrl в режиме редактирования
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Переместиться в начало строки
inoremap <C-0> <Home>
" Переместиться в конец строки
inoremap <C-$> <End>
" Переместиться к первому непробельному символу
inoremap <C-^> <Home>

" Клавиши leader и альтернативная основной
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" Очистить результаты поиска
nnoremap <leader>h :noh<CR>

" Переключение между вкладками
nnoremap <leader>t :tabnext<CR>
nnoremap <leader>T :tabprevious<CR>

" Список вкладок
nnoremap <leader>tl :tabs<CR>

nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>to :tabonly<CR>
nnoremap <leader>tm :tabmove<CR>

" Редактировать файл в новой вкладке
nnoremap <leader>te :tabedit |

" Выбор вкладки
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<CR>

" Разбиение окон
nnoremap <leader>s :split<CR>
nnoremap <leader>v :vsplit<CR>

" Выбор окна
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Сделать окна одного размера
nnoremap <leader>= <C-w>=

" Переключения между буферами
nnoremap <leader>b :bnext<CR>
nnoremap <leader>B :bprevious<CR>
nnoremap <leader>l :ls<CR>
nnoremap <leader>d :bd<CR>

" Скрыть/раскрыть блок кода
nnoremap <leader>z za

" Добавление и удаление отступов
nnoremap > >>
nnoremap < <<
vnoremap < <gv
vnoremap > >gv

" Сохранение и закрытие
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Сохранить файл с sudo
" https://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cmap w!! w !sudo tee > /dev/null %

" Редактирование конфига
nnoremap <leader>ev :tabedit $MYVIMRC<CR>

" Применить конфиг
nnoremap <leader>sv :so $MYVIMRC<CR>

" Настройки для NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Настройка fzf.vim
" yay -S fzf ripgrep
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6 } }

nnoremap <leader>f :Rg<CR> " Поиск файлов по содержимому
nnoremap <leader>ff :Files<CR> " Поиск файлов
nnoremap <leader>fl :Lines<CR> " Поиск строк в файлах
nnoremap <leader>fb :Buffers<CR> " Поиск буферов


" Настройки для vim-gitgutter
set updatetime=100

" Функция для переключения vim-gutter
function! ToggleGitGutter()
  if exists('g:gitgutter_enabled') && g:gitgutter_enabled
    GitGutterDisable
  else
    GitGutterEnable
  endif
endfunction

" Назначение сочетания клавиш для переключения vim-gutter
nnoremap <leader>gg :call ToggleGitGutter()<CR>
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)


" Настройки для vim-devicons
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

" Настройки для отступов
let g:indent_guides_enable_on_vim_startup = 1

" Настройки для разноцветной подсветки скобок
let g:rainbow_active = 1

" Настройки для vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'onedark'

" Настройки для темы
set termguicolors
set background=dark
color onedark