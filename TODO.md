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

- adjust "define" in praat.vim

- airline: show the keymap and suspended imode (Ctrl-o) on the statusline

- show the alternate buffer name somewhere

GTK3:
-----
- firefox scroll bar, radio buttons, fields, etc.

ranger:
-------
- let the :console source .bashrc

vimperator:
-----------
- make iabbreviate work, e.g. for a phone number

openbox:
--------
- choose custom titles of windows in title bar instead of full path
- keep only CS and US in the keyboard layout handler, have a xkbmap shortcut for IPA
