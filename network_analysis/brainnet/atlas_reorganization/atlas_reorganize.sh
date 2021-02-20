#!/bin/bash

# reorganizing atlas file
rm -f atlas_84regions_reorganized.node
touch atlas_84regions_reorganized.node

while read p; do
	grep "[1-9] [1-9] ${p}" atlas_84regions.node >> atlas_84regions_reorganized.node
done < test_retest_all_reorganization.txt;

#reorganizing network file
rm -f test_retest_chosen_networks_reorganized.txt
touch test_retest_chosen_networks_reorganized.txt

while read n; do
	sed -n "${n}p" < test_retest_chosen_networks.txt >> test_retest_chosen_networks_reorganized.txt
done < test_retest_all_reorganization.txt;

# set networks in atlas file
#while read n; do
#	sed -i 's/[1-9] [1-9] ${p}/new/g' test_retest_chosen_networks_reorganized.txt
#done < test_retest_all_reorganization.txt;