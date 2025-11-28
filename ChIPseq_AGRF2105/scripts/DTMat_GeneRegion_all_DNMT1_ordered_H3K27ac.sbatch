#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --time=0-08:00:00
#SBATCH --output=/dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="Heatmap_DNMT1"
#SBATCH --partition=prod_med

module purge
module load deeptools/3.5.0

computeMatrix scale-regions -S \
/dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bam/RPGCnorm_BW/H3K27Ac_ChIP_gNT_0nm.bw \
/dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bam/RPGCnorm_BW/H3K27Ac_ChIP_gNT_100nm.bw \
-R bed_files/GR_whitelist_DNMT1_sortedRegions_sum_kmeans3.bed \
-m 10000 -a 2000 -b 2000 -out /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/outputs/matrix_geneRegion_whitelist_RPGCnorm_H3K27ac.gz

plotHeatmap -m /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/outputs/matrix_geneRegion_whitelist_RPGCnorm_H3K27ac.gz \
-out /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/plots/GR_whitelist_H3K27ac_chip_gnuplot_2k_RPGCnorm.pdf --colorMap BuPu \
--samplesLabel "gNT 0nm" "gNT 100nm" --sortRegion keep --zMax 10 \
--heatmapHeight 15 --plotTitle "All genes H3K27ac peaks, 3 kmeans clusters"
