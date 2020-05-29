#!/bin/bash

ceph osd pool create yujiang_metadata 128 128
ceph osd erasure-code-profile ls
ceph osd erasure-code-profile get rbdecprofile
ceph osd pool create yujiang_data 512 512 erasure rbdecprofile
ceph osd pool set yujiang_data allow_ec_overwrites true
rbd create --size 1T --data-pool yujiang_data yujiang_metadata/iscsirbd001

