symstall:
-----------
- add execution report and a logfile
- install packages
- add "vim +PluginInstall +qall"

printing
--------
- run `sudo systemctl enable --now cups.service`
- install `sudo pacman -Syu ghostscript` to be able to print pdf files

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
- libreoffice
- moc
- mupdf
- neovim
  - uv tool install --upgrade pynvim 
- network-manager-applet
- networkmanager
- networkmanager-openvpn
- openvpn
- pdfgrep
- postman9-bin / atac
- powerline-fonts
- praat
- ranger
- redshift
- ripgrep
- rsync
- sox
- sshfs
- system-config-printer???
- tealdeer
- tmux
- unrar
- unzip
- uv
- vlc
- zathura
- zathura-pdf-mupdf
- zathura-pdf-poppler
- zathura-plugin-djvu

- cargo
- github-cli
- go
- luarocks (`luarocks install luacheck`)
- npm
- nvm
- tree-sitter-cli

# pamac install
- swaykbdd - to enable per-window keyboard layouts
- teams-for-linux

- podofo - pdf manipulation
- pdftk? - not in Fedora
