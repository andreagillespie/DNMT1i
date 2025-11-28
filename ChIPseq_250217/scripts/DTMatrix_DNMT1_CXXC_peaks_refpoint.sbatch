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
  bigwigs/DNMT1-WT-DMSO-R1_S37.RPGC.bw \
  bigwigs/DNMT1-WT-DMSO-R2_S51.RPGC.bw \
  bigwigs/DNMT1-WT-DNMT1i-R1_S38.RPGC.bw \
  bigwigs/DNMT1-WT-DNMT1i-R2_S33.RPGC.bw \
  bigwigs/DNMT1-CXXC-DMSO-R1_S39.RPGC.bw \
  bigwigs/DNMT1-CXXC-DMSO-R2_S34.RPGC.bw \
  bigwigs/DNMT1-CXXC-DNMT1i-R1_S40.RPGC.bw \
  bigwigs/DNMT1-CXXC-DNMT1i-R2_S35.RPGC.bw \
  -R macs/broadpeaks/DNMT1-WT-DMSO-R2_S51_peaks.broadPeak \
  macs/broadpeaks/DNMT1-WT-DNMT1i-R2_S33_peaks.broadPeak \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_RPGCnorm_DNMT_CXXC_peaks_refpoint.gz

plotHeatmap -m results/DTmatrix_RPGCnorm_DNMT_CXXC_peaks_refpoint.gz \
  --sortUsingSamples 2 \
  --sortUsing sum \
  --samplesLabel WT-DMSO-R1 WT-DMSO-R2 WT-DNMT1i-R1 WT-DNMT1i-R2 \
  CXXC-DMSO-R1 CXXC-DMSO-R2 CXXC-DNMT1i-R1 CXXC-DNMT1i-R2 \
  --regionsLabel "WT DMSO R2 peaks" "WT DNMTi R2 peaks" \
  --colorMap YlOrRd \
  -o plots/Heatmap_RPGCnorm_DNMT_CXXC_peaks_refpoint.pdf \
  --plotTitle "WT DMSO & DNMTi peaks, WT DMSO R2 ordered"

plotProfile -m results/DTmatrix_RPGCnorm_DNMT_CXXC_peaks_refpoint.gz \
  -o plots/Profile_RPGCnorm_DNMT_CXXC_peaks_refpoint.pdf \
  --samplesLabel WT-DMSO-R1 WT-DMSO-R2 WT-DNMT1i-R1 WT-DNMT1i-R2 \
  CXXC-DMSO-R1 CXXC-DMSO-R2 CXXC-DNMT1i-R1 CXXC-DNMT1i-R2 \
  --regionsLabel "WT DMSO R2 peaks" "WT DNMTi R2 peaks" \
  --plotTitle "WT DMSO & DNMTi peaks" \
  --perGroup
