#!/bin/bash
#test functions

answer (){
	read -p "$1" answer
	case $answer in
	[Yy] | [Yy][Ee][Ss] )
		flag=true
		;;
	[Nn] | [Nn][Oo])
		flag=false
		;;
	* )
		echo "Invalid answer, Abort"
		exit
		;;
	esac
}
flag=true

for entry in "../Data"/*; do
	entry=${entry#"../Data/"}
	if [[ !("$entry" == ??????) ]]; then
		echo "yeah"
		echo "$entry"
	else
		echo "non ci siamo ancora"
		echo "$entry"
	fi
done