#!/bin/bash
#
#SBATCH --nodes=1
#SBATCH --mem=48G 
#SBATCH --cpus-per-task=20
#SBATCH --time=4-00:00:00
#SBATCH --output=../../../logs/DMRichR%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DMRichR"
#SBATCH --partition=rhel_long

# Run Information #
start=`date +%s`

hostname

THREADS=${SLURM_NTASKS}
MEM=${SLURM_MEM_PER_CPU}

echo "Allocated threads: " $THREADS
echo "Allocated memory: " $MEM

# Load Modules #
module load r/4.4.0-gcc-13.2.0
module load curl/8.7.1-gcc-13.2.0-lumydnj
module load python/3.12.1-gcc-13.2.0
module load hisat2/2.2.1-gcc-13.2.0-coa452k
module load samtools/1.4-gcc-13.2.0

# DM.R 
call="Rscript \
--vanilla \
/home/agillespie/DMRichR/R/DM.R \
--genome hg38 \
--coverage 1 \
--perGroup '0.75' \
--minCpGs 5 \
--maxPerms 4 \
--maxBlockPerms 10 \
--cutoff '0.05' \
--testCovariate Group \
--sexCheck FALSE \
--GOfuncR FALSE \
--EnsDb FALSE \
--cores 20"

echo $call
$call

# Run Information #
end=`date +%s`
runtime=$((end-start))
echo $runtime
