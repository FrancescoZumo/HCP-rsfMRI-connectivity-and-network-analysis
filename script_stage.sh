#!/bin/bash

#keep it updated!
usage (){
	printf "\nUsage: script

Optional arguments

-p, --path
\tSet a different path to data\n

-h, --help
\tShows usage\n

-i --interactive
\tEnable interactive mode: you can choose which sections will be launched\n
"
}
question (){
	read -p "$1 [Y/n] " answer
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

#Default path to HCP data 
PATH2DATA="../Data"
#will be set true if -i argument is used
interactive=false

#default value, so every section is executed
flag=true

#optional arguments
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
		-i | --interactive )
			interactive=true
			echo "<interactive mode enabled>"
			;;
		* )
			echo "Unknown option, Abort"
			exit
			;;
	esac
	shift
done

#INTERACTIVE : path to Data
if [[ "$interactive" == true ]]; then
	question "current path to Data: $PATH2DATA, 
is it ok?"
fi

if [[ "$flag" == false ]]; then
	read -p "new path: " PATH2DATA
fi

#INTERACTIVE : setting up Data folder
if [[ "$interactive" == true ]]; then
	question "should I set up Data folder?"
fi

if [[ "$flag" == true ]]; then
	#variable for storing the previous and the current subject checked
	current=""
	prev=""
	#creating a folder for each subject
	for entry in "$PATH2DATA"/*; do
		entry=${entry#"$PATH2DATA/"}
		#only 6 digit numbers and files with specified suffix are considered
		if ! [[ ("$entry" == ?????? && "$entry" =~ ^[0-9]+$) || "$entry" == *_3T_rfMRI_REST1_preproc || "$entry" == *_3T_Structural_preproc ]]; then
			echo "$entry ignored"
			continue
		fi

		#check if entry's folder is already set up (just checks the length)
		if ! [[ "$entry" == ?????? ]]; then
			current=${entry:0:6}
			# here I assume that the for cycle orders entries by name, 
			# so I will always get folders from the same subject consecutively
			if [[ $current != $prev ]]; then
				# I store a new subject only if the previous is different
				mkdir $PATH2DATA/$current
			fi
			mv $PATH2DATA/$entry $PATH2DATA/$current
			prev=$current
		fi
	done
fi

#INTERACTIVE : execute code for only one subject
if [[ "$interactive" == true ]]; then
	question "should I execute code for all subjects?"
fi

if [[ "$flag" == true ]]; then
	repeat=true
else
	repeat=false
fi

#commenta molto tutto il codice, spiega parametri scelti x ogni comando e perché lo stai facendo

#repeating all processing for each subject found in Data folder
for subject in "$PATH2DATA"/*; do
	id=${subject#"$PATH2DATA/"}

	#ignore ther files
	if ! [[ "$id" == ?????? && "$id" =~ ^[0-9]+$ ]]; then
		continue
	fi

	#check if subject already has results
	if [[ -d "$subject/results" && "$interactive" == false ]]; then
		echo "${id}'s data has been already processed"
		continue
	fi
	PATH2RES="$subject/results"
	rfMRI=$id_
	mkdir -p $subject/results

	#if SIGINT or SIGTERM is received, results folder is removed before exiting
	trap "mv -f $subject/results $subject/interrupted$$; echo ' pipeline interrupted, results name changed in interrupted$$'; exit" SIGINT SIGTERM

	#saving the path for each file that will be used
	SBRef_dc_T1w="$subject/${id}_3T_rfMRI_REST1_preproc/$id/T1w/Results/rfMRI_REST1_LR/SBRef_dc.nii.gz"
	rfMRI_REST1_LR_SBRef="$subject/${id}_3T_rfMRI_REST1_preproc/$id/MNINonLinear/Results/rfMRI_REST1_LR/rfMRI_REST1_LR_SBRef.nii.gz"
	SBRef_dc="$subject/${id}_3T_rfMRI_REST1_preproc/$id/MNINonLinear/Results/rfMRI_REST1_LR/SBRef_dc.nii.gz"
	T1w_acpc_dc_restore="$subject/${id}_3T_Structural_preproc/$id/T1w/T1w_acpc_dc_restore.nii.gz"
	rfMRI_REST1_LR="$subject/${id}_3T_rfMRI_REST1_preproc/$id/MNINonLinear/Results/rfMRI_REST1_LR/rfMRI_REST1_LR.nii.gz"

	#INTERACTIVE : First section
	if [[ "$interactive" == true ]]; then
		question "$id : start first section?"
	fi

	if [[ "$flag" == true ]]; then

		#fslroi
		#explanation
		printf "\nfslroi $rfMRI_REST1_LR $PATH2RES/rfMRI_REST1_LR_1180.nii.gz 20 -1\n"
		#fslroi $rfMRI_REST1_LR $PATH2RES/rfMRI_REST1_LR_1180.nii.gz 20 -1

		fslroi $rfMRI_REST1_LR $PATH2RES/rfMRI_REST1_LR_part1.nii.gz 20 295
		fslroi $rfMRI_REST1_LR $PATH2RES/rfMRI_REST1_LR_part2.nii.gz 315 295
		fslroi $rfMRI_REST1_LR $PATH2RES/rfMRI_REST1_LR_part3.nii.gz 610 295
		fslroi $rfMRI_REST1_LR $PATH2RES/rfMRI_REST1_LR_part4.nii.gz 905 295
		fslmerge -a $PATH2RES/rfMRI_REST1_LR_1180.nii.gz $PATH2RES/rfMRI_REST1_LR_part1.nii.gz $PATH2RES/rfMRI_REST1_LR_part2.nii.gz $PATH2RES/rfMRI_REST1_LR_part3.nii.gz $PATH2RES/rfMRI_REST1_LR_part4.nii.gz

		#brain extraction
		#these images contain whole head, I need to extract the brain for next operations (epi_reg, applyXFM)
		printf "\nbet $SBRef_dc $PATH2RES/SBRef_dc_brain.nii.gz -R -f 0.65\n"
		# for each bet, after som trials, I selected the best -f value
		bet $SBRef_dc $PATH2RES/SBRef_dc_brain.nii.gz -R -f 0.65
		printf "\nbet $SBRef_dc_T1w $PATH2RES/SBRef_dc_T1w_brain.nii.gz -R -f 0.5\n"
		bet $SBRef_dc_T1w $PATH2RES/SBRef_dc_T1w_brain.nii.gz -R -f 0.5
		printf "\nbet $T1w_acpc_dc_restore $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz -R -f 0.2\n"
		bet $T1w_acpc_dc_restore $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz -R -f 0.2

		#flirt
		#phase one: I want to match the SBRef file from fmri (res=2mm) with the one from sructural space (res=0.7mm)
		#parameters: 12 dof, images: already virtually aligned, cost function: normalized mutual information
		#
		printf "\nflirt -in $PATH2RES/SBRef_dc_brain.nii.gz -ref $PATH2RES/SBRef_dc_T1w_brain.nii.gz -out $PATH2RES/flirt -omat $PATH2RES/flirt.mat -bins 256 -cost normmi -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 12  -interp trilinear\n"
		flirt -in $PATH2RES/SBRef_dc_brain.nii.gz -ref $PATH2RES/SBRef_dc_T1w_brain.nii.gz -out $PATH2RES/flirt -omat $PATH2RES/flirt.mat -bins 256 -cost normmi -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 12  -interp trilinear

		#epi_reg
		#phase two: I want to 
		printf "\nepi_reg --epi=$PATH2RES/SBRef_dc_T1w_brain.nii.gz --t1=$T1w_acpc_dc_restore --t1brain=$PATH2RES/T1w_acpc_dc_restore_brain.nii.gz --out=$PATH2RES/epi2struct\n"
		epi_reg --epi=$PATH2RES/SBRef_dc_T1w_brain.nii.gz --t1=$T1w_acpc_dc_restore --t1brain=$PATH2RES/T1w_acpc_dc_restore_brain.nii.gz --out=$PATH2RES/epi2struct

		#Concatxfm
		printf "\nconvert_xfm -omat $PATH2RES/fmri2T1w_07.mat -concat $PATH2RES/epi2struct.mat $PATH2RES/flirt.mat \n"
		convert_xfm -omat $PATH2RES/fmri2T1w_07.mat -concat $PATH2RES/epi2struct.mat $PATH2RES/flirt.mat 

		#ApplyXFM
		printf "\nflirt -in $rfMRI_REST1_LR_SBRef -applyxfm -init $PATH2RES/fmri2T1w_07.mat -out $PATH2RES/rfMRI_REST1_LR_SBRef_matApplied -paddingsize 0.0 -interp trilinear -ref $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz\n"
		flirt -in $rfMRI_REST1_LR_SBRef -applyxfm -init $PATH2RES/fmri2T1w_07.mat -out $PATH2RES/rfMRI_REST1_LR_SBRef_fmri2T1w -paddingsize 0.0 -interp trilinear -ref $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz

		#viene ucciso!

		#Apply to rfMRI_REST1_LR_1180.nii.gz
		
		#printf "\nflirt -in $PATH2RES/rfMRI_REST1_LR_1180.nii.gz -applyxfm -init $PATH2RES/fmri2T1w_07.mat -out $PATH2RES/rfMRI_REST1_LR_1180_matApplied.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz\n"
		#flirt -in $PATH2RES/rfMRI_REST1_LR_part1.nii.gz -applyxfm -init $PATH2RES/fmri2T1w_07.mat -out $PATH2RES/1180_fmri2T1w_part1.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz
		#flirt -in $PATH2RES/rfMRI_REST1_LR_part2.nii.gz -applyxfm -init $PATH2RES/fmri2T1w_07.mat -out $PATH2RES/1180_fmri2T1w_part2.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz
		#flirt -in $PATH2RES/rfMRI_REST1_LR_part3.nii.gz -applyxfm -init $PATH2RES/fmri2T1w_07.mat -out $PATH2RES/1180_fmri2T1w_part3.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz
		#flirt -in $PATH2RES/rfMRI_REST1_LR_part4.nii.gz -applyxfm -init $PATH2RES/fmri2T1w_07.mat -out $PATH2RES/1180_fmri2T1w_part4.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz
		#fslmerge -t $PATH2RES/1180_fmri2T1w.nii.gz $PATH2RES/1180_fmri2T1w_part1.nii.gz $PATH2RES/1180_fmri2T1w_part2.nii.gz $PATH2RES/1180_fmri2T1w_part3.nii.gz $PATH2RES/1180_fmri2T1w_part4.nii.gz
		
		#rm $PATH2RES/1180_fmri2T1w_part1.nii.gz $PATH2RES/1180_fmri2T1w_part2.nii.gz $PATH2RES/1180_fmri2T1w_part3.nii.gz $PATH2RES/1180_fmri2T1w_part4.nii.gz

	fi

	#INTERACTIVE : Second section
	if [[ "$interactive" == true ]]; then
		question "$id : start second section?"
	fi

	if [[ "$flag" == true ]]; then
		#fast 
		#description
		printf "\nfast $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz\n"
		fast $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz

		#convert_xfm
		#description
		printf "\nconvert_xfm -omat $PATH2RES/T1w207fmri.mat -inverse $PATH2RES/fmri2T1w_07.mat\n"
		convert_xfm -omat $PATH2RES/T1w207fmri.mat -inverse $PATH2RES/fmri2T1w_07.mat

		#mat applied to T1w_brain
		#description
		printf "\nflirt -in $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/T1w_brain2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz\n"
		flirt -in $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/T1w_brain2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz

		#apply inverse mat to PVE_0 : CSF
		#description
		printf "\nflirt -in $PATH2RES/T1w_acpc_dc_restore_brain_pve_0.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/CSF2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz\n"
		flirt -in $PATH2RES/T1w_acpc_dc_restore_brain_pve_0.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/CSF2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz
		
		#apply inverse mat to pve_1 : GM
		#description
		printf "\nflirt -in $PATH2RES/T1w_acpc_dc_restore_brain_pve_1.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/GM2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz\n"
		flirt -in $PATH2RES/T1w_acpc_dc_restore_brain_pve_1.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/GM2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz

		#apply inverse mat to pve_2 : WM
		#description
		printf "\nflirt -in $PATH2RES/T1w_acpc_dc_restore_brain_pve_2.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/WM2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz\n"
		flirt -in $PATH2RES/T1w_acpc_dc_restore_brain_pve_2.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/WM2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz

		#fslmath pve_0
		#description
		printf "\nfslmaths $PATH2RES/CSF2fmri.nii.gz -thr 0.9 -bin $PATH2RES/CSF2fmri_mask\n"
		fslmaths $PATH2RES/CSF2fmri.nii.gz -thr 0.7 -bin $PATH2RES/CSF2fmri_mask

		#fslmaths pve_1
		printf "\nfslmaths $PATH2RES/GM2fmri.nii.gz -thr 0.9 -bin $PATH2RES/GM2fmri_mask\n"
		fslmaths $PATH2RES/GM2fmri.nii.gz -thr 0.7 -bin $PATH2RES/GM2fmri_mask

		#fslmaths pve_2
		printf "\nfslmaths $PATH2RES/WM2fmri.nii.gz -thr 0.9 -bin $PATH2RES/WM2fmri_mask\n"
		fslmaths $PATH2RES/WM2fmri.nii.gz -thr 0.9 -bin $PATH2RES/WM2fmri_mask

		#fslmeants pve_0
		#description
		printf "\nfslmeants -i $PATH2RES/rfMRI_REST1_LR_1180.nii.gz -o $PATH2RES/meants_pve_0.txt -m $PATH2RES/CSF2fmri_mask.nii.gz\n"
		fslmeants -i $PATH2RES/rfMRI_REST1_LR_1180.nii.gz -o $PATH2RES/CSF_meansignal.txt -m $PATH2RES/CSF2fmri_mask.nii.gz

		#fslmeants pve_1
		printf "\nfslmeants -i $PATH2RES/rfMRI_REST1_LR_1180.nii.gz -o $PATH2RES/meants_pve_0.txt -m $PATH2RES/GM2fmri_mask.nii.gz\n"
		fslmeants -i $PATH2RES/rfMRI_REST1_LR_1180.nii.gz -o $PATH2RES/GM_meansignal.txt -m $PATH2RES/GM2fmri_mask.nii.gz

		#fslmeants pve_2
		printf "\nfslmeants -i $PATH2RES/rfMRI_REST1_LR_1180.nii.gz -o $PATH2RES/meants_pve_0.txt -m $PATH2RES/WM2fmri_mask.nii.gz\n"
		fslmeants -i $PATH2RES/rfMRI_REST1_LR_1180.nii.gz -o $PATH2RES/WM_meansignal.txt -m $PATH2RES/WM2fmri_mask.nii.gz


	fi

	#INTERACTIVE : Third section
	if [[ "$interactive" == true ]]; then
		question "$id : start third section?"
	fi

	if [[ "$flag" == true ]]; then
		#remove first 20 lines from Movement_Regressors.txt
		sed '1,20d' "$subject/${id}_3T_rfMRI_REST1_preproc/$id/MNINonLinear/Results/rfMRI_REST1_LR/Movement_Regressors.txt" > $PATH2RES/Movement_Regressors_1180.txt
	

	fi

	#remove partial files remained
	#rm $PATH2RES/rfMRI_REST1_LR_part1.nii.gz $PATH2RES/rfMRI_REST1_LR_part2.nii.gz $PATH2RES/rfMRI_REST1_LR_part3.nii.gz $PATH2RES/rfMRI_REST1_LR_part4.nii.gz

	#when interactive, ask if continue or exit
	if [[ "$repeat" == false ]]; then
		question "subject $id completed, do you want to continue with next subject?"
		if [[ "$flag" == false  ]]; then
			exit
		fi
	fi

done