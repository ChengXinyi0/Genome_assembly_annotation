#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=polishing_align_canu
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_polishing_align_canu_%j.o
#SBATCH --error=/data/users/xcheng/error_polishing_align_canu_%j.e
#SBATCH --partition=pall

# load the module
module add UHTS/Aligner/bowtie2/2.3.4.1

index1=/data/users/xcheng/assembly_annotation_course/assemblies/flye_illumina/index_flye
index2=/data/users/xcheng/assembly_annotation_course/assemblies/canu_illumina/index_canu
input1=/data/users/xcheng/assembly_annotation_course/participant_3/Illumina/ERR3624578_1.fastq.gz
input2=/data/users/xcheng/assembly_annotation_course/participant_3/Illumina/ERR3624578_2.fastq.gz
output=/data/users/xcheng/assembly_annotation_course/quality_control/sam_and_bam

#bowtie2 --local -x $index1 -1 $input1 -2 $input2 -S $output/output_alignment_flye_0510.sam
bowtie2 --local -x $index2 -1 $input1 -2 $input2 -S $output/output_alignment_canu_0510_2.sam