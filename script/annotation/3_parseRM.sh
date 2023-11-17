#!/usr/bin/env bash

#SBATCH --time=2-12:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=50
#SBATCH --job-name=parseRM
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/assembly_annotation_course/annotation/logs/parseRM_%j.o
#SBATCH --error=/data/users/xcheng/assembly_annotation_course/annotation/logs/parseRM_%j.e

# finished

OUTPUTDIR=/data/users/xcheng/assembly_annotation_course/annotation/result/parse

cd $OUTPUTDIR
genome=polished_flye.fasta

perl parseRM.pl -i $genome.mod.out -l 50,1 -v

sed -i '1d;3d' $genome.mod.out.landscape.Div.Rname.tab

