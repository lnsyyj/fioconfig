#!/bin/bash

case_number=8

ioengine="rbd"
clientname="admin"
invalidate=0
runtime=600

pool="rbd"
rbdname=(rbd-1)
iodepth=(64 512)
# rw=read 顺序读 rw=write 顺序写 rw=rw 顺序混合读写
# rw=randwrite 随机写 rw=randread 随机读 rw=randrw 随机混合读写
rw="randrw"
bs="8k"
rwmixwrite=30


function sequence_config_file() {
	echo "[global]" >> ${1}
	echo "ioengine="${2} >> ${1}
	echo "clientname="${3} >> ${1}
	echo "invalidate="${4} >> ${1}
	echo "runtime="${5} >> ${1}

	echo "[rbd]" >> ${1}
	echo "pool="${6} >> ${1}
	echo "rbdname="${7} >> ${1}
	echo "iodepth="${8} >> ${1}
	echo "rw="${9} >> ${1}
	echo "bs="${10} >> ${1}
	echo "rwmixwrite="${11} >> ${1}
}

function random_config_file() {
	echo "[global]" >> ${1}
	echo "ioengine="${2} >> ${1}
	echo "clientname="${3} >> ${1}
	echo "invalidate="${4} >> ${1}
	echo "runtime="${5} >> ${1}

	echo "[rbd]" >> ${1}
	echo "pool="${6} >> ${1}
	echo "rbdname="${7} >> ${1}
	echo "iodepth="${8} >> ${1}
	echo "rw="${9} >> ${1}
	echo "bs="${10} >> ${1}
	echo "rwmixwrite="${11} >> ${1}
}

## sequence
#for rbdname_ in ${rbdname[@]}
#do
#	for iodepth_ in ${iodepth[@]}
#	do
#		file_name_="${case_number}_fiorunmode--clientserver_rw--${rw}_ioengine--${ioengine}_rbdname--${rbdname_}_rwmixwrite--${rwmixwrite}_bs--${bs}_iodepth--${iodepth_}_time--${runtime}.fio"
#		sequence_config_file ${file_name_} ${ioengine} ${clientname} ${invalidate} ${runtime} ${pool} ${rbdname_} ${iodepth_} ${rw} ${bs} ${rwmixwrite}
#	done
#done

# random
for rbdname_ in ${rbdname[@]}
do
	for iodepth_ in ${iodepth[@]}
	do
		file_name_="${case_number}_fiorunmode--clientserver_rw--${rw}_ioengine--${ioengine}_rbdname--${rbdname_}_rwmixwrite--${rwmixwrite}_bs--${bs}_iodepth--${iodepth_}_time--${runtime}.fio"
		random_config_file ${file_name_} ${ioengine} ${clientname} ${invalidate} ${runtime} ${pool} ${rbdname_} ${iodepth_} ${rw} ${bs} ${rwmixwrite}
	done
done
