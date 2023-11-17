#!/usr/bin/env bash

#SBATCH --time=2-10:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=32
#SBATCH --job-name=polishing_align
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/assembly_annotation_course/assembly/logs/output_polishing_align_%j.o
#SBATCH --error=/data/users/xcheng/assembly_annotation_course/assembly/logs/error_polishing_align_%j.e
#SBATCH --partition=pall

# including index, polish and sam > bam, 11925457
# load the module
module add UHTS/Aligner/bowtie2/2.3.4.1
module load UHTS/Analysis/samtools/1.10

input_flye=/data/users/xcheng/assembly_annotation_course/assembly/result/2_assemblies/flye/assembly.fasta
input_canu=/data/users/xcheng/assembly_annotation_course/assembly/result/2_assemblies/canu/canu_pacbio.contigs.fasta

output_flye=/data/users/xcheng/assembly_annotation_course/assembly/result/3_polishing/polished_flye
output_canu=/data/users/xcheng/assembly_annotation_course/assembly/result/3_polishing/polished_canu

reads_1=/data/courses/assembly-annotation-course/raw_data/Cvi-0/participant_3/Illumina/ERR3624578_1.fastq.gz
reads_2=/data/courses/assembly-annotation-course/raw_data/Cvi-0/participant_3/Illumina/ERR3624578_2.fastq.gz

# use the bowtie2-build to create an index of assemblies
# it is a large index, use --large-index ??
#bowtie2-build $input_flye $output_flye
#bowtie2-build $input_canu $output_canu

# polishing, output is sam file
bowtie2 -x $output_flye -1 $reads_1 -2 $reads_2 --sensitive-local -S ${output_flye}/polished_flye.sam
bowtie2 -x $output_canu -1 $reads_1 -2 $reads_2 --sensitive-local -S ${output_canu}/polished_canu.sam

# sorting by samtools
# flye
samtools view -S -b ${output_flye}/polished_flye.sam > ${output_flye}/polished_flye.bam
samtools sort -@ 8 ${output_flye}/polished_flye.bam -o ${output_flye}/polished_flye.sorted.bam
samtools index ${output_flye}/polished_flye.sorted.bam

# canu
samtools view -S -b ${output_canu}/polished_canu.sam > ${output_canu}/polished_canu.bam
samtools sort -@ 8 ${output_canu}/polished_canu.bam -o ${output_canu}/polished_canu.sorted.bam
samtools index ${output_canu}/polished_canu.sorted.bam
