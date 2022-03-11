# ATAC-seq
Workflow  to download, process and analyze TCGA bladder cancer ATAC-seq data on HPC environment

#### Download raw ATAC-seq bam files:
##### GDC-client installation
```shell
# GDC-client installation
virtualenv gdc_client
 source gdc_client/bin/activate
 pip install cryptography==2.8 --no-index
 pip install -r gdc-client-1.6.0/requirements.txt
 python gdc-client-1.6.0/setup.py install
 ```
 ##### Download
 Need to have the manifest file and token key from GCD
 ```shell
 # Shell commands were submitted to HPC using sbatch command from Slurm job manager. 
 # scripts are in the script folder
 sbatch dl.sh
 ```
 ##### Convert bam files to fastq 
 
  ```shell
 # scripts are in the script folder
 sbatch bam2fstq.sh
 ```
##### Quality check

```shel
sbatch fastqc.sh
```


