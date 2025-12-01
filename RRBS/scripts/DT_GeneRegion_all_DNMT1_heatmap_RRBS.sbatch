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

# run from RRBS proj dir
computeMatrix scale-regions -S \
/dawson_genomics/Projects/DNMTi/RRBS/BW/gNT_0nM_sorted.bedGraph.bw \
/dawson_genomics/Projects/DNMTi/RRBS/BW/gNT_100nM_sorted.bedGraph.bw \
-R /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bed_files/GR_whitelist_DNMT1_sortedRegions_sum_kmeans3.bed \
-m 10000 -a 2000 -b 2000 -out results/BiSeq/DTmatrices/matrix_geneRegion_whitelist_RRBSbdg_DNMT1ordered_RPGC.gz

plotHeatmap -m results/BiSeq/DTmatrices/matrix_geneRegion_whitelist_RRBSbdg_DNMT1ordered_RPGC.gz \
-out heatmaps/DT_heatmap_geneRegion_whitelist_RRBSbdg_DNMT1_peaks_RPGC.pdf --colorMap pink_r \
--samplesLabel "gNT 0nm" "gNT 100nm" --zMax 1 \
--heatmapHeight 15 --plotTitle 'methylation at all genes, DNMT1 3 kmeans clusters' --sortRegion keep
