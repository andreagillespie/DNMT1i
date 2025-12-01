#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/filterBAM%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="filterBAM"
#SBATCH --partition=rhel_short

module load samtools/1.19.2-gcc-13.2.0

samtools view -@ 3 -q 10 -F 0x900 -o $2.chr15mint.Q10.merged.bam $1 chr15:70177189-70586832

samtools index -@ 3 $2.chr15mint.Q10.merged.bam

samtools view -@ 3 -q 10 -F 0x900 -o $2.chr8mint.Q10.merged.bam $1 chr8:101726702-102200508

samtools index -@ 3 $2.chr8mint.Q10.merged.bam