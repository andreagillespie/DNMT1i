#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=24G
#SBATCH --time=1-0:00:00
#SBATCH --output=../logs/bamCov%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=end
#SBATCH --job-name="bamCov"
#SBATCH --partition=prod_med

module load deeptools/3.5.0

bname=`basename $1 _sort_ngmRG_filtered.bam`

bamCoverage --bam $1 -o bams/bigwigs/${bname}.bw --binSize 20 --normalizeUsing RPGC --effectiveGenomeSize 2736124973
