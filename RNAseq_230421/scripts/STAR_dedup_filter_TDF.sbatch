#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=prod_med
#SBATCH --mem-per-cpu=16G
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/postprocess%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="postprocess"

module load igvtools/2.3.95
module load samtools/1.13
module load picard/2.6.0

bname=`basename $1 _Aligned.out.bam`

#samtools sort -o STAR_bams/${bname}_sort.bam $1

#samtools index STAR_bams/${bname}_sort.bam

### dedup killed for not enough mem, up mem allocation and rerun
java -Xmx8g -jar /config/binaries/picard/2.23.8/picard.jar MarkDuplicates I=STAR_bams/${bname}_sort.bam O=STAR_bams/${bname}_dedup.bam M=STAR_bams/${bname}_dedup.txt REMOVE_DUPLICATES=true

samtools sort -o STAR_bams/${bname}_dedup_sort.bam STAR_bams/${bname}_dedup.bam

samtools view -b -q 20 STAR_bams/${bname}_dedup_sort.bam  > STAR_bams/${bname}_dedup_sort_MAPQ.bam

java -Xmx8g -jar /config/binaries/picard/2.23.8/picard.jar CollectInsertSizeMetrics I=STAR_bams/${bname}_dedup_sort_MAPQ.bam O=STAR_bams/${bname}_insert_size_metrics.txt H=STAR_bams/${bname}_insert_size_histogram.pdf M=0.5

samtools index STAR_bams/${bname}_dedup_sort_MAPQ.bam

igvtools count STAR_bams/${bname}_dedup_sort_MAPQ.bam STAR_tdfs/${bname}_dedup_sort_MAPQ.tdf hg38

