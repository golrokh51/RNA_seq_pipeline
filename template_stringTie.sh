#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --mem-per-cpu=32000
#SBATCH --cpus-per-task=1
#SBATCH --mail-user=mamoolack@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --output=/project/def-banire/Labobioinfo/Jobs/JOBID/results/_logs/stringTie_slurm-%j.out
#SBATCH --error=/project/def-banire/Labobioinfo/Jobs/JOBID/results/_logs/stringTie_slurm-%j.err

labels=../results/_labels.txt
strTie_Assembly_list="../results/assembly_GTF_list.txt"
# Here I pick line number ${SLURM_ARRAY_TASK_ID}
f=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $labels)

# and run the rest of the script

module load stringtie/1.3.4d
f="../results/"$f"_hisat2.bam"
out=$f
out=${out/.bam/_strTied.gtf} 
log=${f/.bam/_strTie.log} 
log=${log/results/results\/_logs} 
time stringtie $f -G /project/def-banire/Labobioinfo/annotations/Mus_musculus.GRCm38/Mus_musculus.GRCm38.93.gtf -o $out -p 16 -v &> $log
echo $out >> $strTie_Assembly_list
echo "stringtie1 "$label >> ../results/_RNA-Seq_checkpoint.txt
chmod 750 $out
