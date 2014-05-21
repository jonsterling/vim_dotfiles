"-------------------------------------------------------
" Global .vimrc Settings from
" Christian Brabandt <cb@256bit.org>
"
" Last update: Fr 2014-05-02 13:50
"-------------------------------------------------------
" Personal Vim Configuration File
"
" do NOT behave like original vi
" I like vim's  features a lot better
" This is already set automatically by sourcing a .vimrc
" set nocp

" set Unicode if possible
" First, check that the necessary capabilities are compiled-in
" needs to be set first
if has("multi_byte")
        " (optional) remember the locale set by the OS
        let g:locale_encoding = &encoding
        " if already Unicode, no need to change it
        " we assume that an encoding name is a Unicode one
        " iff its name starts with u or U
        if &encoding !~? '^u'
                " avoid clobbering the keyboard's charset
                if &termencoding == ""
                        let &termencoding = &encoding
                endif
                " now we're ready to set UTF-8
                set encoding=utf-8
        endif
        " heuristics for use at file-open
	" how are different fileencodings determined?
	" This is a list. The first that succeeds, will be used
	" default is 'ucs-bom,utf-8,default,latin1'
        set fileencodings=ucs-bom,utf-8,latin9
        " optional: defaults for new files
        "setglobal bomb fileencoding=utf-8
endif

if !empty(glob('$HOME/.vim/autoload/pathogen.vim'))
    " Use pathogen as plugin manager
    call pathogen#infect()
    call pathogen#helptags()
endif
" Always have ~/.vim at first position.
set rtp^=~/.vim
" allow switching of buffers without having to save them
set hidden

" Set the tags file (default is ok)
"set tags=~/tags

" Enable file modelines (default is ok)
set modeline modelines=1

" when joining, prevent inserting an extra space before a .?!
set nojoinspaces

" vi compatible, set $ to line end, when chaning text
set cpo+=$

" prefer a dark background (important to get the colorscheme right)
set bg=dark

" Turn on filetype detection plugin and indent for specific
if exists(":filetype") == 2
    filetype plugin indent on
endif

" Tweak timeouts, because the default is too conservative
" This setting is taken from :h 'ttimeoutlen'
set timeout timeoutlen=3000 ttimeoutlen=100

" Turn on: auto-indent, ruler, show current mode,
"          showmatching brackets, show additional info,
"          show always status line
set ai ruler showmode showmatch wildmenu showcmd ls=2

" Search options: ignore case, increment search, no highlight, smart case
" nostartofline option
set incsearch nohlsearch smartcase nostartofline ignorecase

" show partial lines
set display+=lastline

"whichwrap those keys move the cursor to the next line if at the end of the
"line
set ww=<,>

" when using :scrollbind, also bind scrolling horizontally
set scrollopt+=hor

" use horizontal splits for diff mode
set diffopt+=horizontal

" English messages please
lang mess C
lang ctype C

" how many entries in the commandline history to save
set history=1000

" Use of a .viminfo file
"set viminfo=%,!,'50,\"100,:100
set viminfo=!,'50,n/tmp/viminfo

" Commandline Completion
set wildmode=list:longest,longest:full

if has("gui")
    " Disable the gui (don't need menus, scrollbars, etc...)
    set go=
endif

" Always turn syntax highlighting on
if has("syntax")
    syntax on
    " Matching of IP-Addresses Highlight in yellow
    "highlight ipaddr term=bold ctermfg=yellow guifg=yellow
    " highlight ipaddr ctermbg=green guibg=green
    "match ipaddr /\<\(\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)\.\)\{3\}\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)\>/
    " highlight VCS conflict markers
    match ErrorMsg /^\(<\|=\|>\)\{7\}\([^=].\+\)\?$/

    hi def link WhiteSpaceError Error
    match WhiteSpaceError /[\x0b\x0c\u00a0\u1680\u180e\u2000-\u200a\u2028\u202f\u205f\u3000\ufeff]/

    " highlight all columns > 80 (max. 256 columns)
    " let &colorcolumn=join(range(81,335), ',')

    " Make VertSplit take the same background as Normal
    hi! link VertSplit Normal
    if has("conceal")
	hi! link Conceal Normal
    endif
endif

