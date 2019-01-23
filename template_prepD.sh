#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mail-user=__EMAIL__
#SBATCH --mail-type=__EMAIL_TYPE__
#SBATCH --workdir=__WORKDIR__/__JOBID__/scripts/
#SBATCH --output=__WORKDIR__/__JOBID__/results/_logs/prepD_slurm-%j.out
#SBATCH --error=__WORKDIR__/__JOBID__/results/_logs/prepD_slurm-%j.err

time python2 prepDE.py -i ../results/assembly_GTF_list1.txt -g ../results/gene_count_matrix_str1.csv -t ../results/transcript_count_matrix_str1.csv --legend=../results/legend_str1.csv
time python2 prepDE.py -i ../results/assembly_GTF_list2.txt -g ../results/gene_count_matrix_str2.csv -t ../results/transcript_count_matrix_str2.csv --legend=../results/legend_str2.csv

fld=$(wc -l ../results/_labels.txt | cut -f1 -d" ")
fld=$((fld+1))

for f in ../results/*_matrix.csv; do 
 	title=$(grep _id $f)
 	title=${title::-1}
    i=2
    
    while [ $i -le $fld ]
    do
      x=$(cut -d',' -f$i <<< $title)
      out=${f/matrix/$x}
      cut -f1,$i -d"," $f > $out
      ((i++))
    done
done

