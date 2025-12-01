#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=prod_med
#SBATCH --mem-per-cpu=12G
#SBATCH --time=1-00:00:00
#SBATCH --output=../logs/trim_dunk%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="editDUNK"

module load slamdunk/0.2.4
#module load trimmomatic/0.39

# run slamdunk on trimmed R2 and R1 reverse complement using same fasta as in Naiara's analysis fpr REDItools (re-run of slamdunk, trim and RC already done)
sname=`basename $1 _R1_001.fastq`
Ref=/dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/STAR/index/GRCh38.p13.genome.fa
bed=/dawson_genomics/Projects/DNMTi/RNAseq/210108_NB501056_0582_AHMHNFAFX2/Hyperediting/Hyper_editing/SLAM-DUNK/reference_files/Hg38.bed
rl=150

#java -jar /config/binaries/trimmomatic/0.39/trimmomatic-0.39.jar PE -threads 1 -phred33 $1 $2 -baseout ${sname}_trim.fq.gz ILLUMINACLIP:/data/reference/dawson_labs/trimmomatic/TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

slamdunk all -r $Ref -b $bed -o ${sname}_R1_trim -t 4 -mv 0.2 -mbq 30 -rl $rl ${sname}_trim_1P_RC.fq.gz

#slamdunk all -r $Ref -b $bed -o ${sname}_R2_trim -t 4 -mv 0.2 -mbq 30 -rl $rl ${sname}_trim_2P.fq.gz


#ngm -b -r $Ref -p -1 $1 -2 $2 -t 4 --no-progress --slam-seq 2 -l -o ${sname}.bam
