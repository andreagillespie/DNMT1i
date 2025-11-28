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
  bigwigs/Input-WT-1-DMSO_S102.RPGC.bw \
  bigwigs/Input-WT-1-DNMT1i_S103.RPGC.bw \
  bigwigs/WT-1-DMSO-Set2-GFP-ChIP_S95.RPGC.bw \
  bigwigs/WT-1-DNMT1i-Set2-GFP-ChIP_S96.RPGC.bw \
  bigwigs/RC-1-DMSO-Set2-GFP-ChIP_S97.RPGC.bw \
  bigwigs/RC-1-DNMT1i-Set2-GFP-ChIP_S98.RPGC.bw \
  -R ../250217/macs/broadpeaks/DNMT1-WT-DMSO-R2_S51_peaks.broadPeak \
  ../250217/macs/broadpeaks/DNMT1-WT-DNMT1i-R2_S33_peaks.broadPeak \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_WT250217_peaks_refpoint_GFP_Set2.gz

plotHeatmap -m results/DTmatrix_WT250217_peaks_refpoint_GFP_Set2.gz \
  --sortUsingSamples 3 \
  --sortUsing sum \
  --samplesLabel Input-WT-1-DMSO Input-WT-1-DNMT1i \
  WT-1-DMSO-Set2-GFP WT-1-DNMT1i-Set2-GFP \
  RC-1-DMSO-Set2-GFP RC-1-DNMT1i-Set2-GFP \
  --regionsLabel "WT_250217 DMSO peaks" "WT_250217 DNMTi peaks"  \
  --colorMap YlOrRd \
  -o plots/Heatmap_WT250217_peaks_refpoint_GFP_Set2.pdf \
  --plotTitle "WT_250217 peaks, sorted by WT-1-DMSO-Set2-GFP"
