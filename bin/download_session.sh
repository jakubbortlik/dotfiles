#!/bin/bash - 
#===============================================================================
#
#          FILE: download_session.sh
# 
#         USAGE: ./download_session.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 05/16/2018 11:31
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# list 21
# list=( 230_1 22A_F 22C_4 231_7 22B_A 229_6 22D_D 22F_F 232_1 )

# list 22 textfiles:
# list=( 222_1 226_A 225_C 21D_8 220_9 228_A 221_B 223_7 )
# list 22 wav:
list=( 224_1 21E_4 21F_D )

if [[ "$1" -eq 23 ]]
then
	# list 23 wav:
	list=( 218_8 213_D 216_1 )

	# list 23 textfiles:
	# list=( 215_9 219_C 21A_A 214_1 212_9 211_2 217_E )

elif [[ $1 -eq 24 ]]
then
	# list 24 wav:
	list=( 20C_C 20A_A 207_E )

	# list 24 textfiles:
	# list=( 20D_5 209_0 206_9 208_5 205_7 20B_1 20E_2 )

elif [[ $1 -eq 25 ]]
then
	# list 25 wav:
	list=( 1D5_B 1D2_C 1D0_C )

	# list 25 textfiles:
	# list=( 1D1_1 1CE_3 1D4_D 1D3_5 1D7_E 1CF_9 1D6_4 )

elif [[ $1 -eq 26 ]]
then
	# list 26 wav:
	list=( 201_E 1FE_C 1FC_C )

	# list 26 textfiles:
	# list=( 1FD_1 200_4 1FB_D 202_9 1FA_3 1FF_5 1F9_9 )

	# list 24-26 textfiles:
	# list=( 20D_5 209_0 206_9 208_5 205_7 20B_1 20E_2 1D1_1 1CE_3 1D4_D 1D3_5 1D7_E 1CF_9 1D6_4 1FD_1 200_4 1FB_D 202_9 1FA_3 1FF_5 1F9_9 )
else
	echo "the adresses for session $1 are not defined"
	exit

fi

for i in {0..10}
do
	# echo "${list[i]}"
	firefox https://archive.mpi.nl/islandora/object/lat%3A1839_00_0000_0000_0016_8"${list[i]}"/datastream/OBJ/download
done

exit
