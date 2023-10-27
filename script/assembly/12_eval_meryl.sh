#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=eval_merqury
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_eval_merqury_%j.o
#SBATCH --error=/data/users/xcheng/error_eval_merqury_%j.e
#SBATCH --partition=pall

# genome: output
genome=/data/users/xcheng/assembly_annotation_course/quality_control/meryl/illumina_1110_test
# illumina
#illumina1=/data/users/xcheng/assembly_annotation_course/participant_3/Illumina/ERR3624578_1.fastq.gz
#illumina2=/data/users/xcheng/assembly_annotation_course/participant_3/Illumina/ERR3624578_2.fastq.gz

#READS_DIR=/data/users/apandey/genome_and_transcriptome_assembly_and_annotation/participant_5/Illumina
WORK_DIR=/data/users/apandey/genome_and_transcriptome_assembly_and_annotation
OUTPUT_DIR=${WORK_DIR}/analysis/w3_merqury
MERYL_DIR=${OUTPUT_DIR}/genome.meryl





# load module
module load UHTS/Assembler/canu/2.1.1

#cd /data/users/xcheng/assembly_annotation_course/quality_control/meryl

# build kmer dbs with meryl
#meryl k=19 count compress ${READS_DIR}/*_1.fastq.gz output ${genome}_1.meryl
#meryl k=19 count compress ${READS_DIR}/*_2.fastq.gz output ${genome}_2.meryl
#meryl union-sum output ${genome}_all.meryl ${genome}_*.meryl

# set path
PROJDIR=/data/users/xcheng/assembly_annotation_course

flye_polishing=/data/users/apandey/genome_and_transcriptome_assembly_and_annotation/analysis/Polished_genome_assembly/mapped_bam_files/flye_polished.fasta
#flye=$PROJDIR/assemblies/flye/assembly.fasta

#canu_polishing=$PROJDIR/quality_control/polishing/polished_canu.fasta
#canu=$PROJDIR/assemblies/canu2/canu_pacbio.contigs.fasta

#cd /data/users/xcheng/assembly_annotation_course/quality_control/meryl

# evaluating for flye and canu
apptainer exec \
--bind $PROJDIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh \
${MERYL_DIR} \
$flye_polishing \
flye_polish_1110_1

