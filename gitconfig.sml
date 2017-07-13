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
	gl = git pull --prune
	glog = git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative
	gp = git push origin HEAD
	gd = git diff
	gc = git commit
	gca = git commit -a
	gco = git checkout
	gcb = git copy-branch-name
	gb = git branch
	gs = git status -sb
	gac = git add -A && git commit -m
