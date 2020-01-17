#!/bin/bash
#test functions

#regressors + CSF + WM
#awk '{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12}' ../*.txt > collapsed_output.txt
#awk -F " " '{print $1" "}' ../*.txt > ../collapsed_output.txt

#works! need to save result in file

for (( i = 0; i < 20; i++ )); do
	x=$(printf "%02d" $i)
	echo $x
done