#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="Heatmap_DNMT1"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module purge
module load deeptools/3.5.0

computeMatrix reference-point -S \
  bigwigs/DNMT1i_allRuns.merged.RPGC.bw \
  -R /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/Hyperediting/REDItools/bed_files/mintRNA_expression_ordered_5kb_500kb.bed \
  --referencePoint TSS \
  -a 500000 \
  -b 50000 \
  -out results/matrix_mintRNA_50k_500k_RPGCnorm.gz \
  -p max

plotHeatmap -m results/matrix_mintRNA_50k_500k_RPGCnorm.gz \
  -out plots/DT_heatmap_nanopore_mintRNA_50k_500k.pdf \
  --colorMap PuRd \
  --samplesLabel "gNT 0nm" \
  --legendLocation none \
  --sortRegion keep \
  --heatmapHeight 5  \
  --plotTitle "Nanopore expression at mintRNAs \n(ordered by gNT DNMTi short read expression)"
