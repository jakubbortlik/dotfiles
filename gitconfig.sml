[user]
	email = jakub.bortlik@protonmail.com
	name = Jakub Bortlik
[color]
	ui = true
[core]
	editor = nvim
[diff "praat"]
	lextconv = base64
[alias]
	b = branch
	c = commit
	d = diff
	ca = commit -a
	cb = copy-branch-name
	co = checkout
	cm = checkout master
	d = diff
	l = log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative
	ll = log --oneline --graph --all --decorate
	p = push origin HEAD
	pl = pull --prune
	s = status
	sb = status -sb
[credential]
	helper = store
	ctags = !.git/hooks/ctags
[init]
	templatedir = ~/.git_template
[push]
	default = simple
