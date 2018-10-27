symstall:
-----------
- add execution report and a logfile
- install packages
- add "vim +PluginInstall +qall"

nVim:
-----
```
:set expandtab
```

- adjust "define" in praat.vim

- airline: show suspended imode, e.g. -- (insert) -- (Ctrl-o) on the statusline

- show the alternate buffer name somewhere

- in imode evaluate mappings after keymap evaluation (e.g., ] -> ) in
  czech_utf-8.vim should not wait for the evaluation of the mapping in
  vimtex-delim-close() or 50_LookupCharacter()

- unimpaired: keep cursor position after ]<Space>

- ToggleTrueFalse - use cursor column to change a particular value when there
  are more on one line

python:
-------
- python-mode in vim


GTK3:
-----
- firefox scroll bar, radio buttons, fields, etc.

ranger:
-------
- let the :console source .bashrc
- find a way to sync bookmarks with the dotfiles .sml version

openbox:
--------
- choose custom titles of windows in title bar instead of full path (where is it
  set for LXTerminal?
- keep only CS and US in the keyboard layout handler, have a xkbmap shortcut for IPA
- remap CapsLock to Ctrl (and possibly Escape)
- highlight the active window's icon on the panel
- show focused window
- show preview when cycling windows with Alt-Tab

latex:
------
install latexmk, xelatex, bibtex
- include audio
- harmonize vimtex and vim-latex-suite: autoindent after \footnote{}
- VimtexView - select the right file after another .tex file has been opened
- biblatex - multiple works in one parenthesis, \autocite[15]{lass}[16]{brown}
		   - main.tex|| Package biblatex Warning: 'labeldate' option used to
			 determine whether to provide label date fields and extrayear field
			 is renamed to 'labeldateparts', setting this instead. This option
			 is now used to set the format of the labeldate.
		   - main.tex|| Package biblatex Warning: '\name' is deprecated in
			 sorting specifications, please use '\field'.
- replace tabs with spaces (expandtab?)
- enable <c-space> in for replacing <++> imode

libreoffice:
------------
- shortcuts for:
	- opening the menu at cursor
	- close find bar with <c-[>

debugger:
---------
GDB - the GNU Project Debugger

Tmux:
-----
unbind C-b
set -g prefix `
bind-key ` send-prefix

In .tmux.conf I also have bind-key C-a set-option -g prefix C-a. Whenever I need
to use backticks I hit `-Ctrl-a which sets my prefix to C-a. And I have bind-key
C-b set-option -g prefix ` so I can hit C-a-C-b to go back

Other:
------
- disable graphical login to Fedora
- find out how not to start X but login as a user who has got "startx" in the
  .xinit file
- post a bug report on christoomey/vim-tmux-navigator:
	does not work when "nVim" is started from ranger or Midnight Commander
	(current_command = python/mc)
- write script for toggling settings for a night/day shift
- remdi doesn't work when there are spaces in the file name

Packages to install:
--------------------
airline
audacity
baobab - disk management
biber
bibletime
caca-utils
ctl 	# for the visualalisation in git
firefox
*flashplugin
flash-player-properties???
*fluidsynth
galculator
gimp
gmrun	# application starter (Ctrl-R)
gucharmap
inkscape
klavaro
lame
leafpad
libreoffice
*lilypond
man-db
man-pages
mlocate
moc
mtpaint
mupdf
*neovim
noto-fonts?
noto-fonts-cjk?
*nvidia
noto-fonts-emoji?
*pdfgrep
obconf - openbox configuration manager??
perl-biber
perl-rename
powerline-fonts
praat
*python-neovim
r-core
ranger + libcaca (Color AsCii Art library) + highlight
*redshift
rosegarden
rstudio??
rsync
rxvt-unicode??
scrot
skype
slock
smplayer
sox
system-config-printer???
texlive
texlive-latexmk
texlive-beamer
texlive-biber
texlive-bibtex
texlive-nag
texlive-pdfjam
*tcl??
*timidity++
tk		# for the visualalisation in git
*tmux
ttf-bitstream-vera
ttf-dejavu
ttf-droid
ttf-liberation
tuxguitar??
*unetbootin
unrar
unzip
*vim-latexsuite
xfce4-power-manager-settings??
xpad
w3m
w3m-inline-image
*wine
xorg-xev?
*zathura
*zathura-pdf-mupdf
*zathura-plugin-djvu

podofo - pdf manipulation
pdftk? - not in Fedora
tox - aur?
