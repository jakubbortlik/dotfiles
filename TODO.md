symstall:
-----------
- correct the argument reference "$@" and variable quoting!
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

- airline: show suspended imode (Ctrl-o) on the statusline

- show the alternate buffer name somewhere

- in imode evaluate mappings after keymap evaluation (e.g., ] -> ) in
  czech_utf-8.vim should not wait for the evaluation of the mapping in
  vimtex-delim-close() or 50_LookupCharacter()

- unimpaired: keep cursor position after ]<Space>

GTK3:
-----
- firefox scroll bar, radio buttons, fields, etc.

ranger:
-------
- let the :console source .bashrc
- find a way to sync bookmarks with the dotfiles .symlink version

vimperator:
-----------
- make iabbreviate work, e.g. for a phone number

openbox:
--------
- choose custom titles of windows in title bar instead of full path (where is it
  set for LXTerminal?
- keep only CS and US in the keyboard layout handler, have a xkbmap shortcut for IPA
- remap CapsLock to Ctrl (and possibly Escape)

latex:
------
- include audio
- harmonize vimtex and vim-latex-suite: autoindent after \footnote{}
- VimtexView - select the right file after another .tex file has been opened

Other:
------
- find out how not to start X but login as a user who has got "startx" in the
  .xinit file
- post a bug report on christoomey/vim-tmux-navigator:
	does not work when "nVim" is started from ranger or Midnight Commander
	(current_command = python/mc)
