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
  bigwigs/NTC-DMSO-GFP-ChIP_S91.RPGC.bw \
  bigwigs/NTC-DNMT1i-GFP-ChIP_S92.RPGC.bw \
  bigwigs/UHRF1KO-DMSO-GFP-ChIP_S93.RPGC.bw \
  bigwigs/UHRF1KO-DNMT1i-GFP-ChIP_S94.RPGC.bw \
  -R /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bed_files/DNMT1_CGI.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_DNMT_CGI_peaks_refpoint_GFP_UHRF1KO.gz

plotHeatmap -m results/DTmatrix_DNMT_CGI_peaks_refpoint_GFP_UHRF1KO.gz \
  --sortRegion no \
  --samplesLabel Input-WT-1-DMSO Input-WT-1-DNMT1i \
  NTC-DMSO-GFP NTC-DNMT1i-GFP \
  UHRF1KO-DMSO-GFP UHRF1KO-DNMT1i-GFP \
  --regionsLabel "DNMT1 CGI peaks" \
  --colorMap YlOrRd \
  -o plots/Heatmap_DNMT_CGI_peaks_refpoint_GFP_UHRF1KO.pdf \
  --plotTitle "DNMT1 CGI peaks, sorted by manuscript figure"
