#!/usr/bin/env bash

#SBATCH --time=10:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=polishing_align
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_polishing_align_%j.o
#SBATCH --error=/data/users/xcheng/error_polishing_align_%j.e
#SBATCH --partition=pall

# load the module
module add UHTS/Aligner/bowtie2/2.3.4.1


input=/data/users/xcheng/assembly_annotation_course/assemblies/flye/assembly.fasta
input2=/data/users/xcheng/assembly_annotation_course/assemblies/canu2/canu_pacbio.contigs.fasta
output=/data/users/xcheng/assembly_annotation_course/assemblies/flye_illumina

# use the bowtie2-build to create an index of assemblies
# it is a large index, use --large-index
#bowtie2-build --large-index -p $input index_flye
bowtie2-build --large-index -p $input2 index_canu
