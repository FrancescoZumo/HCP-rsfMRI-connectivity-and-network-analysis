#!/bin/bash
#discarded from main

usage (){
	printf "\nUsage: script

Optional arguments

-p, --path
\tSet a different path to data\n

-h, --help
\tShows usage\n"
}
#path to folders
rfMRI_folder=""
struct_folder=""

#no arguments --> shows usage
if [[ "$1" == "" ]]; then
	usage
	exit
fi

while [[ "$1" != "" ]]; do
	case $1 in
		-p | --path )
			shift
			PATH2DATA=$1
			;;
		-h | --help )
			usage
			exit
			;;
		*)
			usage
			exit 1
			;;
	esac
	shift
done

#check if directories needed are available

if [[ ! (-d $rfMRI_folder && -d $struct_folder) ]]; then
	echo "folders not available, Abort"
	exit
fi


#old create working_folder
if [[ ! -d $PATH2DATA ]]; then
	mkdir $PATH2DATA
else
	read -p "$PATH2DATA already exists, 
should I use it? [Y/n] " answer
	case $answer in
	[Yy] | [Yy][Ee][Ss] )
		echo "got it"
		;;
	[Nn] | [Nn][Oo])
		n=1;
		PATH2DATA_NEW="$PATH2DATA"
		#iterate while the new name already exists
		while [[ -d $PATH2DATA_NEW ]]; do
			PATH2DATA_NEW="$PATH2DATA$n"
			let "n += 1"
		done
		PATH2DATA="$PATH2DATA_NEW"
		mkdir $PATH2DATA
		echo "'$PATH2DATA' will be the new working directory"
		;;
	* )
		echo "Invalid answer, Abort"
		exit
		;;
	esac
fi