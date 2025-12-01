#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=prod_short
#SBATCH --mem-per-cpu=12G
#SBATCH --time=0-2:00:00
#SBATCH --output=../logs/igv_count%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="igv_count"

module load igvtools/2.3.95

bname=`basename $1 .sort.bam`

igvtools count $1 ${bname}.tdf hg38
