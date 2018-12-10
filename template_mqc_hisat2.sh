#!/bin/bash
#SBATCH --time=00:30:00
#SBATCH --mail-user=mamoolack@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --workdir=/project/def-banire/Labobioinfo/Jobs/JOBID/scripts/
#SBATCH --output=/project/def-banire/Labobioinfo/Jobs/JOBID/results/_logs/mqc_hisat2_slurm-%j.out
#SBATCH --error=/project/def-banire/Labobioinfo/Jobs/JOBID/results/_logs/mqc_hisat2_slurm-%j.err

export MUGQIC_INSTALL_HOME=/cvmfs/soft.mugqic/CentOS6
module use $MUGQIC_INSTALL_HOME/modulefiles
module load mugqic/MultiQC/v1.6

multiqc --outdir /project/def-banire/Labobioinfo/Jobs/JOBID/results/_QC/ /project/def-banire/Labobioinfo/Jobs/JOBID/results/_logs/*_summary.txt

