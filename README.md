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

For alignment I used bowtie2 coupled with samtools to convert the aligner output to bam file directly. 

```shell
#The script is in the script folder
sbatch alignmnet.sh
```
To check the bam files and see if any is truncated
```shell
module load samtools
samtools quickcheck -v *.bam > bad_bams.fofn   && echo 'all ok' || echo 'some files failed check, see bad_bams.fofn'
```
##### Peak calling
For people working with ChIP-seq and ATAC-seq data, peak calling is a big deal. It is coupled with the post alignment processing and also got its own arguments that need to be adjusted for each purpose. I choose to stick to the Genrich tool for a number of reasons that stated [elsewhere](https://informatics.fas.harvard.edu/atac-seq-guidelines.html), but briefly:It is capable of removing mitochondrial reads and PCR duplicates at once, handling multi mapping reads effectively, peak-calling on all replicates at once and providing ATAC-seq specific mode for analysis.

```shell
# to install Genrich
git clone https://github.com/jsh58/Genrich
cd Genrich
make
```
Then running on all bam files at once using the recommended setting:

```shell
# the script is in the script folder
sbatch Genrich_peakCalling.sh
```
The final result, here ```blca``` is a narrowpeak file providing data on ATAC peaks. 

##### Peak calls assessment
The number of peaks in the file:
```shel 
wc -l blca
#201458 blca
```
To calculate the average peak length:

```shel
awk '{peak_length = $3 - $2; sum += peak_length; count++} END {average = sum / count; print "Average Peak Length:", average}' blca
#Average Peak Length: 1146.42
```
The average length of peaks can be used to merge adjacent peaks:
``` shel
# -c columns to retain their information in the merged output
bedtools merge -d 1000 -c 4,5,7,8,10 -o distinct -i blca > blca_merged_peaks.bed
```
Merging peaks decreased the number of peaks in the file to 132,027 in `blca_merged_peaks.bed`.

##### Genomic region overlap analysis
To see if the TEs with expression level are enriched in or adjacent to ATAC-seq peaks. 
