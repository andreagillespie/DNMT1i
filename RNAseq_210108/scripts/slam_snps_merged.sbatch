#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=prod_med
#SBATCH --mem=16G
#SBATCH --time=0-08:00:00
#SBATCH --output=../logs/slam_snps%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="slam_snps"

module load slamdunk/0.2.4

# run ngm paired alignment on trimmed reads, with slamseq settings using same fasta as in Naiara's analysis fpr REDItools 
Ref=/dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/STAR/index/GRCh38.p13.genome.fa

slamdunk snp -o ../snps -r $Ref -t 8 $1

