#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=prod_short
#SBATCH --mem=16G
#SBATCH --time=0-02:00:00
#SBATCH --output=logs/namesort%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="namesort"

module load samtools/1.4.1

sname=`basename $1 _sort_ngmRG_filtered.bam`

samtools sort -n -o bams/${sname}_namesort_ngmRG_filtered.bam $1

