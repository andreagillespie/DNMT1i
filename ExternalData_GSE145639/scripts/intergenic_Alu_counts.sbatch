#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --partition=prod_short
#SBATCH --mem=100G
#SBATCH --time=0-02:00:00
#SBATCH --output=logs/bam_intersect%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="Alu_intersect"

module load bedtools/2.27.1

# intersect each bam with intergenic bed regions to get counts in each
sname=`basename $1 _raw_ngm.sort.bam`

bedtools intersect -a /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/Hyperediting/Hyper_editing/REDItools/bed_files/intergenic_only.bed \
-b $1 -wa -c > int_counts/${sname}_raw_intergenic_counts.txt

