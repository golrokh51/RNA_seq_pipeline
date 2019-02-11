# RNA_seq_pipline



## warning: This pipline is under development, use with caution 
You should add following environemental variables:
```__WORKDIR__```
```__ANNO_DIR__```
```__GENOME_DIR__```
In your working directory (```$__WORKDIR__```) create a folder named by the unique job id (```__JOB_ID__```).
In side, create 3 folders: data, results and scripts
put all your fastq files (.fq.gz). 
```bash
$ tree __JOB_ID__
__JOB_ID__
    ├── data
    ├── results
    └── scripts
```
This is my working directory (```$__WORKDIR__```)
```
├── jobID_1
│   ├── data
│   ├── results
│   └── scripts
├── jobID_2
│   ├── data
│   ├── results
│   └── scripts
└── RNA_seq_pipline
    ├── make_call_pipe.sh
    ├── RNA-seq_pipe.png
    ├── template_hisat2.sh
    ├── template_mqc_hisat2.sh
    ├── template_prepD.sh
    ├── template_sam_stats.sh
    ├── template_samTools.sh
    ├── template_stringTie2.sh
    ├── template_stringTie.sh
    └── template_strTieMrg.sh

```
In my case in my ```__GENOME_DIR__``` I have the following files and folders:
```
├── HomoSapiens
│   └── Homo_sapiens.GRCh38
│       ├── Homo_sapiens.GRCh38.1.ht2
│       ├── Homo_sapiens.GRCh38.2.ht2
│       ├   ...
│       ├── Homo_sapiens.GRCh38.7.ht2
|       └── Homo_sapiens.GRCh38.8.ht2
└── Mus_musculus
    └── Mus_musculus.GRCm38
        ├── Mus_musculus.GRCm38.1.ht2
        ├── Mus_musculus.GRCm38.1.ht2
        ├── ...
        ├── Mus_musculus.GRCm38.1.ht2
        └── Mus_musculus.GRCm38.1.ht2
```
I have similare file structure for ```__ANNO_DIR__```



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
## You have to adjust the parameters, specially for hisat2 yourself in the template file before running it.


## To run RNA-seq pipeline on CEDAR, GRAHAM, MP2b you should run within RNA_seq_pipline folder the following command:
```bash
./make_call_pipe.sh jobID_1 you@email.com All yourPIgroup
```
