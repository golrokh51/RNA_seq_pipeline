#!/bin/bash
#SBATCH --time=00:30:00
#SBATCH --mail-user=__EMAIL__
#SBATCH --mail-type=__EMAIL_TYPE__
#SBATCH --error=__ERR_LOG__
#SBATCH --output=__OUT_LOG__
#SBATCH --workdir=__WORK_DIR__

export MUGQIC_INSTALL_HOME=/cvmfs/soft.mugqic/CentOS6
module use $MUGQIC_INSTALL_HOME/modulefiles
module load mugqic/MultiQC/v1.6

multiqc --outdir ../results/_QC/ .._/results/_logs/*_summary.txt

