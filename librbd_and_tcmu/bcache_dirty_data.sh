#!/bin/bash



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
