#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=prod_short
#SBATCH --mem-per-cpu=12G
#SBATCH --time=0-2:00:00
#SBATCH --output=../logs/pair_fixmate%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="merge_fixmate"

module load ngm/0.5.2
module load samtools/1.4.1

bname=`basename $1 _R1_namesort_flagged.bam`
samtools merge ${bname}_paired.bam $1 $2
samtools sort -n -o ${bname}_paired_namesort.bam ${bname}_paired.bam
samtools fixmate -p ${bname}_paired_namesort.bam ${bname}_paired_namesort_fixmate.bam

