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
  -R /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bed_files/DNMT1_CGI.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_DNMT_CGI_peaks_refpoint_GFP_Set2.gz

plotHeatmap -m results/DTmatrix_DNMT_CGI_peaks_refpoint_GFP_Set2.gz \
  --sortRegion no \
  --samplesLabel Input-WT-1-DMSO Input-WT-1-DNMT1i \
  WT-1-DMSO-Set2-GFP WT-1-DNMT1i-Set2-GFP \
  RC-1-DMSO-Set2-GFP RC-1-DNMT1i-Set2-GFP \
  --regionsLabel "DNMT1 CGI peaks" \
  --colorMap YlOrRd \
  -o plots/Heatmap_DNMT_CGI_peaks_refpoint_GFP_Set2.pdf \
  --plotTitle "DNMT1 CGI peaks, sorted by manuscript figure"
