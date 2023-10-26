#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=trinity
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_trinity_%j.o
#SBATCH --error=/data/users/xcheng/error_trinity_%j.e
#SBATCH --partition=pall

leftinput=/data/users/xcheng/assembly_annotation_course/participant_3/RNAseq/ERR754075_1.fastq.gz
rightinput=/data/users/xcheng/assembly_annotation_course/participant_3/RNAseq/ERR754075_2.fastq.gz
output=/data/users/xcheng/assembly_annotation_course/assemblies/trinity3

module load UHTS/Assembler/trinityrnaseq/2.5.1

Trinity --seqType fq --left $leftinput --right $rightinput --CPU 12 --max_memory 48G