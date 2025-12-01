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
-R /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bed_files/Intergenic_all_DNMT1_sortedRegions_sum_10k.bed \
-m 10000 -a 0 -b 0 -out results/BiSeq/DTmatrices/matrix_intergenic_all_RRBSbdg_DNMT1ordered_RPGC.gz

plotHeatmap -m results/BiSeq/DTmatrices/matrix_intergenic_all_RRBSbdg_DNMT1ordered_RPGC.gz \
-out heatmaps/DT_heatmap_intergenic_all_RRBSbdg_DNMT1_peaks_RPGC.pdf --colorMap Oranges \
--samplesLabel "gNT 0nm" "gNT 100nm" --legendLocation none --zMax 1 \
--heatmapHeight 15 --plotTitle 'Intergenic methylation, ordered by DNMT1 peaks' --sortRegion keep
