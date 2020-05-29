#!/bin/bash


IOENGINE="rbd"
POOL_NAME="yujiang_metadata"
RBD_NAME="iscsirbd001"
NUMJOBS=1
DIRECT=1
SIZE="1024g"
IODEPTH=1024
RUNTIME=600
BA="1m"
BS="1m"


RW=(write)
for rw_name in ${RW[@]}
do
  # Random writes
  fio -ioengine=${IOENGINE} -pool=${POOL_NAME} -rbdname=${RBD_NAME} -numjobs=${NUMJOBS} -direct=${DIRECT} -size=${SIZE} -iodepth=${IODEPTH} -runtime=${RUNTIME} -rw=${rw_name} -ba=${BA} -bs=${BS} -name="${IOENGINE}_${IODEPTH}_${RW}_${BS}"

done

