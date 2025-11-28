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
  bigwigs/DNMT1-WT-gNT-DMSO-R1_S43.RPGC.bw \
  bigwigs/DNMT1-WT-gNT-DNMT1i-R1_S47.RPGC.bw \
  bigwigs/DNMT1-WT-gRNF4-DMSO-R1_S44.RPGC.bw \
  bigwigs/DNMT1-WT-gRNF4-DNMT1i-R1_S48.RPGC.bw \
  bigwigs/DNMT1-KR-gNT-DMSO-R1_S45.RPGC.bw \
  bigwigs/DNMT1-KR-gNT-DNMT1i-R1_S49.RPGC.bw \
  bigwigs/DNMT1-KR-gRNF4-DMSO-R1_S46.RPGC.bw \
  bigwigs/DNMT1-KR-gRNF4-DNMT1i-R1_S50.RPGC.bw \
  -R /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bed_files/DNMT1_CGI.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_RPGCnorm_DNMT_CGI_KR_peaks_refpoint.gz

plotHeatmap -m results/DTmatrix_RPGCnorm_DNMT_CGI_KR_peaks_refpoint.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel WT-gNT-DMSO WT-gNT-DNMT1i WT-gRNF4-DMSO WT-gRNF4-DNMT1i \
  KR-gNT-DMSO KR-gNT-DNMT1i KR-gRNF4-DMSO KR-gRNF4-DNMT1i \
  --regionsLabel "DNMT1 CGI peaks" \
  --colorMap YlOrRd \
  -o plots/Heatmap_RPGCnorm_DNMT_CGI_KR_peaks_refpoint.pdf \
  --plotTitle "DNMT1 CGI peaks, WT gNT DMSO ordered"

plotProfile -m results/DTmatrix_RPGCnorm_DNMT_CGI_KR_peaks_refpoint.gz \
  -o plots/Profile_RPGCnorm_DNMT_CGI_KR_peaks_refpoint.pdf \
  --samplesLabel WT-gNT-DMSO WT-gNT-DNMT1i WT-gRNF4-DMSO WT-gRNF4-DNMT1i \
  KR-gNT-DMSO KR-gNT-DNMT1i KR-gRNF4-DMSO KR-gRNF4-DNMT1i \
  --regionsLabel "DNMT1 CGI peaks" \
  --plotTitle "DNMT1 CGI peaks" \
  --perGroup
