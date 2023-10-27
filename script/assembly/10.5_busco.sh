#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=eval_busco
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_eval_busco_%j.o
#SBATCH --error=/data/users/xcheng/error_eval_busco_%j.e
#SBATCH --partition=pall

#Variables for directory pathways
FLYE_DIR=/data/users/jgroff/assembly_annotation_course/assemblies/flye
CANU_DIR=/data/users/jgroff/assembly_annotation_course/assemblies/canu/arabidopsis-pacbio
TRIN_DIR=/data/users/jgroff/assembly_annotation_course/assemblies/Trinity/trinity_out_dir
FLYE_POLISH_DIR=/data/users/jgroff/assembly_annotation_course/polish/flye
CANU_POLISH_DIR=/data/users/jgroff/assembly_annotation_course/polish/canu
OUTPUT_DIR=/data/users/jgroff/assembly_annotation_course/evaluation/BUSCO



# Module to run BUSCO assessment
module add UHTS/Analysis/busco/4.1.4;

cd $OUTPUT_DIR

#Make a copy of the augustus config directory to have written permission
cp -r /software/SequenceAnalysis/GenePrediction/augustus/3.3.3.1/config augustus_config
export AUGUSTUS_CONFIG_PATH=./augustus_config

# Run BUSCO for flye, canu and trinity assemblies (not polished)
busco -i ${FLYE_DIR}/assembly.fasta -o flye_unpolished --lineage brassicales_odb10 -m genome --cpu 16
busco -i ${CANU_DIR}/arabidopsis.contigs.fasta -o canu_unpolished --lineage brassicales_odb10 -m genome --cpu 16
#busco -i ${TRIN_DIR}/Trinity.fasta -o trinity_RNAseq --lineage brassicales_odb10 -m transcriptome --cpu 16

# Run BUSCO for flye and canu (polished)
busco -i ${FLYE_POLISH_DIR}/flye_polished.fasta -o flye_polished --lineage brassicales_odb10 -m genome --cpu 16
busco -i ${CANU_POLISH_DIR}/canu_polished.fasta -o canu_polished --lineage brassicales_odb10 -m genome --cpu 16

# Remove the augustus config
rm -r ./augustus_config



# Get output directory, analysis mode and lineage from script arguments
OUTPUT_DIR=/data/users/xcheng/assembly_annotation_course/quality_control/busco_1010_3
MODE=geno
LINEAGE=brassicales_odb10

# Get assembly file and filename
assembly_file=/data/users/xcheng/assembly_annotation_course/assemblies/flye/assembly.fasta
filename=$(basename ${assembly_file} .fasta)

# Import Busco module and set environment variable for Busco config file (Note: expected to be in same directory that will contain output)
module load UHTS/Analysis/busco/4.1.4
export AUGUSTUS_CONFIG_PATH=${OUTPUT_DIR}/augustus_config

