#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/mergeBAM%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="mergeBAM"
#SBATCH --partition=rhel_short

module load samtools/1.19.2-gcc-13.2.0

samtools merge -@ 3 -o $4.merged.bam $1 $2 $3

samtools sort -@ 3 -o $4.merged.sort.bam $4.merged.bam

samtools index -@ 3 $4.merged.sort.bam

rm $4.merged.bam
