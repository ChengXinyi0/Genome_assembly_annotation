#!/usr/bin/env bash

#SBATCH --time=10:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=sam_to_bam
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_sam_to_bam_%j.o
#SBATCH --error=/data/users/xcheng/error_sam_to_bam_%j.e
#SBATCH --partition=pall

# import module
module load UHTS/Analysis/samtools/1.10

#input_flye=/data/users/xcheng/assembly_annotation_course/quality_control/sam_and_bam/output_alignment_flye.sam
#input_canu=/data/users/xcheng/assembly_annotation_course/quality_control/sam_and_bam/output_alignment_canu.sam

#output_flye=/data/users/xcheng/assembly_annotation_course/quality_control/sam_and_bam/output_alignment_flye_0510.bam
#output_canu=/data/users/xcheng/assembly_annotation_course/quality_control/sam_and_bam/output_alignment_canu_0510.bam

# convert the sam file to bam
#samtools view -hbS $input_flye > $output_flye
#samtools view -hbS $input_canu > $output_canu

#canu_sam=/data/users/xcheng/assembly_annotation_course/quality_control/sam_and_bam/output_alignment_canu_0510_2.sam
#canu_bam=/data/users/xcheng/assembly_annotation_course/quality_control/sam_and_bam/output_alignment_canu_0510_2.bam
flye_sam=/data/users/xcheng/assembly_annotation_course/quality_control/sam_and_bam/output_alignment_flye_0510.sam
flye_bam=/data/users/xcheng/assembly_annotation_course/quality_control/sam_and_bam/output_alignment_flye_0510.bam
#samtools view -hbS $canu_sam > $canu_bam

# index bam files
#samtools index /data/users/xcheng/assembly_annotation_course/quality_control/sam_and_bam/output_alignment_flye_0410.bam
#samtools index $canu_bam


#samtools view --threads 4 -bo $canu_bam $canu_sam
samtools view --threads 4 -bo $flye_bam $flye_sam