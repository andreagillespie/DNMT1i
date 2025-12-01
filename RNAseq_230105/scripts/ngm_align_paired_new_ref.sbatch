#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=prod_med
#SBATCH --mem=16G
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/ngm_align%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="ngm_align"

module load ngm/0.5.2
module load slamdunk/0.2.4
module load samtools/1.4.1

# run ngm paired alignment on trimmed reads, with slamseq settings using same fasta as in Naiara's analysis fpr REDItools 
sname=`basename $1 _R1_001.fastq.gz`
Ref=/data/reference/dawson_labs/genomes/GRCh38/GCA_000001405.15_GRCh38_full_analysis_set.fna
#bed=/dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/Hyperediting/Hyper_editing/REDItools/bed_files/intergenic_stranded.bed

ngm -b -r $Ref -q $1 -t 8 --no-progress --slam-seq 2 -l --rg-id 0 --rg-sm sample_0:NA:-1 -o new_ref_bams/${sname}_ngmRG.bam

samtools sort -o new_ref_bams/${sname}_sort_ngmRG.bam new_ref_bams/${sname}_ngmRG.bam

samtools index new_ref_bams/${sname}_sort_ngmRG.bam

slamdunk filter -o new_ref_bams -t 8 new_ref_bams/${sname}_sort_ngmRG.bam

#slamdunk snp -o snps -r $Ref -t 8 new_ref_bams/${sname}_sort_ngmRG_filtered.bam

#slamdunk count -o SLAMcounts -s snps -r $Ref -b $bed -l 75 new_ref_bams/${sname}_sort_ngmRG_filtered.bam

#alleyoop collapse -o SLAMcounts/collapse/ SLAMcounts/${sname}_sort_ngmRG_filtered_tcount.tsv
