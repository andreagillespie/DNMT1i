#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=48G
#SBATCH --time=0-04:00:00
#SBATCH --output=logs/ATACintergenic%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="ATACintergenic"
#SBATCH --partition=prod_med

module load bedtools/2.27.1

gsize=/data/reference/dawson_labs/genome_size/Hg38_chrom.size

sname=`basename $1 _merged_by_group_rmdup_sort_nMTnU_MAPQ.bam`

#bedtools intersect -a /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/Hyperediting/Hyper_editing/REDItools/intergenic/intergenic.bed -b $1 -wa -c > ${sname}_intergenic_counts.txt

bedtools intersect -a data/intergenic_top15_promoter_500bp.sorted.bed -b $1 -wa -c -sorted > data/${sname}_intergenic_top15_promoter500_ATAC_counts.bed
