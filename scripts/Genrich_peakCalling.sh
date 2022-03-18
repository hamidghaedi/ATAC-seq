#!/bin/bash
#SBATCH --job-name=peakCalling
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --time=0-10:00:00
#SBATCH --mem=80gb
#SBATCH --output=peakCalling.%J.out
#SBATCH --error=peakCalling.%J.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=qaedi.65@gmail.com


source /home/ghaedi/projects/def-gooding-ab/ghaedi/atac_seq/atacSeq/bin/activate

/home/ghaedi/projects/def-gooding-ab/ghaedi/atac_seq/Genrich/Genrich -t 25f29fe7-2a4b-4748-84f8-85fe44807937.bam,571e6337-d2a7-4880-a093-c33d7c995168.bam,67471e99-2497-4ffe-b0fa-4a540abb4abd.bam,9e62c728-f5d9-40ae-b472-80b937240697.bam,586817e6-9e2c-4204-9124-666cd8cf2238.bam,8e14e214-9e44-4ae5-a2ec-3374ec8f02a9.bam,63d8bb06-2665-46a3-9471-0158e8b3bf63.bam,7ecba084-4547-4ef4-9613-752a8628a12d.bam,b66adb81-c21f-4ece-9a03-85d568fbd1f1.bam,64b9167f-52b1-4490-ab1a-a8baf3dd4f2f.bam -o blca -j -y -r -e chrM -v



