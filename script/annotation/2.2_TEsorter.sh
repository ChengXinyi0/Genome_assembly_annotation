#!/usr/bin/env bash

#SBATCH --time=12:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=50
#SBATCH --job-name=edta
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/TEsorter_%j.o
#SBATCH --error=/data/users/xcheng/TEsorter_%j.e
#SBATCH --partition=pall

COURSEDIR=/data/courses/assembly-annotation-course
WORKDIR=/data/users/xcheng/assembly_annotation_course
outputdir=/data/users/xcheng/assembly_annotation_course/EDTA/Brassicaceae
# For Fish's assembly
#copia=/data/users/xcheng/assembly_annotation_course/EDTA/output_copia.fasta
#gypsy=/data/users/xcheng/assembly_annotation_course/EDTA/output_gypsy.fasta
# Brassicaceae
copia=/data/users/xcheng/assembly_annotation_course/EDTA/Brassicaceae/Brassicaceae_copia.fasta
gypsy=/data/users/xcheng/assembly_annotation_course/EDTA/Brassicaceae/Brassicaceae_gypsy.fasta
cd $outputdir

singularity exec \
--bind $COURSEDIR \
--bind $WORKDIR \
$COURSEDIR/containers2/TEsorter_1.3.0.sif \
TEsorter $copia -db rexdb-plant


singularity exec \
--bind $COURSEDIR \
--bind $WORKDIR \
$COURSEDIR/containers2/TEsorter_1.3.0.sif \
TEsorter $gypsy -db rexdb-plant
