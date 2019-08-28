#!/bin/bash


ioengine="rbd"
clientname="admin"
invalidate=0
runtime=600

pool="rbd"
#rbdname=(rbd-1 rbd-2 rbd-3 rbd-4 rbd-5 rbd-6 rbd-7 rbd-8 rbd-9 rbd-10 rbd-11 rbd-12 rbd-13 rbd-14 rbd-15 rbd-16 rbd-17 rbd-18 rbd-19 rbd-20 rbd-21 rbd-22 rbd-23 rbd-24 rbd-25 rbd-26 rbd-27 rbd-28 rbd-29 rbd-30)
rbdname=(rbd-1)
iodepth=(64 512)
# rw=read 顺序读 rw=write 顺序写 rw=rw 顺序混合读写
# rw=randwrite 随机写 rw=randread 随机读 rw=randrw 随机混合读写
case_number=8
rw="randrw"
bs="8k"
rwmixwrite=30

#IP=(172.16.60.11 172.16.60.12 172.16.60.13 172.16.60.11 172.16.60.12 172.16.60.13 172.16.60.11 172.16.60.12 172.16.60.13 172.16.60.11 172.16.60.12 172.16.60.13 172.16.60.11 172.16.60.12 172.16.60.13 172.16.60.11 172.16.60.12 172.16.60.13 172.16.60.11 172.16.60.12 172.16.60.13 172.16.60.11 172.16.60.12 172.16.60.13 172.16.60.11 172.16.60.12 172.16.60.13 172.16.60.11 172.16.60.12 172.16.60.13)
IP=(172.16.60.12)

function config_file() {
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

rbdnumber=${#rbdname[@]}
for iodepth_ in ${iodepth[@]}
do
	case_perfix_="fio "
	file_name_=""
	tmp_=""
	for ((i=0; i<${rbdnumber}; i++))
	do
		#file_name_="${case_number}_fiorunmode--clientserver_rw--${rw}_ioengine--${ioengine}_rbdname--${rbdname[$(($i+1))]}_rwmixwrite--${rwmixwrite}_bs--${bs}_iodepth--${iodepth_}_time--${runtime}.fio"
		file_name_="${case_number}_fiorunmode--clientserver_rw--${rw}_ioengine--${ioengine}_rbdname--${rbdname[${i}]}_rwmixwrite--${rwmixwrite}_bs--${bs}_iodepth--${iodepth_}_time--${runtime}.fio"
		echo ${rbdname[${i}]}
		#make config
		config_file ${file_name_} ${ioengine} ${clientname} ${invalidate} ${runtime} ${pool} ${rbdname[${i}]} ${iodepth_} ${rw} ${bs} ${rwmixwrite}

		#make runshell
        	tmp_="${tmp_} --client=${IP[${i}]} ${file_name_}"
	done
	case_perfix_="${case_perfix_}${tmp_} > ${case_number}_fiorunmode--clientserver_rw--${rw}_ioengine--${ioengine}_rwmixwrite--${rwmixwrite}_bs--${bs}_iodepth--${iodepth_}_time--${runtime}_.log"
	echo "${case_perfix_}" >> run_case.sh
done
