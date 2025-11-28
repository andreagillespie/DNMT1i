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
  bigwigs/INPUT-1_S41.RPGC.bw \
  bigwigs/INPUT-2_S42.RPGC.bw \
  bigwigs/DNMT1-WT-DMSO-R2_S51.RPGC.bw \
  bigwigs/DNMT1-WT-DNMT1i-R2_S33.RPGC.bw \
  bigwigs/MV411-parental-anti-GFP-control_S36.RPGC.bw \
  -R /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bed_files/DNMT1_CGI.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_RPGCnorm_DNMT_CGI_Winputs_refpoint.gz

plotHeatmap -m results/DTmatrix_RPGCnorm_DNMT_CGI_Winputs_refpoint.gz \
  --sortUsingSamples 3 \
  --sortUsing sum \
  --samplesLabel INPUT-1 INPUT-2 WT-DMSO-R2 WT-DNMT1i-R2 \
  MV411-parental-anti-GFP-control \
  --regionsLabel "DNMT1 CGIs" \
  --colorMap YlOrRd \
  -o plots/Heatmap_RPGCnorm_DNMT_CGI_Winputs_refpoint.pdf \
  --plotTitle "DNMT1 CGIs, WT DMSO R2 ordered"

plotProfile -m results/DTmatrix_RPGCnorm_DNMT_CGI_Winputs_refpoint.gz \
  -o plots/Profile_RPGCnorm_DNMT_CGI_Winputs_refpoint.pdf \
  --samplesLabel INPUT-1 INPUT-2 WT-DMSO-R2 WT-DNMT1i-R2 \
  MV411-parental-anti-GFP-control \
  --regionsLabel "DNMT1 CGIs" \
  --plotTitle "DNMT1 CGIs, WT DMSO R2 ordered" \
  --perGroup
