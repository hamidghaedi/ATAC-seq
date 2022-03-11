#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --time=0-05:00:00
#SBATCH --mem=80gb
#SBATCH --output=fastqc.%J.out
#SBATCH --error=fastqc.%J.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=qaedi.65@gmail.com


module load StdEnv/2020  fastqc/0.11.9

cd /home/ghaedi/projects/def-gooding-ab/ghaedi/atac_seq/fastq

for file in ./*
do
echo $file
fastqc $file/*_R1.fastq.gz
fastqc $file/*_R2.fastq.gz
done
