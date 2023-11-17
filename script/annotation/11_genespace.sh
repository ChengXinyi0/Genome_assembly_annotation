#!/usr/bin/env bash

#SBATCH --time=2-10:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=genespace
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/assembly_annotation_course/annotation/logs/genespace_%j.o
#SBATCH --error=/data/users/xcheng/assembly_annotation_course/annotation/logs/genespace_%j.e

genespace_image=scripts/genespace_1.1.4.sif
genespace_script=scripts/genespace.R

apptainer exec ${genespace_image} Rscript ${genespace_script}

