#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --mem 256G 
#SBATCH --cpus-per-task 32
#SBATCH --time=7-00:00:00
#SBATCH --output=logs/nf-core%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="nfcore_nanoseq"
#SBATCH --partition=rhel_long

module purge

module load apptainer/1.1.9-gcc-13.2.0
module load nextflow/24.10.5

# running local instance of rev 3.1.0 as problem with shared singularity img
nextflow run /home/agillespie/nanoseq \
    -c /dawson_genomics/Projects/DNMTi/Nanopore/250821/scripts/nfcore-nanoseq.config \
    -profile singularity \
    --input /dawson_genomics/Projects/DNMTi/Nanopore/250821/scripts/samplesheet.csv \
    --outdir /dawson_genomics/Projects/DNMTi/Nanopore/250821/nf-core_nanoseq \
    --protocol cDNA \
    --skip_demultiplexing \
    --skip_nanoplot \
    --skip_fastqc \
    --skip_multiqc \
    --quantification_method stringtie2 \
    --skip_differential_analysis \
    --skip_fusion_analysis \
    --skip_modification_analysis \
    --email andrea.gillespie@petermac.org \
    --max_memory 256.GB \
    --max_cpus 32 \
    --max_time 168.h \
    -resume