" Tabstop options
" one tab indents by 8 spaces (this is the default for most display utilities)
" and so it will look like the same
"set ts=8
" softtabstops make you feel, a tab is 4 spaces wide, instead the default
" 8. This means display utilities will still see 8 character wide tabs,
" while in vim, a tab looks like 4 characters
set softtabstop=4
" the amount to indent when using ">>" or autoindent.
set shiftwidth=4
" round indent to multiple of 'sw'
set shiftround

" Set backspace (BS) mode: eol,indent,start
set bs=2

" Display a `+' for wrapped lines
set sbr=+

" Set shell
set sh=zsh

" Numberformat to use, unsetting bascially only allows decimal
" octal and hex may make trouble if tried to increment/decrement
" certain numberformats
" (e.g. 007 will be incremented to 010, because vim thinks its octal)
set nrformats=

"---------------------------------------------
" Keyword completion
"---------------------------------------------
" set dictionary. Press <CTRL>X <CTRL> K for looking up
" use german words, see debian package `wngerman'
set dictionary=/usr/share/dict/words

if has("autocmd")
    au BufRead changes nmap ,cb o<CR>chrisbra, <ESC>:r!LC_ALL='' date<CR>kJo-
endif

"-------------------------------------------------------
" STATUSBAR
" ------------------------------------------------------
"  Disabled:
"  The plugin airline makes an even better status line
if 0
    set laststatus=2
    if has("statusline")
	set statusline=
	set statusline+=%-3.3n\                      " buffer number
	set statusline+=%f\                          " file name
	set statusline+=%h%m%r%w                     " flags
	set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
    "    set statusline+=%{&encoding},                " encoding
	set statusline+=%{(&fenc==\"\"?&enc:&fenc)},
	set statusline+=%{&fileformat}              " file format
	set statusline+=%{(&bomb?\",BOM\":\"\")}]	 " BOM
	set statusline+=%=                           " right align
	"set statusline+=0x%-8B\                      " current char
	set statusline+=%-10.(%l,%c%V%)\ %p%%        " offset
    endif
endif

"---------------------------------------------
" Using Putty for scp on Windows on Windows
"---------------------------------------------
if ($OS =~"Windows")
    let g:netrw_scp_cmd="\"c:\\Program Files\\PuTTY\\pscp.exe\" -q -batch"
endif

"---------------------------------------------
" Vim 7 Features
"---------------------------------------------
if version >= 700
    " Change the disturbing pink color for omnicompletion
    hi Pmenu guibg=DarkRed
    set spellfile=~/.vim/spellfile.add

    " change language -  get spell files from http://ftp.vim.org/pub/vim/runtime/spell/
    " cd ~/.vim/spell && wget http://ftp.vim.org/pub/vim/runtime/spell/de.latin1.spl
    " change to german:
    set spelllang=de,en
    " set maximum number of suggestions listed to top 10 items
    set sps=best,10

    " highlight matching parens:
    " Default for matchpairs: (:),[:],{:},<:>
     set matchpairs+=<:>
     highlight MatchParen term=reverse   ctermbg=7   guibg=cornsilk

    " What to display in the Tabline
    "set tabline=%!MyTabLine()

    " Define :E for opening a new file in a new tab
    command! -nargs=* -complete=file E :tabnew <args>
endif

if has("folding")
    set foldenable foldmethod=marker foldlevelstart=0
endif

if (&term =~ '^screen')
  "if expand("$COLORTERM") !~ 'rxvt'
    set t_Co=256
  "else
  "  set t_Co=88
  "endif
  " set title for screen
  " VimTip #1126
    set title
    set t_ts=k
    set t_fs=\
    let &titleold = fnamemodify(&shell, ":t")
    set titlelen=15
    " set information for title in screen (see :h 'statusline')
    set titlestring=%t%=%<%(\ %{&encoding},[%{&modified?'+':'-'}],%p%%%)
    com! -complete=help -nargs=+ H :!screen -t 'Vim-help' vim -c 'help <args>' -c 'only'
    " Make Vim recognize xterm escape sequences for Page and Arrow
    " keys combined with modifiers such as Shift, Control, and Alt.
    " See http://www.reddit.com/r/vim/comments/1a29vk/_/c8tze8p
    " needs in tmux.conf: setw -g xterm-keys on
    " Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
    execute "set t_kP=\e[5;*~"
    execute "set t_kN=\e[6;*~"

    " Arrow keys http://unix.stackexchange.com/a/34723
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
elseif (&term =~ 'putty\|xterm-256\|xterm-color\|xterm')
    " Let's have 256 Colors. That rocks!
    " Putty and screen are aware of 256 Colors on recent systems
    set t_Co=256 title
    "let &titleold = fnamemodify(&shell, ":t")
    "set t_AB=^[[48;5;%dm
    "set t_AF=^[[38;5;%dm
endif

if !empty(&t_ut)
    " see http://snk.tuxfamily.org/log/vim-256color-bce.html
    " Not neccessary? (see below
    let &t_ut=''
endif

" Set a color scheme. I especially like
" desert and darkblue
if (&t_Co == 256) || (&t_Co == 88) || has("gui_running")
    "if exists("$COLORTERM") && expand("$COLORTERM") =~ "rxvt"
	"set t_Co=88
"	colorscheme elflord
"    else
    "colorscheme desert256
    let g:solarized_termcolors=256
    colors solarized
    " Highlight of Search items is broken in desert256
    "hi Search ctermfg=0 ctermbg=159
"    endif
else
    colorscheme desert
endif

" In Diff-Mode turn off Syntax highlighting
if &diff | syntax off | endif

if has('cscope')
  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif
endif

if has('persistent_undo')
    set undofile
    set undodir=~/.vim/undo/
endif

" Add ellipsis … to the digraphs
" this overwrite the default, but my current font won't display that
" letter anyway ;)
digraphs .3 8230
digraphs -- 8212
digraphs \|- 166

if &encoding == "utf-8"
"    set listchars=eol:$,trail:·,tab:>>·,extends:>,precedes:<
    "set listchars=eol:$,trail:-,tab:>-,extends:>,precedes:<,conceal:+
     exe "set listchars=nbsp:\u2423,conceal:\u22ef,tab:\u2595\u2014,trail:\u02d1,precedes:\u2026,extends:\u2026"
     exe "set fillchars=vert:\u2502,fold:\u2500,diff:\u2014"
else
" Special characters that will be shown, when set list is on
    set listchars=eol:$,trail:-,tab:>-,extends:>,precedes:<,conceal:+
endif

" experimental Setting to force 8 colors mode when this variable is set
if expand("$TEST8COLORTERM")=='1'
    set t_Co=8
    colors default
endif

" This script contains plugin specific settings
source ~/.vim/plugins.vim
" This script contains mappings
source ~/.vim/mapping.vim
source ~/.vim/functions.vim
" For abbreviations read in the following file:
"source ~/.vim/abbrev.vim

" source matchit
ru macros/matchit.vim

" experimental and debug settings
" (possibly not even available in vanilla vim)
" source ~/.vim/experimental.vim

" In case /tmp get's clean out, make a new tmp directory for vim:
if has("user_commands")
  command! Mktmpdir call mkdir(fnamemodify(tempname(),":p:h"),"",0700)
endif

" if ctag or cscope open a file that is already opened elsewhere, make sure to
" open it in Read-Only Mode
" http://groups.google.com/group/vim_use/msg/5a1726ea0fd654d1
if exists("##SwapExists")
    autocmd SwapExists * if v:swapcommand =~ '^:ta\%[g] \|^\d\+G$' | let v:swapchoice='o' | endif
endif

" open file at last position
" :h last-position-jump
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"zvzz" | endif


finish
" DISABLED:
if 0
" use bracketed paste mode for xterm/screen
" also see http://ttssh2.sourceforge.jp/manual/en/usage/tips/vim.html
" does this work also with urxvt?
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif
endif

" Disabled, cause seems to brake something.
" used for bracketed paste mode
if &term == "screen"
    let &t_SI .= "\eP\e[3 q\e\\"
    let &t_EI .= "\eP\e[1 q\e\\"
elseif !exists("$TERMINATOR_UUID")
    " doesn't work with terminator
    let &t_SI .= "\e[3 q"
    let &t_EI .= "\e[1 q"
endif
