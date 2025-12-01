#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=24G
#SBATCH --time=0-04:00:00
#SBATCH --output=logs/deeptoolsCov%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="bedgraphs"
#SBATCH --partition=prod_med

module load samtools/1.4.1
module load deeptools/3.0.0

bname=`basename $1 _sort.bam`

# must be indexed first
#samtools index $1

bamCoverage -b $1 -o STAR_bedgraphs/${bname}.bdg -bs 1 -of bedgraph

gzip STAR_bedgraphs/${bname}.bdg
