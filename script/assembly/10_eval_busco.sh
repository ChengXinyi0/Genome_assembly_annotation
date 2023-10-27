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

# assemblies, flye, canu: whole genome, trinity: transcriptome ~
flye=/data/users/xcheng/assembly_annotation_course/assemblies/flye/assembly.fasta
canu=/data/users/xcheng/assembly_annotation_course/assemblies/canu/canu_pacbio.contigs.fasta
trinity=/data/users/xcheng/assembly_annotation_course/assemblies/trinity_out_dir/Trinity.fasta
flye_polish=/data/users/xcheng/assembly_annotation_course/quality_control/polishing/polished_flye.fasta
canu_polish=/data/users/xcheng/assembly_annotation_course/quality_control/polishing/polished_canu.fasta
outputidr=/data/users/xcheng/assembly_annotation_course/quality_control/busco

# import BUSCO
module load UHTS/Analysis/busco/4.1.4

cd $outputidr

cp -r /software/SequenceAnalysis/GenePrediction/augustus/3.3.3.1/config augustus_config
export AUGUSTUS_CONFIG_PATH=./augustus_config

busco -i $flye -o flye_busco --lineage brassicales_odb10 -m genome --cpu 16
busco -i $canu -o canu_busco --lineage brassicales_odb10 -m genome --cpu 16
busco -i $trinity -o trinity_busco --lineage brassicales_odb10 -m genome --cpu 16

busco -i $flye_polish -o flye_polish_busco --lineage brassicales_odb10 -m genome --cpu 16
busco -i $canu_polish -o canu_polish_busco --lineage brassicales_odb10 -m genome --cpu 16

# call busco
#busco -i $flye_polish -l brassicales_odb10 -o flye_polished_busco -m geno -f
#busco -i $canu_polish -l brassicales_odb10 -o canu_polished_busco -m geno -f
#busco -i $trinity -l brassicales_odb10 -o trinity_busco -m tran -f
#busco -i $flye -l brassicales_odb10 -o flye_busco -m geno -f
#busco -i $canu -l brassicales_odb10 -o canu_busco -m geno -f
# used lineage: brassicales_odb10