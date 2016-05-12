#!/bin/bash
# 
# the script cd's to the ~/dotfiles directory, finds all files with the
# ".symlink" extension and creates links in ${HOME}
#
# Further, it makes a link for ~/dotfiles/bin if the folder exists

if [ -d "${HOME}/dotfiles" ]; then
	cd ${HOME}/dotfiles
else
	echo "The directory ~/dotfiles does not exist."
	exit
fi

if [ "${PWD}" = "${HOME}/dotfiles" ]; then
	echo "Installing symlinks"
	link_file() {
		source="${PWD}/${@}"

		# get the relative path to the directory with the file to be linked
		dn=$(dirname ${@})
		if [ "${dn}" = "." ]; then
			# if the file is in ~/dotfiles, do not use any subdirectories
			dir=""
		else
			# if the file is in a subdirectory, make the path complete
			dir="${@%/*}/"
		fi

		# get the full name of the file
		fullbase="${@##*/}"

		# strip the filename of ".symlink"
		base="${fullbase/\.symlink/}"

		# combine the variables to create the target filename for the link
		target="${HOME}/.${dir}${base}"
		targetdir="${target%/*}"

		# create missing subdirectories if necessary
		if [ ! -d "${targetdir}" ]; then
			echo "Creating directory ${targetdir}"
			mkdir -p ${targetdir}
		fi

		# Create the symbolic link if it does not exist yet. If there is a file
		# with the same name, but does not link to the same target, back it up
		# with final "~" (the -b option).
		linktarget=$(readlink -f "${target}")
		if [ ! -e "${target}" ] || [ "${linktarget}" != "${source}" ]; then
			ln -sfb "${source}" "${target}"
		fi
	}
	
	# find recursively all readable regular files with the .symlink extension
	# make sure globstar is enabled for recursive for loop
	shopt -s globstar
	for i in **/*.symlink; do
		if [ -e "${PWD}/${i}" ] && [ -r "${PWD}/${i}" ] && [ ! -d "${PWD}/${i}" ]; then
			link_file "${i}"
		fi
	done

	# create the link to the ~/dotfiles/bin directory if it exists
	linkbin=$(readlink -f "${HOME}/.bin")
	if [ -d "${PWD}/bin" ]; then
		if [ ! -d "${HOME}/.bin" ] || [ "${linkbin}" != "${PWD}/bin" ]; then
			ln -nsfb "${PWD}/bin" "${HOME}/.bin"
		fi
	fi
else
	echo "Cannot cd to ${HOME}/dotfiles"
fi

exit
