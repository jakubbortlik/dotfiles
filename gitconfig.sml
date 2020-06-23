[user]
	email = jakub.bortlik@gmail.com
	name = Jakub Bortlik
[color]
	ui = true
[core]
	editor = nvim
[diff "praat"]
	lextconv = base64
[alias]
	lol = log --oneline --graph --all --decorate
	pl = pull --prune
	log = log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative
	p = push origin HEAD
	d = diff
	c = commit
	ca = commit -a
	co = checkout
	cb = copy-branch-name
	b = branch
	s = status -sb
	ac = add -A && git commit -m
	ctags = !.git/hooks/ctags
[init]
	templatedir = ~/.git_template
