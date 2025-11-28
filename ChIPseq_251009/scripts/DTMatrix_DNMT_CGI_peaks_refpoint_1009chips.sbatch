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
  bigwigs/WT-DMSO-R2-input_S171.RPGC.bw \
  bigwigs/WT-dTAG-DNMT1i-R2-input_S172.RPGC.bw \
  bigwigs/WT-DMSO-ChIP-GFP-R1_S173.RPGC.bw \
  bigwigs/WT-DMSO-ChIP-GFP-R2_S180.RPGC.bw \
  bigwigs/WT-dTAG-ChIP-GFP-R1_S175.RPGC.bw \
  bigwigs/WT-dTAG-ChIP-GFP-R2_S181.RPGC.bw \
  bigwigs/WT-dTAG-DNMT1i-ChIP-GFP-R1_S176.RPGC.bw \
  bigwigs/WT-dTAG-DNMT1i-ChIP-GFP-R2_S182.RPGC.bw \
  bigwigs/CW-DMSO-ChIP-GFP-R1_S177.RPGC.bw \
  bigwigs/CW-DMSO-ChIP-GFP-R2_S163.RPGC.bw \
  bigwigs/CW-dTAG-ChIP-GFP-R1_S178.RPGC.bw \
  bigwigs/CW-dTAG-ChIP-GFP-R2_S164.RPGC.bw \
  bigwigs/CW-dTAG-DNMT1i-ChIP-GFP-R1_S179.RPGC.bw \
  bigwigs/CW-dTAG-DNMT1i-ChIP-GFP-R2_S165.RPGC.bw \
  bigwigs/MV411-A3-DMSO-24h-input_S174.RPGC.bw \
  bigwigs/MV411-A3-DMSO-24h-ChIP-Rb-Abcam_S169.RPGC.bw \
  bigwigs/MV411-A3-DMSO-24h-ChIP-V5_S166.RPGC.bw \
  bigwigs/MV411-A3-dTAG-24h-ChIP-Rb-Abcam_S170.RPGC.bw \
  bigwigs/MV411-A3-dTAG-24h-ChIP-V5_S167.RPGC.bw \
  bigwigs/MV411-ChIP-V5_S168.RPGC.bw \
  -R /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bed_files/DNMT1_CGI.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_DNMT_CGI_peaks_refpoint_1009chips.gz

plotHeatmap -m results/DTmatrix_DNMT_CGI_peaks_refpoint_1009chips.gz \
  --sortRegion no \
  --samplesLabel WT-DMSO-R2-input WT-dTAG-DNMT1i-R2-input \
  WT-DMSO-ChIP-GFP-R1 WT-DMSO-ChIP-GFP-R2 \
  WT-dTAG-ChIP-GFP-R1 WT-dTAG-ChIP-GFP-R2 \
  WT-dTAG-DNMT1i-ChIP-GFP-R1 WT-dTAG-DNMT1i-ChIP-GFP-R2 \
  CW-DMSO-ChIP-GFP-R1 CW-DMSO-ChIP-GFP-R2 \
  CW-dTAG-ChIP-GFP-R1 CW-dTAG-ChIP-GFP-R2 \
  CW-dTAG-DNMT1i-ChIP-GFP-R1 CW-dTAG-DNMT1i-ChIP-GFP-R2 \
  MV411-A3-DMSO-24h-input MV411-A3-DMSO-24h-ChIP-Rb-Abcam \
  MV411-A3-DMSO-24h-ChIP-V5 MV411-A3-dTAG-24h-ChIP-Rb-Abcam \
  MV411-A3-dTAG-24h-ChIP-V5 MV411-ChIP-V5 \
  --regionsLabel "DNMT1 CGI peaks" \
  --colorMap YlOrRd \
  -o plots/Heatmap_DNMT_CGI_peaks_refpoint_1009chips.pdf \
  --plotTitle "DNMT1 CGI peaks, sorted by manuscript figure"
