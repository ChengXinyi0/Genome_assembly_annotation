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

