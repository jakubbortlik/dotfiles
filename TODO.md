symstall:
-----------
- change ".symlink" into a variable, e.g., ${ext}
- only remove .symlink as an extension, not in file names! change:
		base="${fullbase/\.symlink/}"
		to ${fullbase##.symlink} or something
- add execution report and a logfile

nVim:
-----
```bash
:set expandtab
```
- repair vim colorscheme + tmux + st

- asynchronous (e.g. plugin install?)

- ftplugins: let b:did_ftplugin = 1

- ftplugin - xml.vim: :set tabstop=2 shiftwidth=2

- adjust "define" in praat.vim

- airline: show the keymap and suspended imode (Ctrl-o) on the statusline

- ipa_utf-8.vim: v > ʑ!

vimtex:
-------
- enable keybindings like in vim-latex-suite: Alt-i = \item, :: = \dots,...

vim-latex-suite:
----------------
- compiler/tex.vim problem when opening an included bibliography file from a toc
  file

GTK3:
-----
- firefox scroll bar, radio buttons, fields, etc.

simple terminal:
----------------
- enable ctrl-shift-u to insert unicode

tmux:
-----
- if on a large monitor, open two panes on startup the right one with ranger
  opened, else open just one pane with ranger
- airline - lines between >< and the color box...

ranger:
-------
- let the :console source .bashrc
- when entering SHELL, stay in the directory you are leaving

vimperator:
-----------
- make iabbreviate work, e.g. for a phone number

openbox:
- choose custom titles of windows in title bar instead of full path
- keep only CS and US in the keyboard layout handler, have a xkbmap shortcut for IPA
