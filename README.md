

## User Guide of XACC Cluster at NUS

### Registration
For researchers outside NUS, please request access through [Xilinx University Program](https://www.xilinx.com/support/university/XUP-XACC.html).

For researchers at NUS, please apply through the following link:
[NUS XACC Account Registration ](https://forms.gle/fvfPgJypd1sSWzHm8).

### Compute Node Configuration

|Host    | Boards |  Quantity | Shell Version | XRT Version | Vitis Version |
|--------|--------|-------|----------|-------------|-------------------|
| xtraf1.d1.comp.nus.edu.sg    |  Alveo U50 | 1 | xilinx_u50_gen3x16_xdma_201920_3 | 2.7.766 | Vitis 2020.1 |
| xaccnode0.d2.comp.nus.edu.sg |  Alveo U250 | 2 | xilinx_u250_xdma_201830_2 | 2.7.766 | Vitis 2020.1 |
| xaccnode1.d2.comp.nus.edu.sg |  Alveo U250 | 2 | xilinx_u250_xdma_201830_2 | 2.7.766 | Vitis 2020.1 |
| xaccnode2.d2.comp.nus.edu.sg |  Alveo U280 | 4 | xilinx_u280_xdma_201920_1 | 2.5.309 | Vitis 2019.2 |
| xaccnode3.d2.comp.nus.edu.sg |  Alveo U250 | 2 | xilinx_u250_qdma_201920_1 | 2.5.309 | Vitis 2019.2 |

### Access to the Cluster
Researchers at NUS could directly access the corresponding server with SSH: 
```shell
ssh user@xaccnodex.d2.comp.nus.edu.sg
```
Researchers outside NUS need to access a jump host (which has a public IP address) at first before accessing the servers with FPGA boards. 
```shell
ssh guest@xacchead.d2.comp.nus.edu.sg # The password for guest account is Q5vwsZGytV3wwHn
ssh user@xaccnodex.d2.comp.nus.edu.sg # Access the compute node through the head node.
```

### Setting the FPGA Environment

Users can use the following command to setup the environment:
```shell
# XRT Env
source /opt/xilinx/xrt/setup.sh
# For the node installed Vitis 2020.1
source  /opt/Xilinx/Vitis/2020.1/settings64.sh
# For the node installed Vitis 2019.2
source  /opt/Xilinx/Vitis/2019.2/settings64.sh
```

### Shared Storage

```/data``` is a shared path for all computing nodes.
Users can use this path to store insensitive data. Please keep your data size within 50GB.

### Feedback 


### Acknowledgement
We would like to thank [Xilinx](https://www.xilinx.com/) for the hardware donation.
