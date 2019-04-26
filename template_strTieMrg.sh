#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --mem=128000M
#SBATCH --mail-user=__EMAIL__
#SBATCH --mail-type=__EMAIL_TYPE__
#SBATCH --error=__ERR_LOG__
#SBATCH --output=__OUT_LOG__
#SBATCH --workdir=__WORK_DIR__

strTie_Assembly_list="../results/assembly_GTF_list.txt"
strTie_merged="../results/stringtie_merged.gtf"

# Here I pick line number ${SLURM_ARRAY_TASK_ID}


module load stringtie/1.3.4d

time stringtie --merge -G $__ANNO_DIR__/Mus_musculus.GRCm38/Mus_musculus.GRCm38.93.gtf -o  $strTie_merged $strTie_Assembly_list
echo "stringtie_merge "$label >> ../results/_RNA-Seq_checkpoint.txt	

