#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=48G
#SBATCH --time=0-16:00:00
#SBATCH --output=logs/ATACintergenic%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="ATACintergenic"
#SBATCH --partition=prod_med

module load bedtools/2.27.1
#module load samtools/1.8

sname=`basename $1 _merged_by_group_rmdup_sort_nMTnU_MAPQ.bam`

# convert to bed and sort lexicographically to use sorting algorithm (otherwise requires >200G mem)
bedtools bamtobed -i $1 > Processed_files_downsampled/${sname}_bam.bed
sort -k1,1 -k2,2n Processed_files_downsampled/${sname}_bam.bed > Processed_files_downsampled/${sname}_bam.sorted.bed

bedtools intersect -a data/intergenic_top15_promoter_500bp.sorted.bed -b Processed_files_downsampled/${sname}_bam.sorted.bed -wa -c -sorted > data/${sname}_intergenic_top15_promoter500_ATAC_counts.bed

bedtools intersect -a data/intergenic_top15_regions.sorted.bed -b Processed_files_downsampled/${sname}_bam.sorted.bed -wa -c -sorted > data/${sname}_intergenic_top15_regions_ATAC_counts.bed

#bedtools intersect -a /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/Hyperediting/Hyper_editing/REDItools/intergenic/intergenic.bed -b $1 -wa -c > ${sname}_intergenic_counts.txt

# remove intermediate files to save space
rm Processed_files_downsampled/${sname}_bam.bed
