#!/bin/bash
#
# rmsubfiles.sh - remove all files in current directory and sub-directories
#                 leave empty directories skoleten.
#
# 08/30/2018 by Alex Cheng

PATH_NAME=

function rmfiles()
{
	local localpath=$1
	# echo "CD to DIR $localpath"
	cd $localpath
	rm -f * > /dev/null

######################################
# pretty much can be covered by the lower for loop.
	dirlist=$(ls -d *)
	# echo "DIRLIST $dirlist"
	for dir in $dirlist ; do
		# echo "RECURSIVE to rmfiles $dir"
		rmfiles $dir
	done
######################################
# set +x
	dirlist=$(ls -a)
	# echo "Check hidden directories"
	for dir in $dirlist ; do
		# echo "RECURSIVE to rmfiles $dir"
		if [[ ( ${dir:0:1} == "." ) && ( ${dir:1:1} != "." ) && ( ${dir:1:1} != "" ) ]]; then
			rm $dir
			if [ $? == 1 ]; then
				rmfiles $dir
			fi
		fi
	done
# set +x
	cd ..
}
# set +x
rmfiles $1

# set +x