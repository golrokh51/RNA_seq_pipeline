#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mail-user=mamoolack@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --workdir=/project/def-banire/Labobioinfo/Jobs/JOBID/scripts/
#SBATCH --output=/project/def-banire/Labobioinfo/Jobs/JOBID/results/_logs/prepD_slurm-%j.out
#SBATCH --error=/project/def-banire/Labobioinfo/Jobs/JOBID/results/_logs/prepD_slurm-%j.err

time python2 prepDE.py -i ../results/assembly_GTF_list1.txt -g ../results/gene_count_matrix_str1.csv -t ../results/transcript_count_matrix_str1.csv --legend=../results/legend_str1.csv
time python2 prepDE.py -i ../results/assembly_GTF_list2.txt -g ../results/gene_count_matrix_str2.csv -t ../results/transcript_count_matrix_str2.csv --legend=../results/legend_str2.csv