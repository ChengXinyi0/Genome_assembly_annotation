#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=50
#SBATCH --job-name=phylogenetic
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/assembly_annotation_course/annotation/logs/phylogenetic_%j.o
#SBATCH --error=/data/users/xcheng/assembly_annotation_course/annotation/logs/phylogenetic_%j.e
#SBATCH --partition=pall

genespace=/data/users/grochat/genome_assembly_course/scripts/genespace_1.1.4.sif

# This script aligns RT protein sequences of TE superfamilies with clustal (version 1.2.4) and builds a phylogenetic tree with FastTree (version 2.1.10).
# Usage: sbatch 04_create_phylo_tree.slurm <RT protein sequences (fasta)> <output directory> <superfamily name>


# Get protein sequence fasta file, output directory and superfamily name from script arguments
prot_seq=$1
OUTPUT_DIR=$2
family=$3

# Align sequences with clustal
module add SequenceAnalysis/MultipleSequenceAlignment/clustal-omega/1.2.4

clustalo -i ${prot_seq} -o ${OUTPUT_DIR}/${family}_prot_alignment.fasta

# Build tree with FastTree
module add Phylogeny/FastTree/2.1.10 

FastTree -out ${OUTPUT_DIR}/${family}_alignment.tree ${OUTPUT_DIR}/${family}_prot_alignment.fasta
