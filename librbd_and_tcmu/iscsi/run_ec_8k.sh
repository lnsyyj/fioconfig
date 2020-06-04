#!/bin/bash


POOL_NAME="yujiang_metadata"
RBD_NAME="yujiangiscsi01"
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
  ./remote_bcache_dirty_data.sh
  fio -ioengine=${IOENGINE} -numjobs=${NUMJOBS} -direct=${DIRECT} -size=${SIZE} -iodepth=${IODEPTH} -runtime=${RUNTIME} -rw=${rw_name} -ba=${BA} -bs=${BS} -filename=${FILE_NAME} -name="${IOENGINE}_${IODEPTH}_${RW}_${BS}_${POOL_TYPE}" > ${IOENGINE}_${IODEPTH}_${rw_name}_${BS}_${POOL_TYPE}.log
done

