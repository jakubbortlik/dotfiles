#Jakub's Dotfiles

I am running Arch Linux with LXDE on a Dell Latitude E6400

How it works
------------
The script install.sh looks for files with the extension .symlink and
creates links in $HOME with the same directory structure as is found in
the dotfiles/ directory, except it prepends all paths with a "." and cuts
off the .symlink suffix.

E.g. for the file ~/dotfiles/vim/ftplugin/tex.vim.symlink there will be
created the link in ~/.vim/ftplugin/tex.vim

The scripts makes backup copies of files in $HOME, however, these will be
rewritten by further backup copies, if you run the script several times,
so you better be sure you want to use the files in ~/dotfiles.

Installing on a new machine:
----------------------------

```bash
git clone git@github.com:jakubbortlik/dotfiles.git ~/dotfiles
cd ~/dotfiles
# edit/add/remove files to and from ~/dotfiles
bash install.sh
```

Resources:
----------

My dotfiles have been inspired by dotfiles of [Rueben
Ramirez](https://github.com/ruebenramirez/.dotfiles), [Jack
Franklin](https://github.com/jackfranklin/dotfiles), [Zach
Holman](https://github.com/holman/dotfiles), and others
