#!/usr/bin/env bash

#SBATCH --time=7-10:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=32
#SBATCH --job-name=busco
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/assembly_annotation_course/assembly/logs/output_busco_%j.o
#SBATCH --error=/data/users/xcheng/assembly_annotation_course/assembly/logs/error_busco_%j.e
#SBATCH --partition=pall

# evaluation: busco


PROJDIR=/data/users/xcheng/assembly_annotation_course
cd /data/users/xcheng/assembly_annotation_course/assembly/result/4_evaluation/busco

flye=/data/users/xcheng/assembly_annotation_course/assembly/result/2_assemblies/flye/flye_assembly.fasta
canu=/data/users/xcheng/assembly_annotation_course/assembly/result/2_assemblies/canu/canu_pacbio.contigs.fasta
trinity=/data/users/xcheng/assembly_annotation_course/assembly/result/2_assemblies/trinity/Trinity.fasta
polished_flye=/data/users/xcheng/assembly_annotation_course/assembly/result/3_polishing/flye/polished_flye.fasta
polished_canu=/data/users/xcheng/assembly_annotation_course/assembly/result/3_polishing/canu/polished_canu.fasta

# polished flye
#singularity exec --bind $PROJDIR /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif busco --cpu 16 -m genome -i $polished_flye -o busco_polished_flye  -l brassicales_odb10
# polished canu
#singularity exec --bind $PROJDIR /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif busco --cpu 16 -m genome -i $polished_canu -o busco_polished_canu  -l brassicales_odb10
# flye
#singularity exec --bind $PROJDIR /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif busco --cpu 16 -m genome -i $flye -o busco_flye  -l brassicales_odb10 
# canu
#singularity exec --bind $PROJDIR /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif busco --cpu 16 -m genome -i $canu -o busco_canu  -l brassicales_odb10 
# trinity
#singularity exec --bind $PROJDIR /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif busco --cpu 16 -m genome -i $trinity -o busco_trinity  -l brassicales_odb10 

# plot busco result
#mkdir plot
#mkdir plot/summary
#cp busco_canu/short_summary* plot/summary
#cp busco_flye/short_summary* plot/summary
#cp busco_polished_canu/short_summary* plot/summary
#cp busco_polished_flye/short_summary* plot/summary
#cp busco_trinity/short_summary* plot/summary

WORKDIR=/data/users/xcheng/assembly_annotation_course/assembly/result/4_evaluation/busco/plot

module load UHTS/Analysis/busco/4.1.4
cp -r /software/SequenceAnalysis/GenePrediction/augustus/3.3.3.1/config augustus_config
export AUGUSTUS_CONFIG_PATH=./augustus_config
# Generate plots and R script from BUSCO results

python3 /data/users/xcheng/assembly_annotation_course/assembly/result/4_evaluation/busco/plot/generate_plot.py -wd ${WORKDIR}