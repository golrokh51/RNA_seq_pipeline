#!/bin/bash


###rm ../results/*hisat2*  ../results/*slurm*  ../results/RNA-Seq_checkpoint.txt


# mkdir ../results/_logs  ../results/_SAM ../results/_QC
# 
#  
# # 
WORK_DIR=$__WORKDIR__
mkdir $WORK_DIR/$1/results/_logs $WORK_DIR/$1/results/_SAM $WORK_DIR/$1/results/_QC
temp_path=$WORK_DIR/RNA_seq_pipline
fld=$(ls -1  $temp_path/template_*.sh |awk -F"/" '{print NF}' | uniq)
fld=$((fld+0))

# rm $WORK_DIR/180911_Lim/data/*.fq

for i in `ls -1  $temp_path/template_*.sh | cut -f$fld -d"/"`;  do  sed "s/JOBID/$1/g"  $temp_path/$i |sed "s/__EMAIL__/$2/g" |sed "s/__EMAIL_TYPE__/$3/g" |sed 's/__WORKDIR__/${WORK_DIR}/g' > $WORK_DIR/$1/scripts/$i; done	


inputFiles=$WORK_DIR/$1/data/_all_fq.txt
labels=$WORK_DIR/$1/results/_labels.txt
# list all your subject and put them in a file

########????!!!!!! WHAT IS THIS SED COMMAND IS DOING HERE??? !!!!!!????########
ls -1  $WORK_DIR/$1/data/*_1.fq.gz |sed "s/JOBID/$1/g" > $inputFiles
########????!!!!!!!!!!!!!!!!!sed "s/JOBID/$1/g"!!!!!!!!!!!!!!!!!!!!????########

fld=$(ls $WORK_DIR/$1/data/*_1.fq.gz |awk -F"/" '{print NF}' | uniq)
fld=$((fld+0))

ls $WORK_DIR/$1/data/*_1.fq.gz |cut -f$fld -d"/" | cut -f1 -d"." |sed 's/.$//g' |sed 's/.$//g' | uniq  > $labels

N_SUBJECT=$(wc -l $inputFiles | cut -f1 -d" ")
N_SUBJECT=$((N_SUBJECT + 0))

# more template_hisat2.sh
out1=$(sbatch --job-name=$1_histat2_array --array=1-${N_SUBJECT} --account=$4 ${WORK_DIR}/${1}/scripts/template_hisat2.sh)
JOB_ID1=$(echo $out1 | cut -d" " -f4)
echo $JOB_ID1

outQC=$(sbatch --depend=afterok:$JOB_ID1 --job-name=$1_mqc_hisat2 --account=$4 ${WORK_DIR}/${1}/scripts/template_mqc_hisat2.sh)
JOB_IDqc1=$(echo $outQC | cut -d" " -f4)
echo $JOB_IDqc1


out2=$(sbatch --depend=afterok:$JOB_ID1 --job-name=$1_samTools_array --array=1-${N_SUBJECT} --account=$4 ${WORK_DIR}/${1}/scripts/template_samTools.sh)
JOB_ID2=$(echo $out2 | cut -d" " -f4)
echo $JOB_ID2


outSamStat=$(sbatch --depend=afterok:$JOB_ID2 --job-name=$1_sam_stat --account=$4 ${WORK_DIR}/${1}/scripts/template_sam_stats.sh)
JOB_IDsamStat=$(echo $outSamStat | cut -d" " -f4)
echo $JOB_IDsamStat



out3=$(sbatch --depend=afterok:$JOB_ID2 --job-name=$1_strinTie_array --array=1-${N_SUBJECT} --account=$4 ${WORK_DIR}/${1}/scripts/template_stringTie.sh)
JOB_ID3=$(echo $out3 | cut -d" " -f4)
echo $JOB_ID3
# 

out4=$(sbatch --depend=afterok:$JOB_ID3 --job-name=$1_strinTie_merge ${WORK_DIR}/${1}/scripts/template_strTieMrg.sh)
JOB_ID4=$(echo $out4 | cut -d" " -f4)
echo $JOB_ID4

out5=$(sbatch --depend=afterok:$JOB_ID4 --job-name=$1strinTie2_array --array=1-${N_SUBJECT} --account=$4 ${WORK_DIR}/${1}/scripts/template_stringTie2.sh)
 JOB_ID5=$(echo $out5 | cut -d" " -f4)
echo $JOB_ID5

out6=$(sbatch --depend=afterok:$JOB_ID5 --job-name=$1_prepD --account=$4 ${WORK_DIR}/${1}/scripts/template_prepD.sh)
JOB_ID6=$(echo $out6 | cut -d" " -f4)
echo $JOB_ID6
# # # # # # 
