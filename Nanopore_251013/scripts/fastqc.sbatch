#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --mem 40G 
#SBATCH --cpus-per-task 10
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/uBAMfastqc%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="fastqc_nanopore"
#SBATCH --partition=rhel_short

module purge

module load fastqc/0.12.1-gcc-13.2.0

fastqc -t 10 -o fastqc/ --memory 10000 $1

