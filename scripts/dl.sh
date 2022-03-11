#!/bin/bash
#SBATCH --account=def-gooding-ab
#SBATCH --job-name=atac_DL
#SBATCH --qos=privileged
#SBATCH --nodes=1                # number of Nodes
#SBATCH --tasks-per-node=4        # number of MPI processes per node
#SBATCH --mem 8g
#SBATCH --time 12:00:00
#SBATCH --output=atac_DL.%J.out
#SBATCH --error=atac_DL.%J.err
#SBATCH --j
#SBATCH --mail-type=ALL
#SBATCH --mail-user=qaedi.65@gmail.com
#SBATCH --array=1-10
#

#--------------------------------------------------------------------------------
source /home/ghaedi/gdc_client/bin/activate
cd /home/ghaedi/projects/def-gooding-ab/ghaedi/atac_seq
gdc-client download -m gdc_manifest.txt -t gdc-user-token.2022-03-10T20_13_34.091Z.txt
