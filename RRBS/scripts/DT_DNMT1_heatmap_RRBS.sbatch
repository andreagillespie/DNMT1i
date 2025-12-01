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

# run from RRBS proj dir
#computeMatrix reference-point  -S \
#results/BiSeq/03_bams/AGRF_CAGRF21035742_H3GYWDSX2/BW/R3_gNT_0nM_d7_H3GYWDSX2_CAGGCGAT_L002_R1.bw \
#results/BiSeq/03_bams/AGRF_CAGRF21035742_H3GYWDSX2/BW/R3_gNT_100nM_d7_H3GYWDSX2_CATGGCAT_L002_R1.bw \
#results/BiSeq/03_bams/AGRF_CAGRF21035742_H3GYWDSX2/BW/R3_gRNF4_1_0nM_d7_H3GYWDSX2_CATTTTAT_L002_R1.bw \
#results/BiSeq/03_bams/AGRF_CAGRF21035742_H3GYWDSX2/BW/R3_gRNF4_1_100nM_d7_H3GYWDSX2_CCAACAAT_L002_R1.bw  \
#-R /dawson_genomics/Projects/DNMTi/ChIPseq/AGRF_CAGRF21056673_H7K2TDSX2/bed_files/DNMT1_peaks_ordered.bed \
#--referencePoint center -a 1000 -b 1000 -out results/BiSeq/DTmatrices/matrix_raw_RRBS_R3_DNMT1_peaks.gz

plotHeatmap -m results/BiSeq/DTmatrices/matrix_raw_RRBS_R1_DNMT1_peaks.gz \
-out heatmaps/DT_heatmap_raw_RRBS_R1_DNMT1_peaks.pdf --colorMap PuBu_r \
--samplesLabel "gNT 0nm" "gNT 100nm" "gRNF4 0nm" "gRNF4 100nm" --legendLocation none \
--outFileSortedRegions bed_files/plot_regions_R1_DNMT1_heatmap.bed --zMax 50 \
--heatmapHeight 15  --refPointLabel peak.center --regionsLabel DNMT1.peaks --plotTitle 'methylation at DNMT1 peaks' --sortRegion no
