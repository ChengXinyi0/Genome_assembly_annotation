#!/usr/bin/env bash

#SBATCH --time=2-10:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=32
#SBATCH --job-name=pilon
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/assembly_annotation_course/assembly/logs/output_pilon_%j.o
#SBATCH --error=/data/users/xcheng/assembly_annotation_course/assembly/logs/error_pilon_%j.e
#SBATCH --partition=pall

# get polished fasta file, finished
module add UHTS/Analysis/pilon/1.22

java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar

input_flye=/data/users/xcheng/assembly_annotation_course/assembly/result/2_assemblies/flye/assembly.fasta
input_canu=/data/users/xcheng/assembly_annotation_course/assembly/result/2_assemblies/canu/canu_pacbio.contigs.fasta

output_flye=/data/users/xcheng/assembly_annotation_course/assembly/result/3_polishing/polished_flye
output_canu=/data/users/xcheng/assembly_annotation_course/assembly/result/3_polishing/polished_canu

#flye
pilon --genome $input_flye --bam ${output_flye}/polished_flye.sorted.bam --outdir $output_flye

#canu                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
pilon --genome $input_canu --bam ${output_canu}/polished_canu.sorted.bam --outdir $output_canu

