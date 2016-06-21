#!/bin/bash
# backup mirrors and rank the new ones

DIR="~/comp/arch"
cd $DIR
if [[ -r "mirrorlist" ]]
then
	echo "Ranking mirrors..."
	sed 's/#Server/Server/' <mirrorlist >uncommented
	rankmirrors -n 10 uncommented > mirrorlist
	S=$(grep -i 'generated on' mirrorlist | grep -oE '[-0-9]+')
	mv mirrorlist mirrorlist_$S
	echo "New mirrorlist created."
else
	echo "There is no file called mirrorlist in the directory $DIR."
fi

exit
