#!/usr/bin/env bash

#SBATCH --time=2:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=50
#SBATCH --job-name=edta
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_file/edta_%j.o
#SBATCH --error=/data/users/xcheng/error_file/edta_%j.e
#SBATCH --partition=pall

COURSEDIR=/data/courses/assembly-annotation-course
WORKDIR=/data/users/xcheng/assembly_annotation_course
outputdir=/data/users/xcheng/assembly_annotation_course/EDTA1
genome=/data/users/xcheng/assembly_annotation_course/quality_control/01_polishing/polished_flye.fasta
cds_gene=/data/courses/assembly-annotation-course/CDS_annotation/TAIR10_cds_20110103_representative_gene_model_updated
cd $WORKDIR

singularity exec \
--bind $COURSEDIR \
--bind $WORKDIR \
$COURSEDIR/containers2/EDTA_v1.9.6.sif \
EDTA.pl \
--genome $genome --species others --step all --cds $cds_gene --anno 1 --threads 50