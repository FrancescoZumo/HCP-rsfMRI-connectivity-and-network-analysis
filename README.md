# HCP - resting state fMRI - preprocessing

this script has been developed for a research aiming to assess the reliability of functional connectivity measures, derived from resting state test-retest fMRI data.

## Data used
The pipeline has been designed, tested and used with MRI data of 45 young healthy adults, downloaded from the Human Connectome Project (HCP) [Database](https://db.humanconnectome.org).
Each subject data was available in two datasets: [1200 subjects](https://db.humanconnectome.org/data/projects/HCP_1200) and [Retest data](https://db.humanconnectome.org/data/projects/HCP_Retest).

## Preprocessing main steps
- coregistration functional MRI --> structural MRI
- signal segmentation into three main tissues (grey/white matter, cerebrospinal fluid)
- regression of 14 nuisance variables (six motion parameters + their derivatives, mean white matter and cerebrospinal fluid signals)
- frequency filtering with a band-pass of 0.009 < f < 0.08 Hz.
- Eighty-four grey matter cortical/subcortical regions were selected from the individual FreeSurfer brain parcellations (Desikian-Killany atlas).
- These regions were used as masks to extract rs-fMRI time course by averaging the signals of all the voxels within the area.
The output is a 84xvolumes matrix, where volumes is the number of volumes extracted from each subject (maximum: 1200).
- functional reorganization, based on [Schaefer parcellation](https://github.com/ThomasYeoLab/CBIG/tree/master/stable_projects/brain_parcellation/Schaefer2018_LocalGlobal).
regions are grouped by network. 
This function is not yet automatic and needs to be performed after all data has been processed by running the choose_reorganization.sh script 
and then running the main script with the specific parameter (run `.\hcp_preprocessing.sh -h` for all the available options)

## System requirements
- [FMRIB Software Library (FSL)](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation)
- MATLAB (with symbolic link created) with the following toolbox: [Tools for NIfTI and ANALYZE image](https://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image)
- 8GB RAM minimum
- additional 2.5 GB of space for each subject processed
