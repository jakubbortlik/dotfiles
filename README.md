Jakub's Dotfiles
----------------

I am running Manjaro with i3.

How it works
------------
The script ~/dotfiles/bin/symstall looks for files with the extension .sml
and creates links in $HOME with the same directory structure as is found in the
dotfiles/ directory, except it prepends all paths with a "." and cuts off the
.sml suffix.

E.g. for the file ~/dotfiles/vim/ftplugin/tex.vim.sml there will be
created the link in ~/.vim/ftplugin/tex.vim

The script makes numbered backup copies of files in $HOME.

Installing on a new machine:
----------------------------

```bash
git clone git@github.com:jakubbortlik/dotfiles.git ~/dotfiles
cd ~/dotfiles
# edit/add/remove files to and from ~/dotfiles
bash ~/dotfiles/bin/symstall
```

Reinstalling symlinks (when "symstall" is in the $PATH):
--------------------------------------------------------

```bash
symstall
```

Resources:
----------

My dotfiles have been inspired by dotfiles of [Rueben
Ramirez](https://github.com/ruebenramirez/.dotfiles), [Jack
Franklin](https://github.com/jackfranklin/dotfiles), [Zach
Holman](https://github.com/holman/dotfiles), and others
