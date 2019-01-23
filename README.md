# RNA_seq_pipline

Warning: This pipline is under development, use with caution 
in make_call_pipe replace ```__WORKDIR__``` with your path to your working directory

In your working directory (```__WORKDIR__```) create a folder named by the unique job id (```__JOB_ID__```).
In side, create 3 folders: data, results and scripts
put all your fastq files (.fq.gz). 
```bash
$ tree __JOB_ID__
__JOB_ID__
    ├── data
    ├── results
    └── scripts
```

If your fastq files are not compressed, modify the template_hisat2.sh lines 26-33 and remove the line 45


lines 26-33:
```bash
f2=${f1/_1.fq/_2.fq}
gunzip -k $f1
gunzip -k $f2

read1=${f1/fq.gz/fq} 
read2=${f2/fq.gz/fq}   
chmod 750 $read1
chmod 750 $read2
```
line 45:
```bash
rm $read1 $read2
```
