symstall:
-----------
- add execution report and a logfile
- install packages
- add "vim +PluginInstall +qall"

printing
--------
- run `sudo systemctl enable --now cups.service`

Neovim:
-----
- in imode evaluate mappings after keymap evaluation (e.g., ] -> ) in
  czech_utf-8.vim should not wait for the evaluation of the mapping in
  vimtex-delim-close() or 50_LookupCharacter()

- unimpaired: keep cursor position after ]<Space>

ranger:
-------
- let the :console source .bashrc
- find a way to sync bookmarks with the dotfiles .sml version

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
- audacity
- bash-completion
- bat
- caca-utils
- coreutils
- ctags
- cups
- deno
- docker
- docker-compose
- dust
- fd
- ffmpeg
- firefox
- fzf
- gimp
- git-delta
- git-lfs
- glab
- inkscape
- jq
- k6
- klavaro
- libreoffice
- man-db
- man-pages
- mlocate
- moc
- mtpaint
- mupdf
- neovim
- network-manager-applet
- networkmanager
- networkmanager-openvpn
- openvpn
- pdfgrep
- postman9-bin
- powerline-fonts
- praat
- ranger + libcaca (Color AsCii Art library) + highlight
- redshift
- ripgrep
- rsync
- skype???
- skypeforlinux-stable-bin???
- sox
- sshfs
- system-config-printer???
- tealdeer
- teams-for-linux
- texlive
- texlive-beamer
- texlive-biber
- texlive-bibtex
- texlive-latexmk
- texlive-nag
- texlive-pdfjam
- thunderbird
- tmux
- unrar
- unrar-free
- unzip
- vlc
- zathura
- zathura-pdf-mupdf
- zathura-pdf-poppler
- zathura-plugin-djvu
- zoom

- cargo
- go
- luarocks (`luarocks install luacheck`)
- npm
- nvm
- tree-sitter-cli
 
- podofo - pdf manipulation
- pdftk? - not in Fedora
