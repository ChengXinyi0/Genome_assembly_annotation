#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=maker_gff
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_maker_gff_%j.o
#SBATCH --error=/data/users/xcheng/error_maker_gff_%j.e
#worked!
outputdir=/data/users/xcheng/assembly_annotation_course/maker_others/run_mpi_master
module load SequenceAnalysis/GenePrediction/maker/2.31.9;
export TMPDIR=$SCRATCH
base=run_mpi_master_datastore_index.log
cd /data/users/xcheng/run_mpi.maker.output
gff3_merge -d ${base} -o ${outputdir}.maker.gff
gff3_merge -d ${base} -n -o ${outputdir}.maker.noseq.gff
fasta_merge -d ${base} -o ${outputdir}