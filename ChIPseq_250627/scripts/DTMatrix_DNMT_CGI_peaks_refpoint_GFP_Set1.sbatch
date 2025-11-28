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
  bigwigs/RFTS-1-DMSO-GFP-ChIP_S105.RPGC.bw \
  bigwigs/RFTS-2-DMSO-GFP-ChIP_S109.RPGC.bw \
  bigwigs/RFTS-1-DNMT1i-GFP-ChIP_S106.RPGC.bw \
  bigwigs/RFTS-2-DNMT1i-GFP-ChIP_S110.RPGC.bw \
  bigwigs/RC-1-DMSO-GFP-ChIP_S107.RPGC.bw \
  bigwigs/RC-2-DMSO-GFP-ChIP_S108.RPGC.bw \
  bigwigs/MV411-CST-GFP-ChIP_S100.RPGC.bw \
  bigwigs/MV411-parental-GFP-ChIP_S111.RPGC.bw \
  bigwigs/WT-1-DMSO-CST-GFP-ChIP_S99.RPGC.bw \
  bigwigs/WT-1-DMSO-GFP-ChIP_S101.RPGC.bw \
  bigwigs/WT-1-DNMT1i-GFP-ChIP_S104.RPGC.bw \
  -R /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bed_files/DNMT1_CGI.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_DNMT_CGI_peaks_refpoint_GFP_Set1.gz

plotHeatmap -m results/DTmatrix_DNMT_CGI_peaks_refpoint_GFP_Set1.gz \
  --sortRegion no \
  --samplesLabel Input-WT-1-DMSO Input-WT-1-DNMT1i \
  RFTS-1-DMSO-GFP RFTS-2-DMSO-GFP \
  RFTS-1-DNMT1i-GFP RFTS-2-DNMT1i-GFP \
  RC-1-DMSO-GFP RC-2-DMSO-GFP \
  MV411-CST-GFP MV411-parental-GFP \
  WT-1-DMSO-CST-GFP WT-1-DMSO-GFP WT-1-DNMT1i-GFP \
  --regionsLabel "DNMT1 CGI peaks" \
  --colorMap YlOrRd \
  -o plots/Heatmap_DNMT_CGI_peaks_refpoint_GFP_Set1.pdf \
  --plotTitle "DNMT1 CGI peaks, sorted by manuscript figure"
