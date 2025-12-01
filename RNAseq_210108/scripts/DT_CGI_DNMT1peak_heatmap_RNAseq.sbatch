#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=1-00:00:00
#SBATCH --output="logs/DTMatrix%j.stdout"
#SBATCH --mail-type=END
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="Heatmap_DNMT1"
#SBATCH --partition=prod_med

module purge
module load deeptools/3.5.0

# run from REDItools proj dir
computeMatrix reference-point -S \
bams/RPGC_norm_BW/gNT-0nM-d7_ngm_filtered.bw \
bams/RPGC_norm_BW/gNT-100nM-d7_ngm_filtered.bw \
-R /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bed_files/DNMT1_CGI.bed \
--referencePoint center -a 3000 -b 3000 -out results/DTmatrices/matrix_CGI_DNMT1_RPGCnorm.gz

plotHeatmap -m results/DTmatrices/matrix_CGI_DNMT1_RPGCnorm.gz \
-out plots/DT_heatmap_CGI_DNMT1peaks_RNAseq_DNMT1.pdf --colorMap YlGn \
--samplesLabel "gNT 0nm" "gNT 100nm" --refPointLabel peak.center --regionsLabel CGI.DNMT1.peaks --zMax 5 \
--heatmapHeight 15 --plotTitle 'expression at CpG island DNMT1 peaks' --sortRegion no
