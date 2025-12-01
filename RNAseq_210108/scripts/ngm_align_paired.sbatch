#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=prod_med
#SBATCH --mem=32G
#SBATCH --time=0-08:00:00
#SBATCH --output=REDItools/logs/ngm_align%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="ngm_align"

module load ngm/0.5.2
module load slamdunk/0.2.4
module load samtools/1.4.1

# run ngm paired alignment on trimmed reads, with slamseq settings using same fasta as in Naiara's analysis fpr REDItools 
sname=`basename $1 _R1_001.fastq`
Ref=/dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/STAR/index/GRCh38.p13.genome.fa

ngm -b -r $Ref -1 $1 -2 $2 -t 8 --no-progress --slam-seq 2 -l -o REDItools/bams/${sname}_ngm.bam

slamdunk filter -o REDItools/bams -t 8 REDItools/bams/${sname}_ngm.bam

slamdunk snp -o REDItools/snps -r $Ref -t 8 REDItools/bams/${sname}_ngm_filtered.bam

