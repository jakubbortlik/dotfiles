#!/bin/bash
# backup mirrors and rank the new ones

E_XCD=86							# Can't change directory?
DIR=~/comp/arch
cd "$DIR"

# Doublecheck if in right directory
if [ `pwd` != "$DIR" ]				# Not in ~/comp/arch?
then
  echo "Can't change to $DIR."
  exit $E_XCD
fi

# check if the rankmirrors command is available
if command -v rankmirrors >/dev/null 2>&1
then
	if [[ -r "mirrorlist" ]]
	then
		echo "Ranking mirrors..."
		sed 's/#Server/Server/' <mirrorlist >uncommented
		rankmirrors -n 10 uncommented > mirrorlist
		DATE=$(grep -i 'generated on' mirrorlist | grep -oE '[-0-9]+')
		mv mirrorlist mirrorlist_${DATE}
		echo "New mirrorlist created: ${DIR}/mirrorlist_${DATE}."
		echo ""
		echo "For the list to be used by the system do:"
		echo "sudo cp ${DIR}/mirrolist_${DATE} /etc/pacman.d/mirrorlist"
		if [[ -e "uncommented" ]]
		then
			rm uncommented
		fi
    else
		echo "There is no file called mirrorlist in the directory $DIR."
		exit 1
    fi
else
	echo "I require \"rankmirrors\" but it's not installed.  Aborting."
	exit 1
fi

exit
