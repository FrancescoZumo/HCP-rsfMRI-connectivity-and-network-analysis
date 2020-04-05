#!/bin/bash

usage (){
	printf "\nUsage: ./script [options]

Optional arguments
 -p <path>, --path <path>\t: set a different path to data folder (current path: $PATH2DATA)
 -v <value>, --volumes <value>\t: number of volumes processed (current: $volumes, max: 1180)
 -hp <value>, --hp_cutoff <value>\t: high pass filter cutoff (default: ${hp_cutoff}Hz)
 -lp <value>, --lp_cutoff <value>\t: low pass filter cutoff (default: ${lp_cutoff}Hz)
 -h, --help\t\t\t: display this page
 -i, --interactive\t\t: enable interactive mode: choose which sections will be launched and see all available settings
 -o, --one_subject\t\t: only one subject is processed\n"
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

# Default path to HCP data 
PATH2DATA="../Data"

# will be set true if -i argument is used
interactive=false

# if == false, only one subject will be processed
repeat=true

# max value: 1200
volumes=400

# variables for filtering
TR=0.782
hp_cutoff=0.009
lp_cutoff=0.08

# default value, so every section is executed
flag=true

# optional arguments
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
		-v | --volumes )
			shift
			volumes=$1
			;;
		-lp | --lp_cutoff )
			shift
			lp_cutoff=$1
			;;
		-hp | --hp_cutoff )
			shift
			hp_cutoff=$1
			;;
		-o | --one_subject )
			repeat=false
			;;
		* )
			echo "Unknown option, Abort"
			exit
			;;
	esac
	shift
done

# INTERACTIVE : path to Data
if [[ "$interactive" == true ]]; then
	question "current path to Data: $PATH2DATA, 
is it ok?"
fi

if [[ "$flag" == false ]]; then
	read -p "new path: " PATH2DATA
fi

# INTERACTIVE : setting up Data folder
if [[ "$interactive" == true ]]; then
	question "should I set up Data folder?"
fi

