#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=prod_med
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/toTDF%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="toTDF"

module load igvtools/2.3.95
module load samtools/1.4.1

bname=`basename $1 _Aligned.out.bam`

#samtools sort -o STAR_bams/${bname}_sort.bam $1

#samtools index STAR_bams/${bname}_sort.bam

igvtools count STAR_bams/${bname}_sort.bam STAR_tdfs/${bname}.tdf hg38

