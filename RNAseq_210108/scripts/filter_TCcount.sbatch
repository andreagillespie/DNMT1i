#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=prod_med
#SBATCH --mem-per-cpu=24G
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/filter_TCcount%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="filter_TCcount"

module purge

module load slamdunk/0.2.4

# run ngm paired alignment on trimmed reads, with slamseq settings using same fasta as in Naiara's analysis fpr REDItools 
sname=`basename $1 _ngm.bam`
Ref=/dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/STAR/index/GRCh38.p13.genome.fa

slamdunk filter -b bed_files/intergenic_only.bed -o bams $1

process_id=$!
wait $process_id
echo "Exit status: $?"

slamdunk count -o SLAMcounts -r $Ref -b bed_files/intergenic_only.bed -s snps -l 150 bams/${sname}_ngm_filtered.bam

