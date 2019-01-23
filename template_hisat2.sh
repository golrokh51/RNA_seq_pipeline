#!/bin/bash
#SBATCH --time=3:00:00
#SBATCH --mem-per-cpu=32000
#SBATCH --cpus-per-task=1
#SBATCH --workdir=__WORKDIR__/__JOBID__/scripts/
#SBATCH --mail-user=__EMAIL__
#SBATCH --mail-type=__EMAIL_TYPE__
#SBATCH --output=__WORKDIR__/__JOBID__/results/_logs/hisat2_slurm-%j.out
#SBATCH --error=__WORKDIR__/__JOBID__/results/_logs/hisat2_slurm-%j.err



# All job recive a different number, from 1 to 18, that number is
# stored in  $SLURM_ARRAY_TASK_ID

module load hisat2/2.1.0
inputFiles=../data/_all_fq.txt
###strTie_Assembly_list="../results/assembly_GTF_list.txt"
###strTie_merged="../results/stringtie_merged.gtf"

# Here I pick line number ${SLURM_ARRAY_TASK_ID}
f1=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $inputFiles)

# and run the rest of the script

f2=${f1/_1.fq/_2.fq}
gunzip -k $f1
gunzip -k $f2

read1=${f1/fq.gz/fq} 
read2=${f2/fq.gz/fq}   
chmod 750 $read1
chmod 750 $read2
lable=${read2/_2.fq/}
out=${read2/_2.fq/_hisat2.sam}
out=${out/data/results}
outsplice=${out/_hisat2.sam/_hisat2_spliced.sam}
log=${out/.sam/.log}
log=${log/results/results\/_logs} 
metfile=${out/.sam/_metric.txt}
summary=${metfile/_metric/_summary}

time hisat2 --dta -p 8 --trim3 40 --skip 10 --no-mixed --novel-splicesite-outfile $outsplice --no-discordant --downstream-transcriptome-assembly --new-summary --summary-file=$summary --met-file $metfile -x $__GENOME_DIR__/Mus_musculus.GRCm38/Mus_musculus.GRCm38 -1 $read1 -2 $read2 -S $out &> $log

rm $read1 $read2
echo "hisat2 "$label >> ../results/_RNA-Seq_checkpoint.txt
chmod 750 $outsplice $out $metfile



