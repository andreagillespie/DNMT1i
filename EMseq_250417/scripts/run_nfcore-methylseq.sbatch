#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --mem=200G 
#SBATCH --cpus-per-task=20
#SBATCH --time=3-00:00:00
#SBATCH --output=logs/nf-core%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="nfcore_methylseq"
#SBATCH --partition=rhel_long

module purge

module load apptainer/1.1.9-gcc-13.2.0
module load nextflow/24.10.2

# running local clone of r 3.0.0 (cannot specify as param for local)
nextflow run /home/agillespie/methylseq \
    -profile apptainer \
    --input /dawson_genomics/Projects/DNMTi/EMseq/250417/scripts/samplesheet.csv \
    --outdir /scratch/teams/dawson_genomics/Projects/DNMTi/EMseq/250417/bismark_work \
    --fasta /data/reference/dawson_labs/joint_genomes/Hg38EMseqSpikein/grch38_core+bs_controls.fa \
    --fasta_index /data/reference/dawson_labs/joint_genomes/Hg38EMseqSpikein/grch38_core+bs_controls.fa.fai \
    --aligner bismark \
    --comprehensive \
    --em_seq \
    --save_align_intermeds \
    --save_trimmed \
    --email andrea.gillespie@petermac.org \
    -resume
