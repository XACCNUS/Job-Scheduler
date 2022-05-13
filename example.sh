#!/bin/bash
#SBATCH --chdir /tmp/
#SBATCH --account=xtra
# 0.  keep the above two lines for slurm env setup

username=xtra_test
app=hello_world
path=program
fpga=binary_container_1.xclbin
# 1. modify the above file/path name to yours
# your program must be exsit in "/${data}/${username}/${path}/"
# "/data" is a shared directory with the host and VMs, you can use it for transfer data/programs.

# 2. we provide a shell function that can be directly used
function prepare_on_vm
{
    # 2.1 relocate working dir on vm
    workdir=/tmp/${username}
    rm -rf ${workdir}
    mkdir -p ${workdir}
    cd ${workdir}

    # 2.2 make a new direction for save the log and result
    time_string=`date +%Y_%m_%d_%H_%M_%S`
    log_path=/data/${username}/log/${app}_test_log_${time_string}
    mkdir  -p ${log_path}

    # 2.3 setup XRT environment
    source /opt/xilinx/xrt/setup.sh

    # 2.4 scan cards (you can get the card id from scan.log)
    /opt/xilinx/xrt/bin/xbutil  scan  > ${log_path}/scan.log

    # 2.5 copy your applicaitons to vm
    # NOTE:
    #      your application files should be already in "/${data}/${username}/${path}/" path
    #      i.e., for the user xtra_test, he need manually copy the host program "hello_world" to /data/xtra_test/program/hello_world
    #            and fpga bitstream "binary_container_1.xclbin" to /data/xtra_test/program/hello_world
    cp /data/${username}/${path}/${app}  ${workdir} >  ${log_path}/copy.log 2>&1
    cp /data/${username}/${path}/${fpga} ${workdir} >> ${log_path}/copy.log 2>&1
    chmod +x ./${app}
}

prepare_on_vm


# 3. run your program on VMs.
./${app} ${fpga} >  ${log_path}/exec.log 2>&1