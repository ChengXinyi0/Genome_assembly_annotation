#!/usr/bin/env bash

#SBATCH --time=10:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=pilon
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_pilon_%j.o
#SBATCH --error=/data/users/xcheng/error_pilon_%j.e
#SBATCH --partition=pall

# import module
module load UHTS/Analysis/pilon/1.22
module add Development/java/1.8.0_242
module load UHTS/Analysis/samtools/1.10

# increase RAM allocation
#java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar

# aligned illumina reads
input_flye=/data/users/xcheng/assembly_annotation_course/quality_control/sam_and_bam/output_alignment_flye_0510.bam
sorted_flye=/data/users/xcheng/assembly_annotation_course/quality_control/sam_and_bam/output_alignment_flye_0510.sorted.bam
#input_canu=/data/users/xcheng/assembly_annotation_course/quality_control/sam_and_bam/output_alignment_canu_0510_2.bam
#sorted_canu=/data/users/xcheng/assembly_annotation_course/quality_control/sam_and_bam/output_alignment_canu_0510_2.sorted.bam
#assembly need to be polish
flye=/data/users/xcheng/assembly_annotation_course/assemblies/flye/assembly.fasta
#canu=/data/users/xcheng/assembly_annotation_course/assemblies/canu/canu_pacbio.contigs.fasta

output=/data/users/xcheng/assembly_annotation_course/quality_control/polishing
# sort bam
#samtools sort -o $sorted_canu --threads 4 $input_canu
#samtools index $sorted_canu

samtools sort -o $sorted_flye --threads 8 $input_flye
samtools index $sorted_flye
# for flye polishing
#pilon --genome $flye --frags $input_flye --output polished_flye

# for cann/flye polishing
java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar \
 --genome $flye --bam $sorted_flye --output $output/polished_flye --threads 8

