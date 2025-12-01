#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=0-16:00:00
#SBATCH --output=../logs/REDItools%j.stdout
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="REDItools"
#SBATCH --partition=prod_med

module load singularity/3.7.3
module load samtools/1.4.1

# run from dir: /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/Hyperediting/Hyper_editing/REDItools/bams
bname=`basename $1 _paired_namesort_fixmate.bam`

# coordinate sort paired bam
samtools sort -o ${bname}_paired_coordsort.bam $1 
samtools index ${bname}_paired_coordsort.bam

mkdir ../results/slamdunk_pseudopaired/${bname}

singularity exec --bind /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/:/dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/ \
/config/binaries/singularity/containers_devel/rna_editing_protocol_latest.sif python /REDItools/main/REDItoolDnaRna.py \
-i ${bname}_paired_coordsort.bam -W AG,TC -f /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/STAR/index/GRCh38.p13.genome.fa \
-o ../results/slamdunk_pseudopaired/${bname}
