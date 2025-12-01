#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=prod_short
#SBATCH --mem-per-cpu=8G
#SBATCH --time=0-01:00:00
#SBATCH --output=logs/toTDF%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="toTDF"

module load igvtools/2.3.95

bname=`basename $1 _sort_ngmRG_filtered.bam`

igvtools count $1 tdfs/${bname}.tdf hg38

