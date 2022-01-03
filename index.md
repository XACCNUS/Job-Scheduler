### Introduction

XACC@NUS cluster adopts virtualization and [slurm](https://slurm.schedmd.com/documentation.html) job scheduler to manage hardware resource. 
In order to run an __FPGA accelerated__ task, you must submit a slurm job request to the scheduler, by requesting how much time you want, what type of resources you require. The details of how to write a slurm job are shown in the following part.  [Here](slurm.pdf) is a command cheat sheet for using slurm [[1]](https://xilinx-center.csl.illinois.edu/xacc-cluster/xacc-user-guide/xacc-job-submission-and-scheduling/).


### Hardware Resources

We adopt separated execution environment for each kind of FPGA cards, and you are only give the access of the node as your requested (the host url given in your account notification email). Each computing node is deployed with several virtual machines for hosting FPGA cards and executing your submitted jobs.

After login to the node, you can run ```sinfo``` to see the available VMs and the information of hardware card.
e.g., 
```
~$ sinfo
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
cpu*         up      30:00      2   idle u280_vm[0-1]
u280_0       up   12:00:00      1   idle u280_vm0
u280_1       up   12:00:00      1   idle u280_vm1

```

We have a shared disk for sharing files and data among the computing nodes and the VMs on each node, which is ```/data```.
There is a symbol link in your user path linked to ```/data/your_username``` for your quick access.

__Note__: Please read the [term of use](term_of_use.md), and do not put any sensitive data in this shared storage.


### How to

#### I. Compilation
You are allowed for code compilation on the corresponding computing node, but please take care of your storage utilization and we will periodically check it. 
The deployed compiling environment is shown as follows 

* GCC version: 9.4.0
* Vitis version: 2020.2
* XRT version: 2.11.634

For both remote compilation (on our computing node) and local complication (on your local machine), we highly suggest you to static link your program with all used third-party libraries, because we can not have the unified support for all users in different situation. 

#### II. Write a job script

Slurm jobs can be write as a script, we provide one [example](example.sh) as references in this repo for you to write your own job script.


```shell
#!/bin/bash

username=xtra_test
app=hello_world

# 1. make a new direction for save the log and result
time_string=`date +%Y_%m_%d_%H_%M`
log_path=${app}_test_log_${time_string}
mkdir  -p ${log_path}

# 2. setup XRT environment
source /opt/xilinx/xrt/setup.sh

# 3. demo for run xrt tools
/opt/xilinx/xrt/bin/xbutil  scan  > ${log_path}/scan.log
/opt/xilinx/xrt/bin/xbutil  validate --device 0000:39:00.1 >${log_path}/validate.log

# demo for run your applicaitons
cp /data/${username}/${app} .
./${app} > ${log_path}/exec.log

# 4. copy back the result and logs
cp -r ${log_path}  /data/${username}

```

* First, we recommend you create a unique folder to store the log and results, in the above example, we use the timestamp as the folder name.
* Second, you need to source the xrt's setup script to set up the run-time environment.
* Third, you can copy your program and bitstream (xclbin file) from the share path (i.e., ```/data```)to the local path of VM. and execute it.
* Finally, you can gather the log and result back to the share folder.

__Note__ [[1]](https://xilinx-center.csl.illinois.edu/xacc-cluster/xacc-user-guide/xacc-job-submission-and-scheduling/):

1. Your environmental variable will be copied from the submission node.
2. Always use FULL paths in your scripts
3. Make sure your script runs your code in the correct directory
4. Make sure to source the XRT libs inside your script


#### III. Subimssion


To submit the job:

```shell
sbatch -p u250_0 example.sh
```

where "-p" is used to specify the VMs that you want to execute your job. It will return a unique job ID to you. Slurm also support many advanced usage, such as setting up the dealines and job dependencies, please refer to the slurm's offical documentation in [here](https://slurm.schedmd.com/sbatch.html).

After subimssion, you can use ```squeue``` to query the status of your job.


Interactive jobs [[1]](https://xilinx-center.csl.illinois.edu/xacc-cluster/xacc-user-guide/xacc-job-submission-and-scheduling/):

It is possible to request an interactive job. This will log you directly into a compute node, without the need to write a job script. Once logged in, you can interact with the node and run as many commands as you’d like within the allotted time limits. Please refer to the SLURM documentation on how to run interactive jobs. As an example,  to interact with the U280 nodes:


```shell
srun -p u250_0 -n 1 --pty bash -i
```

### References

_[1] UIUC, XACC Cluster Job Submission and Scheduling (https://xilinx-center.csl.illinois.edu/xacc-cluster/xacc-user-guide/xacc-job-submission-and-scheduling/)_

_[2] Slurm, Slurm Tutorials (https://slurm.schedmd.com/tutorials.html)_