if [[ "$flag" == true || "$interactive" == false ]]; then
	# variable for storing the previous and the current subject checked
	current=""
	prev=""
	# creating a folder for each subject
	for entry in "$PATH2DATA"/*; do
		entry=${entry#"$PATH2DATA/"}
		# only 6 digit numbers and files with specified suffix are considered
		if ! [[ ("$entry" == ?????? && "$entry" =~ ^[0-9]+$) || "$entry" == *_3T_rfMRI_REST1_preproc || "$entry" == *_3T_Structural_preproc ]]; then
			continue
		fi

		# check if entry's folder is already set up (just checks the length)
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

# INTERACTIVE : volumes
if [[ "$interactive" == true ]]; then
	question "do you want to change the number of volumes processed (current: $volumes, max: 1180)?"
fi

if [[ "$flag" == true && "$interactive" == true ]]; then
	read -p "new value: " ans
	volumes=$ans
fi

# INTERACTIVE : execute code for only one subject
if [[ "$interactive" == true ]]; then
	question "should I execute code for all subjects?"
fi

if [[ "$flag" == true && "$repeat" == true ]]; then
	repeat=true
else
	repeat=false
fi

# commenta molto tutto il codice, spiega parametri scelti x ogni comando e perché lo stai facendo

# repeating all processing for each subject found in Data folder
for subject in "$PATH2DATA"/*; do
	id=${subject#"$PATH2DATA/"}

	# ignore other files
	if ! [[ "$id" == ?????? && "$id" =~ ^[0-9]+$ ]]; then
		continue
	fi

	# check if subject already has results
	if [[ -d "$subject/results" && "$interactive" == false ]]; then
		echo "${id}'s data has been already processed"
		continue
	fi
	# creating results folder
	PATH2RES="$subject/results"
	rfMRI=$id_
	mkdir -p $subject/results

	# if SIGINT or SIGTERM is received, results folder is renamed before exiting
	trap "mv -f $subject/results $subject/results_interrupted$$; echo ' pipeline interrupted, results name changed in results_interrupted$$'; exit" SIGINT SIGTERM

	# saving the path for each file that will be used
	SBRef_dc_T1w="$subject/${id}_3T_rfMRI_REST1_preproc/$id/T1w/Results/rfMRI_REST1_LR/SBRef_dc.nii.gz"
	rfMRI_REST1_LR_SBRef="$subject/${id}_3T_rfMRI_REST1_preproc/$id/MNINonLinear/Results/rfMRI_REST1_LR/rfMRI_REST1_LR_SBRef.nii.gz"
	SBRef_dc="$subject/${id}_3T_rfMRI_REST1_preproc/$id/MNINonLinear/Results/rfMRI_REST1_LR/SBRef_dc.nii.gz"
	T1w_acpc_dc_restore="$subject/${id}_3T_Structural_preproc/$id/T1w/T1w_acpc_dc_restore.nii.gz"
	rfMRI_REST1_LR="$subject/${id}_3T_rfMRI_REST1_preproc/$id/MNINonLinear/Results/rfMRI_REST1_LR/rfMRI_REST1_LR.nii.gz"
	aparcPlusaseg="$subject/${id}_3T_Structural_preproc/${id}/T1w/aparc+aseg.nii.gz"

	# INTERACTIVE : First section
	if [[ "$interactive" == true ]]; then
		question "$id : start 1st section - creating frmi2T1W.mat ?"
	fi

	if [[ "$flag" == true ]]; then

		echo "subject ${id}: started"

		# removing first 20 volumes, to remove instrumental error
		printf "\nfslroi $rfMRI_REST1_LR $PATH2RES/rfMRI_REST1_LR_1180.nii.gz 20 1180\n" 
		
		# this operation is divided in two parts, but you can uncomment the next line and comment/remove the following four
		#fslroi $rfMRI_REST1_LR $PATH2RES/rfMRI_REST1_LR_1180.nii.gz 20 1180

		fslroi $rfMRI_REST1_LR $PATH2RES/rfMRI_REST1_LR_part1.nii.gz 20 600
		fslroi $rfMRI_REST1_LR $PATH2RES/rfMRI_REST1_LR_part2.nii.gz 620 580
		fslmerge -a $PATH2RES/rfMRI_REST1_LR_1180.nii.gz $PATH2RES/rfMRI_REST1_LR_part1.nii.gz $PATH2RES/rfMRI_REST1_LR_part2.nii.gz
		rm $PATH2RES/rfMRI_REST1_LR_part1.nii.gz $PATH2RES/rfMRI_REST1_LR_part2.nii.gz


		# extracting volumes that will be processed ($volumes)
		printf "\nfslroi $PATH2RES/rfMRI_REST1_LR_1180.nii.gz $PATH2RES/rfMRI_REST1_LR_${volumes}.nii.gz 0 $volumes\n" 
		fslroi $PATH2RES/rfMRI_REST1_LR_1180.nii.gz $PATH2RES/rfMRI_REST1_LR_${volumes}.nii.gz 0 $volumes
		
		# Brain extraction
		# these images contain whole head, I need to extract the brain for next operations (epi_reg, applyXFM)
		# for each bet, after som trials, I selected the best threshold value (-f)
		printf "\nbet $SBRef_dc $PATH2RES/SBRef_dc_brain.nii.gz -R -f 0.65\n"
		bet $SBRef_dc $PATH2RES/SBRef_dc_brain.nii.gz -R -f 0.65
		printf "\nbet $SBRef_dc_T1w $PATH2RES/SBRef_dc_T1w_brain.nii.gz -R -f 0.5\n"
		bet $SBRef_dc_T1w $PATH2RES/SBRef_dc_T1w_brain.nii.gz -R -f 0.5
		printf "\nbet $T1w_acpc_dc_restore $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz -R -f 0.2\n"
		bet $T1w_acpc_dc_restore $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz -R -f 0.2

		# flirt
		# phase one: I want to match the SBRef file from fmri (res=2mm) with the one from sructural space (res=0.7mm)
		# parameters: 12 dof, images: already virtually aligned, cost function: normalized mutual information
		printf "\nflirt -in $PATH2RES/SBRef_dc_brain.nii.gz -ref $PATH2RES/SBRef_dc_T1w_brain.nii.gz -out $PATH2RES/flirt -omat $PATH2RES/flirt.mat -bins 256 -cost normmi -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 12  -interp trilinear\n"
		flirt -in $PATH2RES/SBRef_dc_brain.nii.gz -ref $PATH2RES/SBRef_dc_T1w_brain.nii.gz -out $PATH2RES/flirt -omat $PATH2RES/flirt.mat -bins 256 -cost normmi -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 12  -interp trilinear

		# epi_reg
		# phase two: now I want to match SBRef (res=0.7mm) with T1w_acpc_dc_restore image. 
		# parameters: 6dof
		# I expect lower values since both images have the same resolution and are in the same space (T1w)
		printf "\nepi_reg --epi=$PATH2RES/SBRef_dc_T1w_brain.nii.gz --t1=$T1w_acpc_dc_restore --t1brain=$PATH2RES/T1w_acpc_dc_restore_brain.nii.gz --out=$PATH2RES/epi2struct\n"
		epi_reg --epi=$PATH2RES/SBRef_dc_T1w_brain.nii.gz --t1=$T1w_acpc_dc_restore --t1brain=$PATH2RES/T1w_acpc_dc_restore_brain.nii.gz --out=$PATH2RES/epi2struct

		# Concatxfm - in order to obtain fmri2T1w.mat, I have to concatenate the previous two matrices
		printf "\nconvert_xfm -omat $PATH2RES/fmri2T1w_07.mat -concat $PATH2RES/epi2struct.mat $PATH2RES/flirt.mat \n"
		convert_xfm -omat $PATH2RES/fmri2T1w_07.mat -concat $PATH2RES/epi2struct.mat $PATH2RES/flirt.mat 

		#ApplyXFM - applying matrix to rfMRI_REST1_LR_SBRef_fmri2T1w
		printf "\nflirt -in $rfMRI_REST1_LR_SBRef -applyxfm -init $PATH2RES/fmri2T1w_07.mat -out $PATH2RES/rfMRI_REST1_LR_SBRef_matApplied -paddingsize 0.0 -interp trilinear -ref $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz\n"
		flirt -in $rfMRI_REST1_LR_SBRef -applyxfm -init $PATH2RES/fmri2T1w_07.mat -out $PATH2RES/rfMRI_REST1_LR_SBRef_fmri2T1w -paddingsize 0.0 -interp trilinear -ref $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz

		
		# the operation below needs high specs to be performed
		
		#Apply to rfMRI_REST1_LR_1180.nii.gz
		#printf "\nflirt -in $PATH2RES/rfMRI_REST1_LR_1180.nii.gz -applyxfm -init $PATH2RES/fmri2T1w_07.mat -out $PATH2RES/rfMRI_REST1_LR_1180_matApplied.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz\n"
		#flirt -in $PATH2RES/rfMRI_REST1_LR_1180.nii.gz -applyxfm -init $PATH2RES/fmri2T1w_07.mat -out $PATH2RES/rfMRI_REST1_LR_1180_2T1w.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz
	fi
	
	#INTERACTIVE : 2nd section
	if [[ "$interactive" == true ]]; then
		question "$id : start 2nd section - obtaining CSF/WM/GM_meansignal?"
	fi

	if [[ "$flag" == true ]]; then
		# FAST 
		# (FMRIB's Automated Segmentation Tool) segments a 3D image of the brain into three dfferent tissue types (Grey Matter, White Matter, CSF)
		printf "\nfast $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz\n"
		fast $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz

		# convert_xfm
		# obtaining inverse matrix from fmri2T1w_07.mat --> T1w207fmri.mat 
		printf "\nconvert_xfm -omat $PATH2RES/T1w207fmri.mat -inverse $PATH2RES/fmri2T1w_07.mat\n"
		convert_xfm -omat $PATH2RES/T1w207fmri.mat -inverse $PATH2RES/fmri2T1w_07.mat

		# applyxfm 

		# applying T1w207fmri.mat to T1w_brain
		printf "\nflirt -in $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/T1w_brain2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz\n"
		flirt -in $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/T1w_brain2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz

		# applying T1w207fmri.mat to T1w_acpc_dc_restore_brain_pve_0.nii.gz : CSF
		printf "\nflirt -in $PATH2RES/T1w_acpc_dc_restore_brain_pve_0.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/CSF2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz\n"
		flirt -in $PATH2RES/T1w_acpc_dc_restore_brain_pve_0.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/CSF2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz
		
		# applying T1w207fmri.mat to T1w_acpc_dc_restore_brain_pve_1.nii.gz : GM
		printf "\nflirt -in $PATH2RES/T1w_acpc_dc_restore_brain_pve_1.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/GM2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz\n"
		flirt -in $PATH2RES/T1w_acpc_dc_restore_brain_pve_1.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/GM2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz

		# applying T1w207fmri.mat to T1w_acpc_dc_restore_brain_pve_2.nii.gz : WM
		printf "\nflirt -in $PATH2RES/T1w_acpc_dc_restore_brain_pve_2.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/WM2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz\n"
		flirt -in $PATH2RES/T1w_acpc_dc_restore_brain_pve_2.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/WM2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz

		# creating a binary mask for each tissue (CSF, GM, WM)
		#fslmaths pve_1
		printf "\nfslmaths $PATH2RES/CSF2fmri.nii.gz -thr 0.9 -bin $PATH2RES/CSF2fmri_mask\n"
		fslmaths $PATH2RES/CSF2fmri.nii.gz -thr 0.7 -bin $PATH2RES/CSF2fmri_mask

		#fslmaths pve_1
		printf "\nfslmaths $PATH2RES/GM2fmri.nii.gz -thr 0.9 -bin $PATH2RES/GM2fmri_mask\n"
		fslmaths $PATH2RES/GM2fmri.nii.gz -thr 0.7 -bin $PATH2RES/GM2fmri_mask

		#fslmaths pve_2
		printf "\nfslmaths $PATH2RES/WM2fmri.nii.gz -thr 0.9 -bin $PATH2RES/WM2fmri_mask\n"
		fslmaths $PATH2RES/WM2fmri.nii.gz -thr 0.9 -bin $PATH2RES/WM2fmri_mask

		# fslmeants P
		# prints average timeseries (intensities) to the screen (in this case, results are saved to a file). 
		# The average is taken over all voxels in the mask (or all voxels in the image if no mask is specified).
		# fslmeants pve_0
		printf "\nfslmeants -i $PATH2RES/rfMRI_REST1_LR_1180.nii.gz -o $PATH2RES/meants_pve_0.txt -m $PATH2RES/CSF2fmri_mask.nii.gz\n"
		fslmeants -i $PATH2RES/rfMRI_REST1_LR_1180.nii.gz -o $PATH2RES/CSF_meansignal.txt -m $PATH2RES/CSF2fmri_mask.nii.gz

		#fslmeants pve_1
		printf "\nfslmeants -i $PATH2RES/rfMRI_REST1_LR_1180.nii.gz -o $PATH2RES/meants_pve_0.txt -m $PATH2RES/GM2fmri_mask.nii.gz\n"
		fslmeants -i $PATH2RES/rfMRI_REST1_LR_1180.nii.gz -o $PATH2RES/GM_meansignal.txt -m $PATH2RES/GM2fmri_mask.nii.gz

		#fslmeants pve_2
		printf "\nfslmeants -i $PATH2RES/rfMRI_REST1_LR_1180.nii.gz -o $PATH2RES/meants_pve_0.txt -m $PATH2RES/WM2fmri_mask.nii.gz\n"
		fslmeants -i $PATH2RES/rfMRI_REST1_LR_1180.nii.gz -o $PATH2RES/WM_meansignal.txt -m $PATH2RES/WM2fmri_mask.nii.gz

	fi

	#INTERACTIVE : 3rd section
	if [[ "$interactive" == true ]]; then
		question "$id : start 3rd section - noisance regression?"
	fi

	if [[ "$flag" == true ]]; then

		# remove first 20 lines from Movement_Regressors.txt
		sed '1,20d' "$subject/${id}_3T_rfMRI_REST1_preproc/$id/MNINonLinear/Results/rfMRI_REST1_LR/Movement_Regressors.txt" > $PATH2RES/Movement_Regressors_1180.txt
		
		# copy matlab script in resources folder
		cp regressors.m $PATH2RES/regressors.m

		# with matlab
		# this script removes mean from every column and adds CSf and WM columns
		# matlab -nodisplay -nosplash -nodesktop -r "run('$PATH2RES/regressors.m');exit;" | tail -n +11
		printf "\nremoving mean from regressors with regressors.m\n"
		matlab -nodisplay -nosplash -nodesktop -r "cd('$PATH2RES'); regressors($volumes);exit" | tail -n +11

		# Use the Text2Vest tool, bundled with FSL, to convert the data into the format used by FSL
		Text2Vest $PATH2RES/Regressors.txt $PATH2RES/design.mat
		
		# fsl_glm, applying general linear model
		echo "fsl_glm -i $PATH2RES/rfMRI_REST1_LR_${volumes}.nii.gz -d  $PATH2RES/design.mat -o $PATH2RES/betas --out_res=$PATH2RES/rfMRI_REST1_LR_${volumes}_reg.nii.gz"
		fsl_glm -i $PATH2RES/rfMRI_REST1_LR_${volumes}.nii.gz -d  $PATH2RES/design.mat -o $PATH2RES/betas --out_res=$PATH2RES/rfMRI_REST1_LR_${volumes}_reg.nii.gz
	fi

	#INTERACTIVE : 4th section
	if [[ "$interactive" == true ]]; then
		question "$id : start 4th section - Filtering?"
	fi

	if [[ "$flag" == true ]]; then

		# Implementing Band Pass filter 0.009-0.08Hz

		# INTERACTIVE : filter frequencies
		if [[ "$interactive" == true ]]; then
			question "hp_cutoff = ${hp_cutoff}Hz, lp_cutoff = ${lp_cutoff}Hz, do you want to change the values (negative value = ignore filter)?"
		fi

		if [[ "$flag" == true && "$interactive" == true ]]; then
			read -p "hp_cutoff= " ans
			hp_cutoff=$ans
			read -p "lp_cutoff= " ans
			lp_cutoff=$ans
		fi
		
		printf "\n filtering with hp_cutoff = ${hp_cutoff}Hz, lp_cutoff = ${lp_cutoff}Hz\n"

		# sigma = 1/(2*TR*cutoff_in_hz), obtained with bc
		hp_sigma=$( bc <<< "scale=8; 1/(2 * $TR * $hp_cutoff)" )
		# bash doesn't handle float numbers, so I have to add 0 to values < 1
		if [[ $hp_sigma == .* ]]; then
			hp_sigma="0$hp_sigma"
		elif [[ $hp_sigma == -* ]]; then
			hp_sigma="-1"
		fi
		
		# same for low pass filter
		lp_sigma=$( bc <<< "scale=8; 1/(2 * $TR * $lp_cutoff)" )
		if [[ $lp_sigma == .* ]]; then
			lp_sigma="0$lp_sigma"
		elif [[ $lp_sigma == -* ]]; then
			lp_sigma="-1"
		fi

		# extracting Tmean from rfMRI
		printf "\nfslmaths $PATH2RES/rfMRI_REST1_LR_${volumes}_reg.nii.gz -Tmean $PATH2RES/rfMRI_REST1_LR_${volumes}_Tmean.nii.gz\n"
		fslmaths $PATH2RES/rfMRI_REST1_LR_${volumes}_reg.nii.gz -Tmean $PATH2RES/rfMRI_REST1_LR_${volumes}_Tmean.nii.gz

		# Filtering rfMRI (fslmaths removes Tmean before filtering)
		printf "\nfslmaths $PATH2RES/rfMRI_REST1_LR_${volumes}_noTmean.nii.gz -bptf $hp_sigma $lp_sigma $PATH2RES/rfMRI_REST1_LR_${volumes}_filtered_noTmean.nii.gz\n"
		fslmaths $PATH2RES/rfMRI_REST1_LR_${volumes}_reg.nii.gz -bptf $hp_sigma $lp_sigma $PATH2RES/rfMRI_REST1_LR_${volumes}_filtered_noTmean.nii.gz

		# adding mean to filtered rfMRI
		printf "\nfslmaths $PATH2RES/rfMRI_REST1_LR_${volumes}_filtered_noTmean.nii.gz -add $PATH2RES/rfMRI_REST1_LR_${volumes}_Tmean.nii.gz $PATH2RES/rfMRI_REST1_LR_${volumes}_filtered.nii.gz\n"
		fslmaths $PATH2RES/rfMRI_REST1_LR_${volumes}_filtered_noTmean.nii.gz -add $PATH2RES/rfMRI_REST1_LR_${volumes}_Tmean.nii.gz $PATH2RES/rfMRI_REST1_LR_${volumes}_filtered.nii.gz
	fi

	#INTERACTIVE : 5rd section
	if [[ "$interactive" == true ]]; then
		question "$id : start 5th section - clustering?"
	fi

	if [[ "$flag" == true ]]; then

		#registering atlas aparc+aseg from T1w to rfmri with T1w207fmri.mat
		printf "\nflirt -in $PATH2RES/T1w_acpc_dc_restore_brain.nii.gz -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/T1w_brain2fmri.nii.gz -paddingsize 0.0 -interp trilinear -ref $PATH2RES/SBRef_dc_brain.nii.gz\n"
		flirt -in $aparcPlusaseg -applyxfm -init $PATH2RES/T1w207fmri.mat -out $PATH2RES/aparc+aseg2fmri.nii.gz -paddingsize 0.0 -interp nearestneighbour -ref $PATH2RES/SBRef_dc_brain.nii.gz


		# extract 1 volume from rfMRI file to create binary mask
		printf "\n$PATH2RES/rfMRI_REST1_LR_${volumes}_filtered.nii.gz $PATH2RES/rfMRI_REST1_LR_1_filtered.nii.gz 0 1\n"
		fslroi $PATH2RES/rfMRI_REST1_LR_${volumes}_filtered.nii.gz $PATH2RES/rfMRI_REST1_LR_1_filtered.nii.gz 0 1

		# Creating a binary mask for the standard MNI
		printf "\nfslmaths $PATH2RES/rfMRI_REST1_LR_1_filtered.nii.gz -bin -thr 0 $PATH2RES/rfMRI_REST1_LR_bin.nii.gz\n"
		fslmaths $PATH2RES/rfMRI_REST1_LR_1_filtered.nii.gz -bin -thr 0 $PATH2RES/rfMRI_REST1_LR_bin.nii.gz
		echo done

		# Applying a binary mask
		printf "\nfslmaths $PATH2RES/aparc+aseg2fmri.nii.gz -mas $PATH2RES/rfMRI_REST1_LR_bin.nii.gz $PATH2RES/aparc+aseg2fmri_mask.nii.gz\n"
		fslmaths $PATH2RES/aparc+aseg2fmri.nii.gz -mas $PATH2RES/rfMRI_REST1_LR_bin.nii.gz $PATH2RES/aparc+aseg2fmri_mask.nii.gz

		# copying matlab script in resources folder
		cp clusters.m $PATH2RES/clusters.m
		cp label_conversion.csv $PATH2RES/label_conversion.csv

		# this matlab script converts current labels with fs_standard.txt labels and removes unused regins
		# open clusters.m for more details
		printf "\nrunning clusters.m\n"
		matlab -nodisplay -nosplash -nodesktop -r "cd('$PATH2RES'); clusters('aparc+aseg2fmri_mask.nii.gz');exit" | tail -n +11

		# meants for each roi
		printf "\nfslmeants -i $PATH2RES/rfMRI_REST1_LR_${volumes}_filtered.nii.gz -o $PATH2RES/meants.txt --label=$PATH2RES/atlas_84regions.nii.gz\n"
		fslmeants -i $PATH2RES/rfMRI_REST1_LR_${volumes}_filtered.nii.gz -o $PATH2RES/${id}_meants.txt --label=$PATH2RES/atlas_84regions.nii.gz

		printf "\nsubject $id : completed!\n"
		if [[ "$repeat" == false ]]; then
			break
		fi
	fi
done