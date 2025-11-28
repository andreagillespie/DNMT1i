#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=0-20:00:00
#SBATCH --output="logs/DTMatrix%j.stdout"
#SBATCH --mail-type=END
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="Heatmap_MINTs"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module purge
module load deeptools/3.5.0

# run from REDItools proj dir
computeMatrix reference-point -S \
  bigwigs/WT-gNT-DMSO_Me_ratio.bw \
  bigwigs/WT-gNT-DNMT1i_Me_ratio.bw \
  bigwigs/WT-gRNF4-DMSO_Me_ratio.bw \
  bigwigs/WT-gRNF4-DNMT1i_Me_ratio.bw \
  -R /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/Hyperediting/REDItools/bed_files/mintRNA_expression_ordered_5kb_500kb.bed \
  --referencePoint TSS \
  -a 500000 -b 50000 \
  -out results/matrix_mintRNA_50kb_500kb_Me_ratio.gz

plotHeatmap -m results/matrix_mintRNA_50kb_500kb_Me_ratio.gz \
  -out plots/DT_heatmap_Me_ratio_mintRNA_50kb_500kb.pdf \
  --colorMap jet \
  --sortRegion keep
  --samplesLabel "gNT 0nm" "gNT 100nm" "gRNF4 0nm" "gRNF4 100nm" \
  --refPointLabel TSS \
  --regionsLabel mintRNAs \
  --legendLocation none \
  --heatmapHeight 5 \
  --plotTitle "expression at mintRNAs, ordered by RNAseq"
  #--zMax 1 --yMax 20 --yMin 0 
