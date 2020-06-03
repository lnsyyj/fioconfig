#!/bin/bash


IOENGINE="rbd"
POOL_NAME="yujiang_xcblock"
RBD_NAME="yujiangiscsi01"
NUMJOBS=1
DIRECT=1
SIZE="1024g"
IODEPTH=1024
RUNTIME=600
BA="1m"
BS="1m"
POOL_TYPE="re"


RW=(randwrite randread)
for rw_name in ${RW[@]}
do
  fio -ioengine=${IOENGINE} -pool=${POOL_NAME} -rbdname=${RBD_NAME} -numjobs=${NUMJOBS} -direct=${DIRECT} -size=${SIZE} -iodepth=${IODEPTH} -runtime=${RUNTIME} -rw=${rw_name} -ba=${BA} -bs=${BS} -name="${IOENGINE}_${IODEPTH}_${RW}_${BS}" > ${IOENGINE}_${IODEPTH}_${rw_name}_${BS}_${POOL_TYPE}.log
done

