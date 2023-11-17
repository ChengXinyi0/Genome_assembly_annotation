#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=10:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_fastqc_%j.o
#SBATCH --error=/data/users/xcheng/error_fastqc_%j.e
#SBATCH --partition=pall
#SBATCH --array=0-6

# READ QC

#import fastqc

module load UHTS/Quality_control/fastqc/0.11.9

HOME=/data/users/xcheng/assembly_annotation_course
RESOURCE=$HOME/participant_3



for folder in $(ls $RESOURCE); do
    for file in $(ls $RESOURCE/$folder); do
        fastqc -o $HOME/read_QC/fastqc $RESOURCE/$folder/$file
    done
done