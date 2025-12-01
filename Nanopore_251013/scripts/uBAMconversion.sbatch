#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --mem 40G 
#SBATCH --cpus-per-task 5
#SBATCH --time=0-02:00:00
#SBATCH --output=logs/uBAMconvert%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="uBAMconvert"
#SBATCH --partition=rhel_2hr


module purge
module load samtools/1.19.2-gcc-13.2.0

samtools fastq $1 -@ 4 > $2

gzip $2
  
