#!/bin/bash
#SBATCH --job-name=alignmnet
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --time=5-00:00:00
#SBATCH --mem=80gb
#SBATCH --output=bowtie2.%J.out
#SBATCH --error=bowtie2.%J.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=qaedi.65@gmail.com


source /home/ghaedi/projects/def-gooding-ab/ghaedi/atac_seq/atacSeq/bin/activate

module load StdEnv/2020 gcc/9.3.0 samtools/1.13 bowtie2/2.4.4

for dir in /home/ghaedi/projects/def-gooding-ab/ghaedi/atac_seq/trimmed_fastq/*
do
echo $dir

BOWTIE2_INDEXES="/home/ghaedi/projects/def-gooding-ab/ghaedi/atac_seq/ref/"
base_name=$(basename ${dir})
r1=$dir/$base_name"_1.fastq.gz"
r2=$dir/$base_name"_2.fastq.gz"

bowtie2 --very-sensitive -k 10  -x $BOWTIE2_INDEXES/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta -1 $r1 -2 $r2 \
|samtools view -u - \
|samtools sort -n -o /home/ghaedi/projects/def-gooding-ab/ghaedi/atac_seq/bam/"${base_name%_trimmed}".bam -
done

