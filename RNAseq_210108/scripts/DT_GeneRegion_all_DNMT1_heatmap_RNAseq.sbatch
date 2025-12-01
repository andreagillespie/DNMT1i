#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=1-00:00:00
#SBATCH --output="logs/DTMatrix%j.stdout"
#SBATCH --mail-type=END
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="Heatmap_DNMT1"
#SBATCH --partition=prod_med

module purge
module load deeptools/3.5.0

# run from REDItools proj dir
computeMatrix scale-regions -S \
bams/RPGC_norm_BW/gNT-0nM-d7_ngm_filtered.bw \
bams/RPGC_norm_BW/gNT-100nM-d7_ngm_filtered.bw \
-R /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bed_files/GR_whitelist_DNMT1_sortedRegions_sum_kmeans3.bed \
-m 10000 -a 2000 -b 2000 -out results/DTmatrices/matrix_geneRegion_whitelist_RNAseq_DNMT1ordered_RPGC.gz

plotHeatmap -m results/DTmatrices/matrix_geneRegion_whitelist_RNAseq_DNMT1ordered_RPGC.gz \
-out plots/DT_heatmap_geneRegion_whitelist_RNAseq_DNMT1_peaks_RPGC.pdf --colorMap YlGn \
--samplesLabel "gNT 0nm" "gNT 100nm" --zMax 1 \
--heatmapHeight 15 --plotTitle 'expression at all genes, 3 kmeans clusters on DNMT1 peaks' --sortRegion keep
