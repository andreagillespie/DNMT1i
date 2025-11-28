#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=0-08:00:00
#SBATCH --output=/dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="Heatmap_DNMT1"
#SBATCH --partition=prod_med

module purge
module load deeptools/3.5.0

computeMatrix reference-point  -S \
/dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/RPGCnorm_BW/gNT-0nM.bw \
/dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/RPGCnorm_BW/gRNF4-0nM.bw \
/dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/RPGCnorm_BW/gNT-100nM.bw \
/dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/RPGCnorm_BW/gRNF4-100nM.bw  \
-R /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bed_files/DNMT1_CGI.bed \
--referencePoint center -a 3000 -b 3000 -out /dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/BW/matrix_merged_CGI_DNMT1i_RPGCnorm.gz

plotHeatmap -m /dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/BW/matrix_merged_CGI_DNMT1i_RPGCnorm.gz \
-out /dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/Plots/CGI_DNMT1i_ATACseq_GnBu_3k_RPGCnorm.pdf --colorMap GnBu \
--samplesLabel "gNT 0nm" "gRNF4 0nm" "gNT 100nm" "gRNF4 100nm"  --legendLocation none --zMax 20 \
--heatmapHeight 15  --refPointLabel peak.center --regionsLabel CGI.DNMT1.peaks --plotTitle 'CpG island DNMT1 peaks' --sortRegion no
