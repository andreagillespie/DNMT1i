#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=prod_short
#SBATCH --mem-per-cpu=12G
#SBATCH --time=0-2:00:00
#SBATCH --output=../logs/merge_bams%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="merge_bams"

module load samtools/1.4.1

samtools merge ${4}_ngm_filtered.bam $1 $2 $3


