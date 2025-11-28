#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=24G
#SBATCH --time=1-0:00:00
#SBATCH --output=logs/bismarkCytosine%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="bismarkCytosine"
#SBATCH --partition=rhel_short

module purge
module load bismark/0.24.1-gcc-13.2.0

bname=`basename $1 .markdup.sorted_CpG.bedGraph`

coverage2cytosine --gzip \
  --dir bismark_work/bismark/cytosine_reports \
  --merge_CpG \
  --genome_folder /data/reference/dawson_labs/joint_genomes/Hg38EMseqSpikein/ \
  -o ${bname} \
  $1
