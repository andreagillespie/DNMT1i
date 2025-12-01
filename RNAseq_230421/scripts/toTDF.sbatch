#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=prod_short
#SBATCH --mem-per-cpu=16G
#SBATCH --time=0-02:00:00
#SBATCH --output=logs/toTDF%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="toTDF"

module load samtools/1.13
module load igvtools/2.3.95

bname=`basename $1 .bam`

samtools index $1

igvtools count $1 tdfs/${bname}.tdf hg38

