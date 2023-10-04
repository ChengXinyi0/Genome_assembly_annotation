#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=canu
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_canu_%j.o
#SBATCH --error=/data/users/xcheng/error_canu_%j.e
#SBATCH --partition=pall

INPUT=/data/users/xcheng/assembly_annotation_course/participant_3/pacbio/*
OUTPUT=/data/users/xcheng/assembly_annotation_course/assemblies/canu2

module load UHTS/Assembler/canu/2.1.1

canu \
 -p canu_pacbio -d $OUTPUT \
 genomeSize=127m \
 maxThreads=16 \
 maxMemory=64 \
 gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY --time=2-00:00:00" \
 -pacbio $INPUT