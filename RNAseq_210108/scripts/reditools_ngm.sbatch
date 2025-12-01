#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G
#SBATCH --time=0-12:00:00
#SBATCH --output=../logs/REDItools%j.stdout
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="REDItools"
#SBATCH --partition=prod_med

module load singularity/3.7.3
module load samtools/1.4.1

# run from dir: /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/Hyperediting/Hyper_editing/REDItools/bams
bname=`basename $1 _ngm_filtered.bam`

mkdir ../results/ngm_paired/${bname}

singularity exec --bind /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/:/dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/ \
/config/binaries/singularity/containers_devel/rna_editing_protocol_latest.sif python /REDItools/main/REDItoolDnaRna.py \
-i $1 -t 8 -W AG,TC -n 0.0 -c 5,5 -f /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/STAR/index/GRCh38.p13.genome.fa \
-o ../results/ngm_paired/${bname}
