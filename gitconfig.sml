[user]
	email = jakub.bortlik@proton.me
	name = Jakub Bortlik
[color]
	ui = true
[core]
	editor = /home/jakub/bin/nvim.appimage
[diff "praat"]
	lextconv = base64
[alias]
	b = branch
	c = commit
	ca = commit -a
	cb = copy-branch-name
	co = checkout
	com = checkout master
	con = checkout main
	d = diff
	l = log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative
	ll = log --oneline --graph --all --decorate
    m = merge
	p = push origin HEAD
	pl = pull --prune
	pr = pull --rebase
    rom = rebase origin/main
    rpo = remote prune origin
	s = status
	sb = status -sb
    w = worktree
[credential]
	helper = store
	ctags = !.git/hooks/ctags
[init]
	templatedir = ~/.git_template
[push]
	default = simple
[filter "lfs"]
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
	required = true
