#!/bin/bash

#keep it updated!
usage (){
	printf "\nUsage: script

Optional arguments

-p, --path
\tSet a different path to data\n

-h, --help
\tShows usage\n"
}

#Default path to HCP data 
PATH2DATA="../Data"

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
		* )
			echo "Unknown option, Abort"
			exit
			;;
	esac
	shift
done

#variable for storing the previous and the current subject checked
current=""
prev=""

#creating a folder for each subject
for entry in "$PATH2DATA"/*; do
	entry=${entry#"$PATH2DATA/"}
	current=${entry:0:6}
	# here I assume that the for cycle orders entries by name, 
	# so I will always get folders from the same subject consecutively
	if [[ $current != $prev ]]; then
		# I store a new subject only if the previous is different
		mkdir $PATH2DATA/$current
	fi
	mv $PATH2DATA/$entry $PATH2DATA/$current
	prev=$current
done

#commenta molto tutto il codice, spiega parametri scelti x ogni comando e perché lo stai facendo

#repeating all processing for each subject found in Data folder
for subject in "$PATH2DATA"/*; do
	id=${entry#"$PATH2DATA/"}
	mkdir $subject/results

	#saving the path for each file that will be used
	SBRef_dc_T1w="$subject/$id_3T_rfMRI_REST1_preproc/$id/T1w/Results/rfMRI_REST1_LR/SBRef_dc.nii.gz"
	#sudo cp -p 102614_3T_rfMRI_REST1_preproc/102614/T1w/Results/rfMRI_REST1_LR/SBRef_dc.nii.gz $PATH2DATA/
	#sudo mv $PATH2DATA/SBRef_dc.nii.gz $PATH2DATA/SBRef_dc_T1w.nii.gz
	rfMRI_REST1_LR_SBRef="$subject/$id_3T_rfMRI_REST1_preproc/$id/MNINonLinear/Results/rfMRI_REST1_LR/rfMRI_REST1_LR_SBRef.nii.gz"
	#sudo cp -p 102614_3T_rfMRI_REST1_preproc/102614/MNINonLinear/Results/rfMRI_REST1_LR/rfMRI_REST1_LR_SBRef.nii.gz $PATH2DATA/ 
	SBRef_dc="$subject/$id_3T_rfMRI_REST1_preproc/$id/MNINonLinear/Results/rfMRI_REST1_LR/SBRef_dc.nii.gz"
	#sudo cp -p 102614_3T_rfMRI_REST1_preproc/102614/MNINonLinear/Results/rfMRI_REST1_LR/SBRef_dc.nii.gz $PATH2DATA/
	T1w_acpc_dc_restore="subject/$id_3T_Structural_preproc/$id/T1w/T1w_acpc_dc_restore.nii.gz"
	#sudo cp -p 102614_3T_Structural_preproc/102614/T1w/T1w_acpc_dc_restore.nii.gz $PATH2DATA/

	#brain extraction

	#these images contain whole head, I need to extract the brain for next operations (epi_reg, applyXFM)
	printf "\nbet $SBRef_dc $subject/results/SBRef_dc_brain.nii.gz -R -f 0.65\n"
	bet $SBRef_dc $subject/results/SBRef_dc_brain.nii.gz -R -f 0.65
	printf "\nbet $SBRef_dc_T1w $subject/results/SBRef_dc_T1w_brain.nii.gz -R -f 0.5\n"
	bet $SBRef_dc_T1w $subject/results/SBRef_dc_T1w_brain.nii.gz -R -f 0.5
	printf "\nbet $T1w_acpc_dc_restore $subject/results/T1w_acpc_dc_restore_brain.nii.gz -R -f 0.2\n"
	bet $T1w_acpc_dc_restore $subject/results/T1w_acpc_dc_restore_brain.nii.gz -R -f 0.2

	#flirt
	printf "flirt -in $subject/results/SBRef_dc_brain.nii.gz -ref $subject/results/SBRef_dc_T1w_brain.nii.gz -out $subject/results/flirt -omat $subject/results/flirt.mat -bins 256 -cost normmi -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 12  -interp trilinear\n"
	flirt -in $subject/results/SBRef_dc_brain.nii.gz -ref $subject/results/SBRef_dc_T1w_brain.nii.gz -out $subject/results/flirt -omat $subject/results/flirt.mat -bins 256 -cost normmi -searchrx 0 0 -searchry 0 0 -searchrz 0 0 -dof 12  -interp trilinear

	#epi_reg
	printf "\nepi_reg --epi=$subject/results/SBRef_dc_T1w_brain.nii.gz --t1=$T1w_acpc_dc_restore --t1brain=$subject/results/T1w_acpc_dc_restore_brain.nii.gz --out=$subject/results/epi2struct\n"
	epi_reg --epi=$subject/results/SBRef_dc_T1w_brain.nii.gz --t1=$T1w_acpc_dc_restore --t1brain=$subject/results/T1w_acpc_dc_restore_brain.nii.gz --out=$subject/results/epi2struct

	#Concatxfm
	printf "convert_xfm -omat $PATH2DATA/epi_reg2flirt.mat -concat $PATH2DATA/flirt.mat $PATH2DATA/epi2struct.mat\n"
	convert_xfm -omat $subject/results/epi_reg2flirt.mat -concat $subject/results/epi2struct.mat $subject/results/flirt.mat 

	#metti questa, sopra ho scambiato e dovrebbe essere giusto, controlla x sicurezza
	#convert_xfm -omat finedef -concat /home/francescozumo/Desktop/working_folder/epi2struct.mat /home/francescozumo/Desktop/working_folder/flirt.mat

	#ApplyXFM
	#contrplla senza percorso assoluto
	printf "flirt -in $subject/results/rfMRI_REST1_LR_SBRef.nii.gz -applyxfm -init $subject/results/epi_reg2flirt.mat -out $subject/results/applyXFM_out -paddingsize 0.0 -interp trilinear -ref $PATH2DATA/T1w_acpc_dc_restore_brain.nii.gz"
	flirt -in $subject/results/rfMRI_REST1_LR_SBRef.nii.gz -applyxfm -init $subject/results/epi_reg2flirt.mat -out $subject/results/applyXFM_out -paddingsize 0.0 -interp trilinear -ref $PATH2DATA/T1w_acpc_dc_restore_brain.nii.gz
done