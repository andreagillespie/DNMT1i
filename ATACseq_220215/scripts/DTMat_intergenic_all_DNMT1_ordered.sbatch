#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=0-08:00:00
#SBATCH --output=/dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="Heatmap_DNMT1"
#SBATCH --partition=prod_med

module purge
module load deeptools/3.5.0

computeMatrix scale-regions -S \
/dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/RPGCnorm_BW/gNT-0nM.bw \
/dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/RPGCnorm_BW/gNT-100nM.bw \
-R /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bed_files/Intergenic_all_DNMT1_sortedRegions_sum_10k.bed \
-m 10000 -a 0 -b 0 -out /dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/BW/matrix_intergenic_all_DNMT1_RPGCnorm.gz

plotHeatmap -m /dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/BW/matrix_intergenic_all_DNMT1_RPGCnorm.gz \
-out /dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/Plots/GR_intergenic_DNMT1_ATACseq_magma_2k_RPGCnorm.pdf --colorMap GnBu \
--samplesLabel "gNT 0nm" "gNT 100nm" --legendLocation none --sortRegion keep --zMax 1 \
--heatmapHeight 15  --plotTitle 'Intergenic regions >= 10kb, DNMT1 peaks ordered'
