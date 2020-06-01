#!/bin/bash


IOENGINE="rbd"
POOL_NAME="yujiang_metadata"
NUMJOBS=1
DIRECT=1
SIZE="1024g"
IODEPTH=1024
RUNTIME=600
BA="8k"
BS="8k"
POOL_TYPE="ec"

SHELL_FOLDER=$(dirname "$0")
source ${SHELL_FOLDER}/common_variable


RW=(randwrite randread)
for rw_name in ${RW[@]}
do
  # Random writes
  fio -ioengine=${IOENGINE} -pool=${POOL_NAME} -rbdname=${RBD_NAME} -numjobs=${NUMJOBS} -direct=${DIRECT} -size=${SIZE} -iodepth=${IODEPTH} -runtime=${RUNTIME} -rw=${rw_name} -ba=${BA} -bs=${BS} -name="${IOENGINE}_${IODEPTH}_${RW}_${BS}" > ${IOENGINE}_${IODEPTH}_${rw_name}_${BS}_${POOL_TYPE}.log
  # Random reads
  fio -ioengine=${IOENGINE} -pool=${POOL_NAME} -rbdname=${RBD_NAME} -numjobs=${NUMJOBS} -direct=${DIRECT} -size=${SIZE} -iodepth=${IODEPTH} -runtime=${RUNTIME} -rw=${rw_name} -ba=${BA} -bs=${BS} -name="${IOENGINE}_${IODEPTH}_${RW}_${BS}" > ${IOENGINE}_${IODEPTH}_${rw_name}_${BS}_${POOL_TYPE}.log

done

