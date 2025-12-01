#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=24G
#SBATCH --time=1-0:00:00
#SBATCH --output=../../../../logs/bamCov%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=end
#SBATCH --job-name="bamCov"
#SBATCH --partition=prod_med

module load deeptools/3.5.0
module load samtools/1.9

#bname=`basename $1 _val_1_bismark_bt2_pe.bam`

#samtools sort -o ${bname}.sort.bam $1

#samtools index ${bname}.sort.bam

bname=`basename $1 .sort.bam`

bamCoverage --bam ${bname}.sort.bam -o BW/${bname}.bw --binSize 20

bamCoverage --bam ${bname}.sort.bam -o RPGC_norm_BW/${bname}.bw --binSize 20 --normalizeUsing RPGC --effectiveGenomeSize 2736124973
