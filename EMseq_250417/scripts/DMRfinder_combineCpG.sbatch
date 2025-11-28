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

dname=/dawson_genomics/Projects/DNMTi/EMseq/250417/bismark_work/bismark/cytosine_reports

python combine_CpG_sites.py -o ${dname}/combined_CpG_counts \ 
  [<input>]+
