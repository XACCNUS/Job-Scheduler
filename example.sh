#!/bin/bash

username=xtra_test
app=hello_world

# make a new direction for save the log and result
time_string=`date +%Y_%m_%d_%H_%M`
log_path=${app}_test_log_${time_string}
mkdir  -p ${log_path}

# setup XRT environment
source /opt/xilinx/xrt/setup.sh

# demo for run xrt tools
/opt/xilinx/xrt/bin/xbutil  scan  > ${log_path}/scan.log
/opt/xilinx/xrt/bin/xbutil  validate --device 0000:39:00.1 >${log_path}/validate.log

# demo for run your applicaitons
cp /data/${username}/${app} .
./${app} > ${log_path}/exec.log

# copy back the result and logs
cp -r ${log_path}  /data/${username}