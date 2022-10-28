# RNA_seq_pipeline
## warning: This pipline is under development, use with caution 
This pipeline is for the users of the "Digital Research Alliance of Canada (the Alliance)"

## Content
  * [Requirement]
  * [Installation]
  * [How to run]
  
 ---
 ## Requirment
 ### [HISAT2](http://daehwankimlab.github.io/hisat2/)
   * Description: HISAT2 is a fast and sensitive alignment program for mapping next-generation sequencing reads (both DNA and RNA) to a population of human genomes as well as to a single reference genome. Based on an extension of BWT for graphs (Sirén et al. 2014), we designed and implemented a graph FM index (GFM), an original approach and its first implementation. In addition to using one global GFM index that represents a population of human genomes, HISAT2 uses a large set of small GFM indexes that collectively cover the whole genome. These small indexes (called local indexes), combined with several alignment strategies, enable rapid and accurate alignment of sequencing reads. This new indexing scheme is called a Hierarchical Graph FM index (HGFM).
   * Version: hisat2/2.2.1
   * Needed modules on the Aliance: `StdEnv/2020` # It uses GCC 9.3.0, Intel 2020.1, and Open MPI 4.0.3 as defaults
   * How to load: `module load StdEnv/2020 hisat2/2.2.1`
   
 ### [MultiQC](https://multiqc.info/)
   * Description: Aggregate results from bioinformatics analyses across many samples into a single report
   * Version: MultiQC/1.12
   * Needed module on the Aliance servers: 
     `export MUGQIC_INSTALL_HOME=/cvmfs/soft.mugqic/CentOS6`
     `module use $MUGQIC_INSTALL_HOME/modulefiles`
   * How to load: `module load mugqic/MultiQC/1.12`
  
  ### [Samtools](http://www.htslib.org/)
  * Description: SAM Tools provide various utilities for manipulating alignments in the SAM format, including sorting, merging, indexing and generating alignments in a per-position format.
  * Version: samtools/1.15.1
  * Needed module on the Aliance servers: Needed modules on the Aliance: `StdEnv/2020` # It uses GCC 9.3.0, Intel 2020.1, and Open MPI 4.0.3 as defaults
  * How to load: `module load StdEnv/2020 samtools/1.15.1`
  
  ### [StringTie](https://ccb.jhu.edu/software/stringtie/)
  * Description: StringTie is a fast and highly efficient assembler of RNA-Seq alignments into potential transcripts. It uses a novel network flow algorithm as well as an optional de novo assembly step to assemble and quantitate full-length transcripts representing multiple splice variants for each gene locus. Its input can include not only alignments of short reads that can also be used by other transcript assemblers, but also alignments of longer sequences that have been assembled from those reads. In order to identify differentially expressed genes between experiments, StringTie's output can be processed by specialized software like Ballgown, Cuffdiff or other programs (DESeq2, edgeR, etc.). 
  * Version: stringtie/2.1.5
  * Needed module on the Aliance servers: Needed modules on the Aliance: `StdEnv/2020` # It uses GCC 9.3.0, Intel 2020.1, and Open MPI 4.0.3 as defaults
  * How to load: `module load StdEnv/2020 stringtie/2.1.5`

### chdir, output, and error in SBATCH options causes the job to stop without any error file produced. I still don't know waht is the problem. Could be because I lunch the jobs with make_call_pipe script and not directly. Let me know if you know where the problem could be please.

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
./make_call_pipe.sh jobID_1 you@email.com All yourPIgroup logPrefix
```
