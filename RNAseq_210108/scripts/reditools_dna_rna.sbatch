#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=0-06:00:00
#SBATCH --output=REDItools/logs/REDItools%j.stdout
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="REDItools"
#SBATCH --partition=prod_med

module load singularity/3.7.3
module load samtools/1.4.1

# run from dir: /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/Hyperediting/Hyper_editing/
sname=`basename $1 _R2_001.fastq`
samtools sort -o REDItools/bams/${sname}_R2_sort.bam SLAM-DUNK/alignment/${sname}_R2_trim/filter/${sname}_trim_2P.fq_slamdunk_mapped_filtered.bam 
samtools index REDItools/bams/${sname}_R2_sort.bam

mkdir REDItools/results/${sname}_R2

singularity exec --bind /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/:/dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/ \
/config/binaries/singularity/containers_devel/rna_editing_protocol_latest.sif python /REDItools/main/REDItoolDnaRna.py \
-i REDItools/bams/${sname}_R2_sort.bam -W AG,TC -f /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/STAR/index/GRCh38.p13.genome.fa -o REDItools/results/${sname}_R2
