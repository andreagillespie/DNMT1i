#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=0-04:00:00
#SBATCH --output=/dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="Heatmap_DNMT1"
#SBATCH --partition=prod_med

module purge
module load deeptools/3.5.0

computeMatrix reference-point  -S \
/dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bam/RPGCnorm_BW/DNMT1_ChIP_gNT_0nm.bw \
/dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bam/RPGCnorm_BW/DNMT1_ChIP_gRNF4_0nm.bw \
/dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bam/RPGCnorm_BW/DNMT1_ChIP_gNT_100nm.bw \
/dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bam/RPGCnorm_BW/DNMT1_ChIP_gRNF4_100nm.bw \
-R /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bed_files/DNMT1_CGI.bed \
--referencePoint center -a 3000 -b 3000 -out /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/outputs/matrix_CGI_DNMT1_RPGCnorm.gz

plotHeatmap -m /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/outputs/matrix_CGI_DNMT1_RPGCnorm.gz \
-out /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/plots/CGI_DNMT1_chip_YlOrRd_3k_RPGCnorm.pdf --colorMap YlOrRd \
--samplesLabel "gNT 0nm" "gRNF4 0nm" "gNT 100nm" "gRNF4 100nm" --legendLocation none \
--heatmapHeight 15  --refPointLabel peak.center --regionsLabel CGI.DNMT1.peaks --plotTitle 'CpG island DNMT1 peaks' --sortRegion no
