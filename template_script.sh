#!/bin/bash
#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=32000
#SBATCH --cpus-per-task=1
#SBATCH --mail-user=mamoolack@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --output=/project/def-banire/Labobioinfo/Jobs/180911_Lim/results/stringTie_slurm-%j.out
#SBATCH --error=/project/def-banire/Labobioinfo/Jobs/180911_Lim/results/stringTie_slurm-%j.err


strTie_Assembly_list="../results/assembly_GTF_list.txt"
strTie_merged="../results/stringtie_merged.gtf"

# Here I pick line number ${SLURM_ARRAY_TASK_ID}
f=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ../results/stringTieInput.txt)

module load stringtie/1.3.4d
 
out=${f/.bam/_strTied2.gtf} 
log=${f/.bam/_strTie2.log} 
cov=${out/strTied2/strTie2_cov}
abund=${out/strTied2.gtf/strTie2_geneAbund.tsv}
log=${f/.bam/_strTie2.log} 
time stringtie $f -G $strTie_merged -o $out -p 16 -v -C $cov -A $abund &> $log
echo $label $out >> assembly_GTF_list2.txt
 
