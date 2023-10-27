#!/usr/bin/env bash

#SBATCH --time=12:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=32
#SBATCH --job-name=praseRM
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/praseRM_%j.o
#SBATCH --error=/data/users/xcheng/praseRM_%j.e
#SBATCH --partition=pall

OUTPUTDIR=/data/users/xcheng/assembly_annotation_course/EDTA

cd $OUTPUTDIR
genome=flye_polished.fasta

perl parseRM.pl -i $genome.mod.out -l 50,1 -v

sed -i '1d;3d' $genome.mod.out.landscape.Div.Rname.tab


