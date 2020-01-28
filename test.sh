#!/bin/bash

awk '{
    	#FILENAME becomes path
    	sub("/Mov.*", "", FILENAME)

    	#split my matrix in column vectors
        for( i = 1; i <= NF; i++ )
            printf( "%s\n", $(i) ) > FILENAME "/Movement_Regressors_col" i ".txt";

}'  ../Data/102614/results/Movement_Regressors_1180.txt

#remove mean from each column
for (( i = 1; i < 13; i++ )); do
	#calculate sum of all values in file
	sum=$(awk '{ sum += $1 } END { print sum }' ../Data/102614/results/Movement_Regressors_col$i.txt)
	echo "$sum"
	#calculate mean
	mean=$(bc <<< "scale=8;$sum/1180")
	mean="0$mean"
	echo "$mean"
	#maybe useless usage of cat, remove mean by every value in file
	for value in $(cat ../Data/102614/results/Movement_Regressors_col$i.txt); do
		x=$( bc <<< "scale=8; $value - $mean")
		x="0$x"
		echo "$x"
	done > ../Data/102614/results/Movement_Regressors_col${i}_nomean.txt

	#pr -mts , 
done