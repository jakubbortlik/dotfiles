symstall:
-----------
- change ".symlink" into a variable, e.g., ${ext}
- only remove .symlink as an extension, not in file names! change:
		base="${fullbase/\.symlink/}"
		to ${fullbase##.symlink} or something
- add execution report and a logfile

nVim:
-----
```
:set expandtab
```
- repair vim colorscheme + tmux + st - is it broken? jellybeans has got a
  strange combination of default background and hlserach

- italics in latex (as in \textit{} or \emph{})

- adjust "define" in praat.vim

- airline: show the keymap and suspended imode (Ctrl-o) on the statusline

- show the alternate buffer name somewhere

GTK3:
-----
- firefox scroll bar, radio buttons, fields, etc.

tmux:
-----
- airline - lines between >< and the color box...

ranger:
-------
- let the :console source .bashrc
- when entering SHELL, stay in the directory you are leaving

vimperator:
-----------
- make iabbreviate work, e.g. for a phone number

openbox:
--------
- choose custom titles of windows in title bar instead of full path
- keep only CS and US in the keyboard layout handler, have a xkbmap shortcut for IPA
