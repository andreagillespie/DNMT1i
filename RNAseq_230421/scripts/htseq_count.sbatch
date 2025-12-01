#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --partition=prod_short
#SBATCH --mem=4G
#SBATCH --time=0-02:00:00
#SBATCH --output=logs/htseq%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="htseq"

module load htseq/0.11.2

sname=`basename $1 _sort_ngmRG_filtered_dedup.bam`

srun -n 1 htseq-count -f bam -s no -a 10 $1 /data/reference/dawson_labs/genomes/GRCh38/GCA_000001405.15_GRCh38_full_analysis_set.refseq_annotation.gtf > counts/${sname}.count
