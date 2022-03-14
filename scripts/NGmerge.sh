#!/bin/bash
#SBATCH --job-name=NGmerge
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --time=0-18:00:00
#SBATCH --mem=80gb
#SBATCH --output=NGmerge.%J.out
#SBATCH --error=NGmerge.%J.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=qaedi.65@gmail.com


source /home/ghaedi/projects/def-gooding-ab/ghaedi/atac_seq/atacSeq/bin/activate

for dir in /home/ghaedi/projects/def-gooding-ab/ghaedi/atac_seq/fastq/*
do
echo $dir
base_name=$(basename ${dir})
r1=$dir/$base_name"_atacseq_gdc_realn_R1.fastq.gz"
r2=$dir/$base_name"_atacseq_gdc_realn_R2.fastq.gz"
name=$base_name"_trimmed"

/home/ghaedi/projects/def-gooding-ab/ghaedi/atac_seq/NGmerge/NGmerge -a -n 32 -v \
-1 $r1 \
-2 $r2 \
-o $name
done
