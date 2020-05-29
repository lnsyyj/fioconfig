#!/bin/bash


#IPs=(192.168.1.225 192.168.1.226 192.168.1.227 192.168.1.228 192.168.1.229)
#for ip in ${IPs[@]}
#do
#done

ansible -i hosts all -m shell -a "/root/bcache_dirty_data.sh"

##手动强制下刷dirty data百分比
#for i in {0..5}; do echo 0 > /sys/block/bcache$i/bcache/writeback_percent; done
#
#sleep 600
#
##再恢复下刷dirty data百分比
#for i in {0..5}; do echo 40 > /sys/block/bcache$i/bcache/writeback_percent; done
#
##查看下刷百分比
#for i in {0..5}; do cat /sys/block/bcache$i/bcache/writeback_percent; done
#
##查看dirty data大小
#for i in {0..5}; do cat /sys/block/bcache$i/bcache/dirty_data; done
