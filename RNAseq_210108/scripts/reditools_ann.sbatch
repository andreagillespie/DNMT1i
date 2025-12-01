#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00
#SBATCH --output=../logs/REDItools%j.stdout
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --job-name="REDItools"
#SBATCH --partition=prod_med

module load singularity/3.7.3
module load samtools/1.4.1

# run from dir: /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/Hyperediting/Hyper_editing/REDItools/results/ngm_paired/outTables
sname=`basename $1 _filter_outTable_bp_res.txt`

singularity exec --bind /dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/:/dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/ \
/config/binaries/singularity/containers_devel/rna_editing_protocol_latest.sif python /REDItools/main/AnnotateTable.py \
-i $1 -a /data/reference/dawson_labs/genomes/GRCh38/GCA_000001405.15_GRCh38_full_analysis_set.refseq_annotation.gtf -u -c1,2,3 -n refseq -o ${sname}_refseq_outTable_bp_res

