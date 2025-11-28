#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=24G
#SBATCH --time=1-0:00:00
#SBATCH --output=logs/bamCov%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=end
#SBATCH --job-name="bamCov"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module purge
module load samtools/1.17
module load deeptools/3.5.0

bname=`basename $1 -R1.deduplicated.sorted.bam`
dname=`dirname $1`

samtools merge -o ${dname}/${bname}.merged.bam $1 $2 

samtools sort -o ${dname}/${bname}.merged.sort.bam ${dname}/${bname}.merged.bam

samtools index ${dname}/${bname}.merged.sort.bam

bamCoverage --bam ${dname}/${bname}.merged.sort.bam \
  -o bigwigs/${bname}_RPGCnorm.bw \
  --binSize 500 \
  --normalizeUsing RPGC \
  --effectiveGenomeSize 2736124973

# also get forward strand (Me) only
bamCoverage --bam ${dname}/${bname}.merged.sort.bam \
  -o bigwigs/${bname}_RPGCnorm_Me.bw \
  --binSize 500 \
  --normalizeUsing RPGC \
  --filterRNAstrand reverse \
  --effectiveGenomeSize 2736124973
  
  # remove unsorted bam as they are massive and shouldn't be needed further
  rm ${dname}/${bname}.merged.bam
  