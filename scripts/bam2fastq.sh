#!/bin/bash
#SBATCH --job-name=bam2fastq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --time=0-05:00:00
#SBATCH --mem=80gb
#SBATCH --output=bam2fastq.%J.out
#SBATCH --error=bam2fastq.%J.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=


module load StdEnv/2020  samtools/1.12

cd /home/ghaedi/projects/def-gooding-ab/ghaedi/atac_seq/bam

for file in *.bam
do
mkdir ${file%.bam}

samtools sort --threads 32 -n $file | samtools fastq --threads 32 \
-1 /home/ghaedi/projects/def-gooding-ab/ghaedi/atac_seq/bam/${file%.bam}/${file%.bam}_R1.fastq.gz \
-2 /home/ghaedi/projects/def-gooding-ab/ghaedi/atac_seq/bam/${file%.bam}/${file%.bam}_R2.fastq.gz \
-0 /home/ghaedi/projects/def-gooding-ab/ghaedi/atac_seq/bam/${file%.bam}/${file%.bam}_0.fastq.gz
done
