#!/usr/bin/env bash

#SBATCH --time=12:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=50
#SBATCH --job-name=edta
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/TEsorter_prepare_%j.o
#SBATCH --error=/data/users/xcheng/TEsorter_prepare_%j.e
#SBATCH --partition=pall

WORKDIR=/data/users/xcheng/assembly_annotation_course/EDTA/Brassicaceae
input=/data/courses/assembly-annotation-course/CDS_annotation
cd $WORKDIR
module load UHTS/Analysis/SeqKit/0.13.2

cat $input/Brassicaceae_repbase_all_march2019.fasta | seqkit grep -r -p ^*Copia* > Brassicaceae_copia.fasta
cat $input/Brassicaceae_repbase_all_march2019.fasta | seqkit grep -r -p ^*Gypsy* > Brassicaceae_gypsy.fasta