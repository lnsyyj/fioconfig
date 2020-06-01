#!/bin/bash

CONTROL_GATEWAY_IP="192.168.2.229"
GATEWAY_IPs=(192.168.2.225 192.168.2.226 192.168.2.227 192.168.2.228 192.168.2.229)
GATEWAY_HOST_NAME=(xc-cdh-node-0 xc-cdh-node-1 xc-cdh-node-2 xc-cdh-node-3 xc-cdh-node-4)
INITIATOR_NAME="iqn.1993-08.org.debian:01:d9b575a3ac26"
TARGET_NAME="iqn.2020-05.com.yujiang.iscsi-gw-isa"
POOL_NAME="yujiang_metadata"
RBD_NAME="iscsirbdisa"

curl --insecure --user xcuser:xcpassword -X PUT http://${CONTROL_GATEWAY_IP}:5000/api/target/${TARGET_NAME}
curl --insecure --user xcuser:xcpassword -X GET http://${CONTROL_GATEWAY_IP}:5000/api/targets

LEN=${#GATEWAY_IPs[@]}
for ((i=0; i<${LEN}; i++))
do
  curl --insecure --user xcuser:xcpassword -d ip_address=${GATEWAY_IPs[${i}]} -X PUT http://${GATEWAY_IPs[${i}]}:5000/api/gateway/${TARGET_NAME}/${GATEWAY_HOST_NAME[${i}]}
done

curl --insecure --user xcuser:xcpassword -d mode=create -d create_image=true -d pool=${POOL_NAME} -d size=1T -X PUT http://${CONTROL_GATEWAY_IP}:5000/api/disk/${POOL_NAME}/${RBD_NAME}

# EC
#rbd create xcblock_metadata/disk100002 --data-pool xcblock_data --size 1T
#curl --insecure --user xcuser:xcpassword -d mode=create -d pool=xcblock_metadata -d image=disk100002 -d size=1T -X PUT http://127.0.0.1:5000/api/disk/xcblock_metadata/disk100002

curl --insecure --user xcuser:xcpassword -d disk=${POOL_NAME}/${RBD_NAME} -X PUT http://${CONTROL_GATEWAY_IP}:5000/api/targetlun/${TARGET_NAME}

curl --insecure --user xcuser:xcpassword -X PUT http://${CONTROL_GATEWAY_IP}:5000/api/client/${TARGET_NAME}/${INITIATOR_NAME}

curl --insecure --user xcuser:xcpassword -d disk=${POOL_NAME}/${RBD_NAME} -X PUT http://${CONTROL_GATEWAY_IP}:5000/api/clientlun/${TARGET_NAME}/${INITIATOR_NAME}

# sudo apt-get install -y multipath-tools open-iscsi
# cat /etc/multipath.conf
#blacklist {
#    devnode "^sda"
#    }
#
#    defaults {
#        user_friendly_names yes
#	    path_grouping_policy failover
#	        failback immediate
#		    no_path_retry fail
#	    }
#
# systemctl start multipathd ; systemctl status multipathd



# iscsiadm -m discovery -t st -p 192.168.2.229
# iscsiadm -m node --targetname=${TARGET_NAME} --login
