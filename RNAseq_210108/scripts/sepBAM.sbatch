#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=prod_med
#SBATCH --mem=32G
#SBATCH --time=0-08:00:00
#SBATCH --output=logs/sepBAM%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="sepBAM"

module load slamdunk/0.3.0

# run ngm paired alignment on trimmed reads, with slamseq settings using same fasta as in Naiara's analysis fpr REDItools 
Ref=/dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/STAR/index/GRCh38.p13.genome.fa

alleyoop read-separator -o TCbams -r $Ref -s snps -t 8 $1
