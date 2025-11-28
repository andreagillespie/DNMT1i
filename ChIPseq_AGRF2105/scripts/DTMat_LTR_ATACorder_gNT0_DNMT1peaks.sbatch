#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=1-00:00:00
#SBATCH --output=/dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="Heatmap_DNMT1"
#SBATCH --partition=prod_med

module purge
module load deeptools/3.5.0

computeMatrix reference-point  -S \
/dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bam/RPGCnorm_BW/DNMT1_ChIP_gNT_0nm.bw \
/dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bam/RPGCnorm_BW/DNMT1_ChIP_gNT_100nm.bw \
/dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bam/RPGCnorm_BW/DNMT1_ChIP_gRNF4_0nm.bw \
/dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bam/RPGCnorm_BW/DNMT1_ChIP_gRNF4_100nm.bw \
-R /dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/bed_files/LTR_ATACpeaks_sum_sorted_gNT0.bed \
--referencePoint center -a 500 -b 500 -out /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/outputs/matrix_LTR_ATACorder_gNT0_RPGCnorm.gz

plotHeatmap -m /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/outputs/matrix_LTR_ATACorder_gNT0_RPGCnorm.gz \
-out /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/plots/DNMT1peaks_LTR_ATACorder_gNT0_YlOrRd_RPGCnorm.pdf --colorMap YlOrRd \
--samplesLabel "gNT 0nm" "gNT 100nm" "gRNF4 0nm" "gRNF4 100nm" --legendLocation none --zMax 2 \
--heatmapHeight 15  --refPointLabel peak.center --regionsLabel LTR.ATAC.peaks --plotTitle 'LTR ATACseq peaks' --sortRegion no
