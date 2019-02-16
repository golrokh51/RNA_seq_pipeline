#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --mem-per-cpu=32000
#SBATCH --cpus-per-task=1
#SBATCH --mail-user=__EMAIL__
#SBATCH --mail-type=__EMAIL_TYPE__

cd $__WORKDIR__/__JOBID__/scripts
labels=../results/_labels.txt
strTie_Assembly_list="../results/assembly_GTF_list1.txt"
# Here I pick line number ${SLURM_ARRAY_TASK_ID}
f=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $labels)

# and run the rest of the script

module load stringtie/1.3.4d
f="../results/"$f"_hisat2.bam"
out=$f
out=${out/.bam/_strTied.gtf} 
log=${f/.bam/_strTie.log} 
log=${log/results/results\/_logs} 
time stringtie $f -e -G $__ANNO_DIR__/Mus_musculus.GRCm38/Mus_musculus.GRCm38.93.gtf -o $out -p 16 -v &> $log
echo $label" "$out >> $strTie_Assembly_list
echo "stringtie1 "$label >> ../results/_RNA-Seq_checkpoint.txt
chmod 750 $out
