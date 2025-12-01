#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=0-02:00:00
#SBATCH --output="logs/DTMatrix%j.stdout"
#SBATCH --mail-type=END
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="Heatmap_LTRs"
#SBATCH --partition=prod_short

module purge
module load deeptools/3.5.0

# run from REDItools proj dir
computeMatrix reference-point -S \
bams/RPGC_norm_BW/gNT-0nM-d7_ngm_filtered.bw \
bams/RPGC_norm_BW/gNT-100nM-d7_ngm_filtered.bw \
bams/RPGC_norm_BW/gRNF4-1-0nM-d7_ngm_filtered.bw \
bams/RPGC_norm_BW/gRNF4-1-100nM-d7_ngm_filtered.bw \
-R bed_files/mintRNA_coords.bed \
--referencePoint center -a 500000 -b 50000 -out results/DTmatrices/matrix_mintRNA_50kb_500kb_RPGCnorm.gz

plotHeatmap -m results/DTmatrices/matrix_mintRNA_50kb_500kb_RPGCnorm.gz \
-out plots/DT_heatmap_RNAseq_mintRNA_50kb_500kb.pdf --colorMap YlGn --sortUsingSamples 2 \
--outFileSortedRegions bed_files/mintRNA_expression_ordered_5kb_500kb.bed --samplesLabel "gNT 0nm" "gNT 100nm" "gRNF4 0nm" "gRNF4 100nm" \
--refPointLabel center --regionsLabel LTRs --zMax 1 --yMax 20 --yMin 0 --legendLocation none \
--heatmapHeight 5 --plotTitle "expression at TINATs, ordered by gNT DNMT1i"
