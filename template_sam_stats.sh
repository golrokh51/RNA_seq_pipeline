#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --mem-per-cpu=32000
#SBATCH --cpus-per-task=1
#SBATCH --workdir=__WORKDIR__/__JOBID__/scripts/
#SBATCH --mail-user=__EMAIL__
#SBATCH --mail-type=__EMAIL_TYPE__
#SBATCH --output=__WORKDIR__/__JOBID__/results/_logs/samTools_stats_slurm-%j.out
#SBATCH --error=__WORKDIR__/__JOBID__/results/_logs/samTools_stats_slurm-%j.err



# All job recive a different number, from 1 to 18, that number is
# stored in  $SLURM_ARRAY_TASK_ID
labels=../results/_labels.txt
# Here I pick line number ${SLURM_ARRAY_TASK_ID}
f1=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $labels)

module load samtools/1.9

f="../results/"$f1"_hisat2.bam"
out=${f/hisat2/hisat2_bam_stats};
out=${out/bam/txt};
time samtools stats $f &> $out

