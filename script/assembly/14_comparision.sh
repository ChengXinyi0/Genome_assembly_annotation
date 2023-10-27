#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=comparing
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_comparing_%j.o
#SBATCH --error=/data/users/xcheng/error_comparing_%j.e
#SBATCH --partition=pall

reference=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
flye_polish=/data/users/xcheng/assembly_annotation_course/quality_control/polishing/polished_flye.fasta
canu_polish=/data/users/xcheng/assembly_annotation_course/quality_control/polishing/polished_canu.fasta
flye=/data/users/xcheng/assembly_annotation_course/assemblies/flye/assembly.fasta
canu=/data/users/xcheng/assembly_annotation_course/assemblies/canu/canu_pacbio.contigs.fasta
output=/data/users/xcheng/assembly_annotation_course/quality_control/comparision

#load module
module add UHTS/Analysis/mummer/4.0.0beta1

#nucmer:
#-p, --prefix=PREFIX                      Write output to PREFIX.delta (out)
#-b, --breaklen=uint32                    Set the distance an alignment extension will attempt to extend poor scoring regions before giving up (200)
#-c, --mincluster=uint32                  Sets the minimum length of a cluster of matches (65)


cd $output

nucmer --prefix flye_and_canu -b 1000 -c 1000 $flye_polish $canu_polish

