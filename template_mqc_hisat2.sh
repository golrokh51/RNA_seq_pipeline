#!/bin/bash
#SBATCH --time=00:30:00
#SBATCH --mail-user=__EMAIL__
#SBATCH --mail-type=__EMAIL_TYPE__

cd $__WORKDIR__/__JOBID__/scripts
export MUGQIC_INSTALL_HOME=/cvmfs/soft.mugqic/CentOS6
module use $MUGQIC_INSTALL_HOME/modulefiles
module load mugqic/MultiQC/v1.6

multiqc --outdir $__WORKDIR__/__JOBID__/results/_QC/ $__WORKDIR__/__JOBID__/results/_logs/*_summary.txt

