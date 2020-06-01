#!/bin/bash

./remote_bcache_dirty_data.sh
./run_ec_1m.sh  
./remote_bcache_dirty_data.sh
./run_ec_4k.sh  
./remote_bcache_dirty_data.sh
./run_ec_8k.sh  
