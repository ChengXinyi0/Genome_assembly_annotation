#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=flye
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_flye_%j.o
#SBATCH --error=/data/users/xcheng/error_flye_%j.e
#SBATCH --partition=pall

module load UHTS/Assembler/flye/2.8.3

INPUT=/data/users/xcheng/assembly_annotation_course/participant_3/pacbio/*
OUTPUT=/data/users/xcheng/assembly_annotation_course/assemblies/flye

flye --pacbio-raw $INPUT -g 127m --out-dir $OUTPUT --threads $SLURM_CPUS_PER_TASK
