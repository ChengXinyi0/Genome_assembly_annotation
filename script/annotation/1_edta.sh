#!/usr/bin/env bash

#SBATCH --time=2-2:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=50
#SBATCH --job-name=edta
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/assembly_annotation_course/annotation/logs/output_edta_%j.o
#SBATCH --error=/data/users/xcheng/assembly_annotation_course/annotation/logs/error_edta_%j.e

# used participant_1 data
# polished canu
cd /data/users/xcheng/assembly_annotation_course/annotation/result/edta/canu
PROJDIR=/data

singularity exec \
--bind $PROJDIR $PROJDIR/courses/assembly-annotation-course/containers2/EDTA_v1.9.6.sif EDTA.pl \
--threads 32 \
--genome $PROJDIR/users/xcheng/assembly_annotation_course/assembly/result/3_polishing/canu/polished_canu.fasta \
--step all \
--species others \
--cds $PROJDIR/courses/assembly-annotation-course/CDS_annotation/EDTA_v1.9.6_new/TAIR10_cds_20110103_representative_gene_model_updated \
--anno 1

# polished flye
cd /data/users/xcheng/assembly_annotation_course/annotation/result/edta/flye

singularity exec \
--bind $PROJDIR $PROJDIR/courses/assembly-annotation-course/containers2/EDTA_v1.9.6.sif EDTA.pl \
--threads 32 \
--genome $PROJDIR/users/xcheng/assembly_annotation_course/assembly/result/3_polishing/flye/polished_flye.fasta \
--step all \
--species others \
--cds $PROJDIR/courses/assembly-annotation-course/CDS_annotation/EDTA_v1.9.6_new/TAIR10_cds_20110103_representative_gene_model_updated \
--anno 1

###################
#####try canu######
###################
COURSEDIR=/data/courses/assembly-annotation-course
workdir=/data/users/xcheng/assembly_annotation_course
outdir=/data/users/xcheng/assembly_annotation_course/annotation/result/edta/canu
ANNODIR=/data/courses/assembly-annotation-course/CDS_annotation/TAIR10_cds_20110103_representative_gene_model_updated
GENOMEDIR=/data/users/xcheng/assembly_annotation_course/assembly/result/3_polishing/canu/polished_canu.fasta

cd ${outdir}

singularity exec \
--bind $COURSEDIR \
--bind $workdir \
$COURSEDIR/containers2/EDTA_v1.9.6.sif \
EDTA.pl \
--genome $GENOMEDIR --species others --step all --cds $ANNODIR --anno 1 --threads 50