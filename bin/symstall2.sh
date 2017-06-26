#!/bin/bash - 
#===============================================================================
#
#          FILE: symstall.sh
# 
#         USAGE: ./symstall.sh 
# 
#   DESCRIPTION: 1. the script cd's to the ~/dotfiles directory, finds all files
#                   with the ".sml" extension and creates links in ${HOME}
#                2. it makes a link for ~/dotfiles/bin if the folder exists
#				 3. it creates links for nvim
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jakub Bortlik jakub.bortlik(a)gmail.com 
#  ORGANIZATION: 
#       CREATED: 06/07/2017 10:55
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

DOTFILES_DIR="${HOME}/dotfiles"

if [[ -d "${DOTFILES_DIR}" ]]; then
	cd "${DOTFILES_DIR}"
else
	echo "The directory ~/dotfiles does not exist."
	exit
fi

if [[ "${PWD}" = "${DOTFILES_DIR}" ]]; then
	echo -e "\nCreating symlinks for .sml files:"
	echo "================================="
	FILES=$(find . -readable -type f -iname "*.sml")
	if [[ "$FILES" == "" ]] ; then
		echo No files with the .sml extension
	fi

	for FILE in $(find . -readable -type f -iname "*.sml") ; do
		FILE_NOPREFIX="${FILE##./}"
		TARGET="${DOTFILES_DIR}/${FILE_NOPREFIX}"
		LINK_NAME="${HOME}/.${FILE_NOPREFIX%%.sml}"
		LINK_DIR="${HOME}/.${FILE_NOPREFIX%%/*}"

		# create missing subdirectories if necessary
		if [[ ! -d "${LINK_DIR}" ]]; then
			echo "Creating directory ${LINK_DIR}"
			echo mkdir --parents "${LINK_DIR}"
		fi

		# Create the symbolic link if it does not exist yet.
		# If there is a file with the same LINK_NAME, but does not link to the
		# same TARGET, back it up with an appended "~N~"
		OLD_TARGET=$(readlink -f "${LINK_NAME}")
		if [[ ! -e "${LINK_NAME}" ]] || [[ "${OLD_TARGET}" != "${TARGET}" ]]; then
			echo ln "$TARGET" "$LINK_NAME"
			# ln --symbolic --backup=numbered --interactive "$TARGET" "$LINK_NAME"
		else
			echo $LINK_NAME - already exists
		fi
	done

	# If the ~/dotfiles/bin directory exists, create a link to it in "$HOME"
	echo -e "\nCreating symlinks for the bin directory:"
	echo "========================================"
	BIN_LINK="${HOME}/.bin"
	BIN_TARGET=$(readlink -f "$BIN_LINK")
	if [[ -d "${DOTFILES_DIR}/bin" ]]; then
		if [[ ! -d "$BIN_LINK" ]] || [[ "${BIN_TARGET}" != "${DOTFILES_DIR}/bin" ]]; then
			ln --no-dereference --symbolic --backup=numbered --interactive "${DOTFILES_DIR}/bin" "$BIN_LINK"
			echo ln --no-dereference  "${DOTFILES_DIR}/bin" "$BIN_LINK"
		else
			echo $BIN_LINK - already exists
		fi
	fi

	# symlinks for neovim:
	NVIM_DIR="${HOME}/.config/nvim"
	echo -e "\nCreating symlinks for nvim:"
	echo "==========================="

	# create missing subdirectories if necessary
	if [[ ! -d "${NVIM_DIR}" ]]; then
		echo "Creating directory ${NVIM_DIR}"
		echo mkdir --parents "${NVIM_DIR}"
	fi

	NVIM_FTPLUGIN="${NVIM_DIR}/ftplugin"
	NF_TARGET="${HOME}/.vim/ftplugin/"
	NVIM_INIT="${NVIM_DIR}/init.vim"
	NI_TARGET="${HOME}/.vimrc"
	OLD_NF_TARGET=$(readlink "$NVIM_FTPLUGIN")
	OLD_NI_TARGET=$(readlink "$NVIM_INIT")

	if [[ ! -e "$NVIM_FTPLUGIN" ]] || [[ "$OLD_NF_TARGET" != "$NF_TARGET" ]]; then
		# ln --symbolic --backup=numbered --interactive "$NF_TARGET" "$NVIM_FTPLUGIN"
		echo ln "$NF_TARGET" "$NVIM_FTPLUGIN"
	else
		echo $NVIM_FTPLUGIN - already exists
	fi

	if [[ ! -e "$NVIM_INIT" ]] || [[ "$OLD_NI_TARGET" != "$NI_TARGET" ]]; then
		# ln --symbolic --backup=numbered --interactive "$NI_TARGET" "$NVIM_INIT"
		echo ln "$NI_TARGET" "$NVIM_INIT"
	else
		echo $NVIM_INIT - already exists
	fi

	echo -e "\nFinished creating symlinks.\n"
else
	echo Cannot cd to "$HOME"/dotfiles
	exit
fi

exit