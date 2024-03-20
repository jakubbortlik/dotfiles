[user]
	email = jakub.bortlik@proton.me
	name = Jakub Bortlík
[color]
	ui = true
[core]
	editor = nvim
	pager = delta
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
	dc = diff --cached
	l = log --graph --pretty=format:'%Cred%h%Creset %an: %s%Creset%C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative
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
	ba = branch -a
[credential]
	helper = store
[push]
	default = simple
[filter "lfs"]
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
	required = true
[pull]
	rebase = true
[interactive]
	diffFilter = delta --color-only
[delta]
    navigate = true
    light = false
    line-numbers = true
[merge]
    conflictstyle = diff3
[diff]
    colorMoved = default
