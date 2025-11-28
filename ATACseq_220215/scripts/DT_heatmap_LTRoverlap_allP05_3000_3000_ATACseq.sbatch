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

computeMatrix reference-point -S \
/dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/RPGCnorm_BW/gNT-0nM.bw \
/dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/RPGCnorm_BW/gNT-100nM.bw \
/dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/RPGCnorm_BW/gRNF4-0nM.bw \
/dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/RPGCnorm_BW/gRNF4-100nM.bw \
-R /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/Hyperediting/Hyper_editing/REDItools/bed_files/LTR_overlap_allP05_expression_ordered_2000_10000.bed \
--referencePoint center -a 3000 -b 3000 -out BW/matrix_LTRs_overlap_allP05_3000_3000_RPGCnorm.gz

plotHeatmap -m /dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/BW/matrix_LTRs_overlap_allP05_3000_3000_RPGCnorm.gz \
-out /dawson_genomics/Projects/DNMTi/ATACseq/220215_A01524_0015_BHTTYMDRXY/Plots/DT_heatmap_ATACseq_LTRs_overlap_allP05_3000_3000.pdf --colorMap GnBu \
--samplesLabel "gNT 0nm" "gNT 100nm" "gRNF4 0nm" "gRNF4 100nm" --legendLocation none --sortRegion keep \
--heatmapHeight 15  --plotTitle "accessibility at LTRs w/RNAseq overlap in drug (ordered by expression)"
