#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --mem-per-cpu=32000
#SBATCH --cpus-per-task=1
#SBATCH --mail-user=__EMAIL__
#SBATCH --mail-type=__EMAIL_TYPE__
#SBATCH --workdir=__WORKDIR__/__JOBID__/scripts
#SBATCH --output=__WORKDIR__/__JOBID__/results/_logs/stringTie2_slurm-%j.out
#SBATCH --error=__WORKDIR__/__JOBID__/results/_logs/stringTie2_slurm-%j.err


labels=../results/_labels.txt
strTie_Assembly_list="../results/assembly_GTF_list2.txt"
strTie_merged="../results/stringtie_merged.gtf"

# Here I pick line number ${SLURM_ARRAY_TASK_ID}
label=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $labels)

# and run the rest of the script



module load stringtie/1.3.4d
 
f="../results/"$label"_hisat2.bam"
out=${f/.bam/_strTied2.gtf} 
log=${f/.bam/_strTie2.log}
log=${log/results/results\/_logs}
 
 
cov=${out/strTied2/strTie2_cov}
abund=${out/strTied2.gtf/strTie2_geneAbund.tsv}

time stringtie $f -e -G $strTie_merged -o $out -p 16 -v -C $cov -A $abund &> $log

echo $label" "$out >> $strTie_Assembly_list
echo "stringtie2 "$label >> ../results/RNA-Seq_checkpoint.txt
chmod 750 $out
