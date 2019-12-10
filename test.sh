#!/bin/bash
#test functions

#trap "{ rm -f $LOCKFILE ; echo results removed;exit ; }" SIGINT SIGTERM
trap "echo ' pipeline interrupted, results removed from subject'; exit" SIGINT SIGTERM
echo "pid $$"
while :
do
	sleep 60
done




a="123456"
#test if a is a number
if [[ "$a" =~ ^[0-9]+$ ]]; then
	echo "$a is a number"
else
	echo "$a is not a number"
fi

a="1s3453"

if [[ "$a" =~ ^[0-9]+$ ]]; then
	echo "$a is a number"
else
	echo "$a is not a number"
fi

a="123456abv"

if [[ "$a" =~ ^[0-9]+$ ]]; then
	echo "$a is a number"
else
	echo "$a is not a number"
fi