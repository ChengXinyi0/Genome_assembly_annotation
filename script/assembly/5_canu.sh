#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=canu
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/assembly_annotation_course/assembly/logs/output_canu_%j.o
#SBATCH --error=/data/users/xcheng/assembly_annotation_course/assembly/logs/error_canu_%j.e
#SBATCH --partition=pall

# assembly
# finished

INPUT=/data/courses/assembly-annotation-course/raw_data/Cvi-0/participant_3/pacbio/*
OUTPUT=/data/users/xcheng/assembly_annotation_course/assembly/result/02_assemblies/canu

module load UHTS/Assembler/canu/2.1.1

canu -p canu_pacbio -pacbio $INPUT -d $OUTPUT genomeSize=127m maxThreads=16 maxMemory=64 gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY --time=2-00:00:00" gridOptions="--mail-user=xinyi.cheng@students.unibe.ch"