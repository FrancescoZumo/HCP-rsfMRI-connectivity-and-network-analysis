#!/bin/bash

# copy standard file with no values
cp atlas_reorganization/atlas_84regions_reorganized.node temp.node

# pattern to be replaced with values
pattern="&"

# 
while read p; do
  value=$p
  #sed -i 's/'$pattern'/'$value'/' temp.node
  sed -i '0,/'$pattern'/s//'$value'/' temp.node   # change only the first match
done < values.txt