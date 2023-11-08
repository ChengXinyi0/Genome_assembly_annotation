#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=maker_rename
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_maker_rename_%j.o
#SBATCH --error=/data/users/xcheng/error_maker_rename_%j.e
#worked!
module load SequenceAnalysis/GenePrediction/maker/2.31.9
base=run_mpi_master
cd /data/users/xcheng/assembly_annotation_course/maker_others
protein=${base}.all.maker.proteins.fasta
transcript=${base}.all.maker.transcripts.fasta
gff=${base}.maker.noseq.gff
prefix=${base}_
#cp $gff ${gff}.renamed.gff
#cp $protein ${protein}.renamed.fasta
#cp $transcript ${transcript}.renamed.fasta
maker_map_ids --prefix $prefix --justify 7 ${gff}.renamed.gff > ${base}.id.map
map_gff_ids ${base}.id.map ${gff}.renamed.gff
map_fasta_ids ${base}.id.map ${protein}.renamed.fasta
map_fasta_ids ${base}.id.map ${transcript}.renamed.fasta