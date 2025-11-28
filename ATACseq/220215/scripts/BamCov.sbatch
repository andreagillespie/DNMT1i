#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=24G
#SBATCH --time=0-08:00:00
#SBATCH --output=logs/BamCov%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="bamCov"
#SBATCH --partition=prod_med

module load deeptools/3.5.0

gsize=/data/reference/dawson_labs/genome_size/Hg38_chrom.size

bname=`basename $1 _merged_by_group_rmdup_sort_nMTnU_MAPQ.bam`

bamCoverage --bam $1 -o BW/${bname}.bw --binSize 20

bamCoverage --bam $1 -o RPGCnorm_BW/${bname}.bw --binSize 20 --normalizeUsing RPGC --effectiveGenomeSize 2736124973
