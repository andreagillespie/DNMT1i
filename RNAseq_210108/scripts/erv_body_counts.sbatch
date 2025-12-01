#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=prod_short
#SBATCH --mem=120G
#SBATCH --time=0-02:00:00
#SBATCH --output=/dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/Hyperediting/Hyper_editing/REDItools/logs/bam_intersect%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="bam_intersect"

module load bedtools/2.27.1

sname=`basename $1 _merged_rmdup_sort_nMTnU_MAPQ.bam`

bedtools intersect -c -a $1 -b $2 > /scratch/teams/dawson_genomics/Projects/DNMTi/Hyperediting/intergenic/bed_files/${sname}_ATAC_erv_counts.bed

bedtools intersect -c -a $1 -b $3 > /scratch/teams/dawson_genomics/Projects/DNMTi/Hyperediting/intergenic/bed_files/${sname}_ATAC_body_counts.bed

