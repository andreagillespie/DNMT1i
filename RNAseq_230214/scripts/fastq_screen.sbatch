#!/usr/bin/env bash
#

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/fastqScreen_%j.stdout
#SBATCH --mail-type=END
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="fastqScreen"
#SBATCH --partition=prod_med

module load fastq-screen/0.15.3
module load bowtie2/2.3.4.1

fastq_screen --conf /data/reference/dawson_labs/genomes/FastQ_Screen_Genomes/fastq_screen.conf --outdir fastq_screen $1
