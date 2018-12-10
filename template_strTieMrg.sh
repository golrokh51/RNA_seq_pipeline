#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --mem=514500M
#SBATCH --mail-user=mamoolack@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --workdir=/project/def-banire/Labobioinfo/Jobs/JOBID/scripts/
#SBATCH --output=/project/def-banire/Labobioinfo/Jobs/JOBID/results/_logs/stringTie_merge_slurm-%j.out
#SBATCH --error=/project/def-banire/Labobioinfo/Jobs/JOBID/results/_logs/stringTie_merge_slurm-%j.err


strTie_Assembly_list="../results/assembly_GTF_list.txt"
strTie_merged="../results/stringtie_merged.gtf"

# Here I pick line number ${SLURM_ARRAY_TASK_ID}


module load stringtie/1.3.4d

time stringtie --merge -G /project/def-banire/Labobioinfo/annotations/Mus_musculus.GRCm38/Mus_musculus.GRCm38.93.gtf -o  $strTie_merged $strTie_Assembly_list
echo "stringtie_merge "$label >> ../results/_RNA-Seq_checkpoint.txt	

