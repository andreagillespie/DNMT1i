#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=0-02:00:00
#SBATCH --output="logs/DTMatrix%j.stdout"
#SBATCH --mail-type=END
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="Heatmap_LTRs"
#SBATCH --partition=prod_short

module purge
module load deeptools/3.5.0

# run from REDItools proj dir
computeMatrix reference-point -S \
bams/bigwigs/4NT-DMSO_S9.bw \
bams/bigwigs/4KD-DMSO_S10.bw \
bams/bigwigs/4NT-DNMT1i_S11.bw \
bams/bigwigs/4KD-DNMT1i_S12.bw \
-R /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/Hyperediting/REDItools/bed_files/mintRNA_expression_ordered_5kb_500kb.bed \
--referencePoint center -a 500000 -b 50000 -out results/DTmatrices/matrix_4KD_mintRNA_50kb_500kb_RPGCnorm.gz

### sample names are not correct as there was a mixup in MGC, confimed by 4NTv4KD in IGV, labelling correctly in heatmaps
plotHeatmap -m results/DTmatrices/matrix_4KD_mintRNA_50kb_500kb_RPGCnorm.gz \
-out plots/DT_heatmap_4KD_RNAseq_mintRNA_50kb_500kb.pdf --colorMap YlGn \
--outFileSortedRegions bed_files/4KD_mintRNA_expression_ordered_50kb_500kb.bed \
--samplesLabel "4NT DMSO" "4NT DNMTi" "4KD DMSO" "4KD DNMTi" --sortRegions keep \
--refPointLabel center --regionsLabel LTRs --legendLocation none --zMax 1 --yMax 40 --yMin 0 \
--heatmapHeight 5 --plotTitle "expression at TINATs, ordered the same as other heatmaps"
