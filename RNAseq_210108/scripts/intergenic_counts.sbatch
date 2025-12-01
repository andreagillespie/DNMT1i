#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=prod_med
#SBATCH --mem=80G
#SBATCH --time=1-00:00:00
#SBATCH --output=../logs/bam_intersect%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="bam_intersect"

module load bedtools/2.27.1
module load samtools/1.8

# intersect each bam with intergenic bed regions to get counts in each
sname=`basename $1 _ngm_filtered.bam`

# sort bam first for better memory usage
#samtools sort -o ../bams/${sname}.sort.bam $1

bedtools intersect -a intergenic.bed -b ../bams/${sname}.sort.bam -wa -c > ${sname}_intergenic_counts.txt

