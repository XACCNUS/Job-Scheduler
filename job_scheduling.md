### Introduction

XACC@NUS cluster adopts virtualization and [slurm](https://slurm.schedmd.com/documentation.html) job scheduler to manage hardware resource. 
In order to run an __FPGA accelerated__ task, you must submit a slurm job request to the scheduler, by requesting how much time you want, what type of resources you require. The details of how to write a slurm job are shown in the following part.


### Resources

We adopt separated execution environment for each kind of FPGA cards, and you are only give the access of the node as your requested (the host url given in your account notification email). Each computing node is deployed with several virtual machines for hosting FPGA cards and executing your submitted jobs.

After login to the node, you can run ```sinfo``` to see the available VMs and the information of hardware card that you can use.
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

##### I. Compilation
You are allowed for code compilation on the corresponding computing node, but please take care of your storage utilization and we will periodically check it. 
The deployed compiling environment is shown as follows 

* GCC version: 9.4.0
* Vitis version: 2020.2
* XRT version: 2.11.634

For both remote compilation (on our computing node) and local complication (on your local machine), we highly suggest you to static link your program with all used third-party libraries, because we can not have the unified support for all users in different situation. 