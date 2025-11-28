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
  bigwigs/WT-1-DMSO-GFP-ChIP_S101.RPGC.bw \
  bigwigs/WT-1-DNMT1i-GFP-ChIP_S104.RPGC.bw \
  bigwigs/RFTS-DMSO.merged.bw \
  bigwigs/RFTS-DNMTi.merged.bw \
  bigwigs/RC-DMSO.merged.bw \
  -R ../250217/bdgdiff/DNMT1-DMSO-CXXCvsWT_c3.0_cond2.bed \
  bdgdiff/DMSO-RFTSvsWT_c3.0_cond1.bed \
  bdgdiff/DMSO-RFTSvsWT_c3.0_cond2.bed \
  bdgdiff/DMSO-RCvsWT_c3.0_cond1.bed \
  bdgdiff/DMSO-RCvsWT_c3.0_cond2.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_merged_CXXC_RFTS_RC_diffpeaks_refpoint.gz

plotHeatmap -m results/DTmatrix_merged_CXXC_RFTS_RC_diffpeaks_refpoint.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel WT-DMSO WT-DNMT1i RFTS-DMSO RFTS-DNMT1i RC-DMSO \
  --regionsLabel "∆CXXC down" "∆RFTS up" "∆RFTS down" "∆RC up" "∆RC down" \
  --colorMap YlOrRd \
  -o plots/Heatmap_merged_CXXC_RFTS_RC_diffpeaks_refpoint.pdf \
  --plotTitle "∆CXXC, ∆RFTS, ∆RC diff peaks"

plotProfile -m results/DTmatrix_merged_CXXC_RFTS_RC_diffpeaks_refpoint.gz \
  -o plots/Profile_merged_CXXC_RFTS_RC_diffpeaks_refpoint.pdf \
--samplesLabel WT-DMSO WT-DNMT1i RFTS-DMSO RFTS-DNMT1i RC-DMSO \
  --regionsLabel "∆CXXC down" "∆RFTS up" "∆RFTS down" "∆RC up" "∆RC down" \
  --plotTitle "∆CXXC, ∆RFTS, ∆RC diff peaks" \
  --perGroup
