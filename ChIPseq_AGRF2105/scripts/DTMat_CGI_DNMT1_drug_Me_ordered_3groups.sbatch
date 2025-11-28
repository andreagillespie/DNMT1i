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
/dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bam/RPGCnorm_BW/DNMT1_ChIP_gNT_100nm.bw \
-R /dawson_genomics/Projects/DNMTi/RRBS/bed_files/DNMT_CGI_drug_Me_low.bed /dawson_genomics/Projects/DNMTi/RRBS/bed_files/DNMT_CGI_drug_Me_semi.bed /dawson_genomics/Projects/DNMTi/RRBS/bed_files/DNMT_CGI_drug_Me_high.bed \
--referencePoint center -a 3000 -b 3000 -out /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/outputs/matrix_CGI_DNMT1_RPGCnorm_drug_Me_3groups.gz

plotHeatmap -m /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/outputs/matrix_CGI_DNMT1_RPGCnorm_drug_Me_3groups.gz \
-out /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/plots/CGI_DNMT1_drug_Me_ordered_3groups_YlOrRd_3k_RPGCnorm.pdf --colorMap YlOrRd \
--samplesLabel "gNT 100nm" --regionsLabel "lowMe" "semiMe" "highMe" --legendLocation upper-left \
--heatmapHeight 15  --refPointLabel peak.center --plotTitle 'CpG island DNMT1 peaks, drug Me sorted and grouped' --sortRegion no
