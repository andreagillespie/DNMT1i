#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=prod
#SBATCH --mem=16G
#SBATCH --time=5-00:00:00
#SBATCH --output=logs/ngm_align%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="ngm_align"

module load ngm/0.5.2
module load slamdunk/0.2.4
module load samtools/1.4.1
module load trimmomatic/0.39
module load fastqc/0.11.6

# run ngm paired alignment on trimmed reads, with slamseq settings using same fasta as in Naiara's analysis fpr REDItools (all same as for MR.Gs) 
sname=`basename $1 _1.fastq.gz`
Ref=/dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/STAR/index/GRCh38.p13.genome.fa

#java -jar /config/binaries/trimmomatic/0.39/trimmomatic-0.39.jar PE -threads 1 -phred33 $1 $2 -baseout trim_fastqs/${sname}_trim.fq.gz ILLUMINACLIP:/data/reference/dawson_labs/trimmomatic/TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

#fastqc -o trim_fastqc trim_fastqs/${sname}_trim_1P.fq.gz trim_fastqs/${sname}_trim_2P.fq.gz

ngm -b -r $Ref -1 $1 -2 $2 -t 8 --no-progress --slam-seq 2 -l -o bams/${sname}_raw_ngm.bam

slamdunk filter -o bams -t 8 bams/${sname}_raw_ngm.bam

slamdunk snp -o snps -r $Ref -t 8 bams/${sname}_raw_ngm_filtered.bam

