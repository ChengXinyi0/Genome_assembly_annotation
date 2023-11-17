#!/usr/bin/env bash

#SBATCH --time=2-12:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=50
#SBATCH --job-name=TEsorter
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/assembly_annotation_course/annotation/logs/TEsorter_%j.o
#SBATCH --error=/data/users/xcheng/assembly_annotation_course/annotation/logs/TEsorter_%j.e
#SBATCH --partition=pall



##################################
###prepare copia and gypsy file###
##################################

OUTDIR=/data/users/xcheng/assembly_annotation_course/annotation/result/tesorter
# input1: reference
# input2: polished_flye_1.fasta
input1=/data/courses/assembly-annotation-course/CDS_annotation
input2=/data/users/xcheng/assembly_annotation_course/annotation/flye_polished1.fasta
cd $OUTDIR
module load UHTS/Analysis/SeqKit/0.13.2

# generate input file from polished_flye_1.fasta
mkdir Cvi0
cd Cvi0
cat ${input2} | seqkit grep -r -p ^*Copia* > Cvi0_copia.fasta
cat ${input2} | seqkit grep -r -p ^*Gypsy* > Cvi0_gypsy.fasta
cd ..

# Brassicaceae
mkdir brassicaceae
cd brassicaceae
cat ${input1}/Brassicaceae_repbase_all_march2019.fasta | seqkit grep -r -p ^*Copia* > brassicaceae_copia.fasta
cat ${input1}/Brassicaceae_repbase_all_march2019.fasta | seqkit grep -r -p ^*Gypsy* > brassicaceae_gypsy.fasta
cd ..

#################
###run tesoter###
#################

COURSEDIR=/data/courses/assembly-annotation-course
WORKDIR=/data/users/xcheng/assembly_annotation_course

# For Fish's assembly
cvi0_copia=/data/users/xcheng/assembly_annotation_course/annotation/result/tesorter/Cvi0/Cvi0_copia.fasta
cvi0_gypsy=/data/users/xcheng/assembly_annotation_course/annotation/result/tesorter/Cvi0/Cvi0_gypsy.fasta
# Brassicaceae
b_copia=/data/users/xcheng/assembly_annotation_course/annotation/result/tesorter/brassicaceae/brassicaceae_copia.fasta
b_gypsy=/data/users/xcheng/assembly_annotation_course/annotation/result/tesorter/brassicaceae/brassicaceae_gypsy.fasta

cd $OUTDIR

cd Cvi0
singularity exec \
--bind $COURSEDIR \
--bind $WORKDIR \
$COURSEDIR/containers2/TEsorter_1.3.0.sif \
TEsorter $cvi0_copia -db rexdb-plant

singularity exec \
--bind $COURSEDIR \
--bind $WORKDIR \
$COURSEDIR/containers2/TEsorter_1.3.0.sif \
TEsorter $cvi0_gypsy -db rexdb-plant
cd ..

##########
cd brassicaceae

singularity exec \
--bind $COURSEDIR \
--bind $WORKDIR \
$COURSEDIR/containers2/TEsorter_1.3.0.sif \
TEsorter $b_copia -db rexdb-plant


singularity exec \
--bind $COURSEDIR \
--bind $WORKDIR \
$COURSEDIR/containers2/TEsorter_1.3.0.sif \
TEsorter $b_gypsy -db rexdb-plant
