#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=prod_med
#SBATCH --mem=12G
#SBATCH --time=0-04:00:00
#SBATCH --output=logs/ngm_align%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="ngm_align"

module load ngm/0.5.2
module load slamdunk/0.2.4
module load samtools/1.4.1
module load trimgalore/0.4.4

# run ngm paired alignment on trimmed reads, with slamseq settings using same fasta as in Naiara's analysis fpr REDItools 
sname=`basename $1 _R1_001.fastq.gz`
Ref=/dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/STAR/index/GRCh38.p13.genome.fa
### rerun with known genes bed file rather than intergenic
#bed=/dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/Hyperediting/Hyper_editing/REDItools/bed_files/intergenic_stranded.bed
bed=/data/reference/dawson_labs/bed_files/Hg38/Hg38EnsGeneStrandPlusMinus.bed

#cd trimmed_fastqs
#srun -n 1 trim_galore $1 --fastqc
#cd ..

#ngm -b -r $Ref -q trimmed_fastqs/${sname}_R1_001_trimmed.fq.gz -t 8 --no-progress --slam-seq 2 --rg-id 0 --rg-sm sample_0:NA:-1 -o bams/${sname}_ngmRG.bam

#samtools sort -o bams/${sname}_sort_ngmRG.bam bams/${sname}_ngmRG.bam

#samtools index bams/${sname}_sort_ngmRG.bam

#slamdunk filter -o bams -t 8 bams/${sname}_sort_ngmRG.bam

#slamdunk snp -o snps -r $Ref -t 8 bams/${sname}_sort_ngmRG_filtered.bam

alleyoop dedup -o bams -t 8 bams/${sname}_sort_ngmRG_filtered.bam

#slamdunk count -o SLAMcounts -s snps -r $Ref -b $bed -l 75 bams/${sname}_sort_ngmRG_filtered.bam

#alleyoop collapse -o SLAMcounts/collapse/ SLAMcounts/${sname}_sort_ngmRG_filtered_tcount.tsv
