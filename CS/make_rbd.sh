#!/bin/bash

for ((i=1; i<=30; i++))
do
	rbd create rbd-${i} --size 278G
	#rbd rm rbd-${i}
done

