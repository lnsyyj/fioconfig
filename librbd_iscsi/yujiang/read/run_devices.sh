#!/bin/bash

FIO_FILES_PATH="/root/yujiang/read/"
FIO_FILES_LOG_PATH="${FIO_FILES_PATH}logs/"
FIO_FILES=(fio-iscsi-4k.fio fio-iscsi-8k.fio fio-iscsi-64k.fio fio-iscsi-256k.fio fio-iscsi-1m.fio fio-iscsi-4m.fio)


for file_name in ${FIO_FILES[@]}
do
    date
    echo "${file_name}"
    fio -f ${FIO_FILES_PATH}${file_name} > ${FIO_FILES_LOG_PATH}${file_name}.log
done
