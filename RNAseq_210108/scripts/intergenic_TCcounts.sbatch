#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=prod_med
#SBATCH --mem=80G
#SBATCH --time=0-04:00:00
#SBATCH --output=logs/bam_intersect%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="bam_intersect"

module load bedtools/2.27.1

# intersect each bam with intergenic bed regions to get counts in each
sname=`basename $1 _ngm_filtered_TCReads.bam`

bedtools intersect -a bed_files/intergenic_only.bed -b $1 -wa -c > intergenic/${sname}_intergenic_TCcounts.txt

