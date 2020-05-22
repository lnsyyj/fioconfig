#!/bin/bash

FIO_FILES_PATH="/root/yujiang/read/"
FIO_FILES_LOG_PATH="${FIO_FILES_PATH}logs/"
FIO_FILES=(fio-4k.fio fio-8k.fio fio-64k.fio fio-256k.fio fio-1m.fio fio-4m.fio)


for file_name in ${FIO_FILES[@]}
do
    date
    echo "${file_name}"
    fio -f ${FIO_FILES_PATH}${file_name} > ${FIO_FILES_LOG_PATH}${file_name}.log
done
