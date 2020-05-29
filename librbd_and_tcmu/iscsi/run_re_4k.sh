#!/bin/bash


IOENGINE="libaio"
POOL_NAME="yujiang_xcblock"
RBD_NAME="yujiangiscsi01"
NUMJOBS=1
DIRECT=1
SIZE="1024g"
IODEPTH=1024
RUNTIME=600
BA="4k"
BS="4k"
POOL_TYPE="re"


RW=(randwrite randread)
for rw_name in ${RW[@]}
do
  # Random writes
  fio -ioengine=${IOENGINE} -numjobs=${NUMJOBS} -direct=${DIRECT} -size=${SIZE} -iodepth=${IODEPTH} -runtime=${RUNTIME} -rw=${rw_name} -ba=${BA} -bs=${BS} -filename=/dev/mapper/mpatha -name="${IOENGINE}_${IODEPTH}_${RW}_${BS}_${POOL_TYPE}" > ${IOENGINE}_${IODEPTH}_${RW}_${BS}_${POOL_TYPE}.log

  # Random reads
  fio -ioengine=${IOENGINE} -numjobs=${NUMJOBS} -direct=${DIRECT} -size=${SIZE} -iodepth=${IODEPTH} -runtime=${RUNTIME} -rw=${rw_name} -ba=${BA} -bs=${BS} -filename=/dev/mapper/mpatha -name="${IOENGINE}_${IODEPTH}_${RW}_${BS}_${POOL_TYPE}" > ${IOENGINE}_${IODEPTH}_${RW}_${BS}_${POOL_TYPE}.log

done
