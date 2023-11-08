#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=busco
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_busco_%j.o
#SBATCH --error=/data/users/xcheng/error_busco_%j.e
#worked!
cd /data/users/xcheng/assembly_annotation_course/busco_maker

file=/data/users/xcheng/assembly_annotation_course/maker_others/run_mpi_master.all.maker.proteins.fasta.renamed.fasta
PROJDIR=/data/users/xcheng/assembly_annotation_course      

singularity exec --bind $PROJDIR /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif busco -i ${file} \
-l brassicales_odb10 -m proteins -c 4 -o busco