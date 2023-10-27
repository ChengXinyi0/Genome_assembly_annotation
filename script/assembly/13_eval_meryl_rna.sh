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

# Fish fish scripts~

# genome: output
genome=/data/users/xcheng/assembly_annotation_course/quality_control/meryl/trinity_0910

# RNAseq
#rnaseq1=/data/users/xcheng/assembly_annotation_course/participant_3/RNAseq/ERR754075_1.fastq.gz
#rnaseq2=/data/users/xcheng/assembly_annotation_course/participant_3/RNAseq/ERR754075_2.fastq.gz

# load module
#module load UHTS/Assembler/canu/2.1.1

# build kmer dbs with meryl
#meryl k=19 count compress $rnaseq1 output ${genome}_1.meryl
#meryl k=19 count compress $rnaseq2 output ${genome}_2.meryl

#meryl union-sum output ${genome}_all.meryl ${genome}_*.meryl

PROJDIR=/data/users/xcheng/assembly_annotation_course



apptainer exec \
--bind $PROJDIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh \
${genome}_all.meryl \
$PROJDIR/assemblies/trinity_out_dir/Trinity.fasta \
trinity_test

