#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=32G
#SBATCH --time=0-12:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module purge

module load deeptools/3.5.0

computeMatrix reference-point --referencePoint center -S \
  bigwigs/DNMT1-WT-DMSO.merged.bw \
  bigwigs/DNMT1-WT-DNMT1i.merged.bw \
  bigwigs/DNMT1-CXXC-DMSO.merged.bw \
  bigwigs/DNMT1-CXXC-DNMT1i.merged.bw \
  -R /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bed_files/DNMT1_CGI.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_RPGCnorm_merged_DNMT_CGI_CXXC_peaks_refpoint.gz

plotHeatmap -m results/DTmatrix_RPGCnorm_merged_DNMT_CGI_CXXC_peaks_refpoint.gz \
  --sortRegion no \
  --samplesLabel WT-DMSO WT-DNMT1i CXXC-DMSO CXXC-DNMT1i \
  --regionsLabel "DNMT1 CGI peaks" \
  --colorMap YlOrRd \
  -o plots/Heatmap_RPGCnorm_merged_DNMT_CGI_CXXC_peaks_refpoint.pdf \
  --plotTitle "DNMT1 CGI peaks, sorted by manuscript figure"

plotProfile -m results/DTmatrix_RPGCnorm_merged_DNMT_CGI_CXXC_peaks_refpoint.gz \
  -o plots/Profile_RPGCnorm_merged_DNMT_CGI_CXXC_peaks_refpoint.pdf \
--samplesLabel WT-DMSO WT-DNMT1i CXXC-DMSO CXXC-DNMT1i \
  --regionsLabel "DNMT1 CGI peaks" \
  --plotTitle "DNMT1 CGI peaks" \
  --perGroup
