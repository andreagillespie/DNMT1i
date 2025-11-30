#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=prod_med
#SBATCH --mem-per-cpu=20G
#SBATCH --time=0-08:00:00
#SBATCH --output=logs/fastq-dump%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END
#SBATCH --job-name="fastq-dump"

module load sratoolkit/3.0.0

fastq-dump --split-3 SRR11124019

gzip SRR11124018_1.fastq
gzip SRR11124018_2.fastq
