#!/usr/bin/env bash
#

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=40G
#SBATCH --time=0-23:00:00
#SBATCH --output=logs/star_%j.stdout
#SBATCH --mail-type=END
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="star align"
#SBATCH --partition=prod_med

module load star/2.5.3a

bname=`basename $1 _R1_001_trimmed.fq.gz`

STAR --runThreadN 12 \
    --genomeDir /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/STAR/index \
    --sjdbGTFfile /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/STAR/index/GRCh38_GENCODE_rmsk_TE.gtf \
    --sjdbOverhang 100 \
    --readFilesIn $1 \
    --readFilesCommand zcat \
    --outSAMtype BAM Unsorted \
    --winAnchorMultimapNmax 200 \
    --outFilterMultimapNmax 100 \
    --outFileNamePrefix ./STAR_bams/${bname}_ \
    --outSAMunmapped Within
