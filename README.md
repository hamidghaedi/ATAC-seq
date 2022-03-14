# ATAC-seq
Workflow  to download, process and analyze TCGA bladder cancer ATAC-seq data on HPC environment

##### Data Download

GDC-client installation:
```shell
# GDC-client installation
virtualenv gdc_client
 source gdc_client/bin/activate
 pip install cryptography==2.8 --no-index
 pip install -r gdc-client-1.6.0/requirements.txt
 python gdc-client-1.6.0/setup.py install
 ```
 Need to have the manifest file and token key from GCD
 ```shell
 # Shell commands were submitted to HPC using sbatch command from Slurm job manager. 
 # The script is in the script folder
 sbatch dl.sh
 ```
 ##### Convert bam files to fastq 
 
  ```shell
 # The script is in the script folder
 sbatch bam2fstq.sh
 ```
##### Quality check

Points to consider [_Genome Biology volume 21, Article number: 22 (2020)_]:
- An overall high base quality score with a slight drop towards the 3′ end of sequencing reads is acceptable. 
- No obvious deviation from expected GC content and sequence read length should be observed. 
- The metrics should be homogeneous among all samples from the same experimental batch and sequencing run.

```shel
#The script is in the script folder
sbatch fastqc.sh
```

##### Adaptor removal with NGmerge
Details on NGmerge can be find at [GitHub](https://github.com/jsh58/NGmerge)

To install the tool:

```shell
git clone https://github.com/jsh58/NGmerge
cd NGmerge
make
```
Running NGmerge

```shell
#The script is in the script folder
sbatch NGmerge.sh 
```




##### Read alignment 

Points to consider [_Genome Biology volume 21, Article number: 22 (2020)_]:
- A unique mapping rate over 80% is typical for a successful ATAC-seq experiment. 
- A minimum number of mapped reads of  50 million for open chromatin detection and differential analysis, 
- A minimum number of mapped reads of 200 million for TF footprinting 

```shell
```
