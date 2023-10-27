#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=merqury_db
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_merqury_db%j.o
#SBATCH --error=/data/users/xcheng/error_merqury_db%j.e
#SBATCH --partition=pall

# Fish fish scripts~

# genome: output
genome=/data/users/xcheng/assembly_annotation_course/quality_control/meryl/illumina_1110_2
# illumina
illumina1=/data/users/xcheng/assembly_annotation_course/participant_3/Illumina/ERR3624578_1.fastq.gz
illumina2=/data/users/xcheng/assembly_annotation_course/participant_3/Illumina/ERR3624578_2.fastq.gz

# load module
module load UHTS/Assembler/canu/2.1.1

cd /data/users/xcheng/assembly_annotation_course/quality_control/meryl

# build kmer dbs with meryl
meryl k=19 count compress $illumina1 output ${genome}_1.meryl
meryl k=19 count compress $illumina2 output ${genome}_2.meryl
meryl union-sum output ${genome}_all.meryl ${genome}_*.meryl

# create meryl db
meryl k=19 count output ${genome}_1.meryl $illumina1
meryl k=19 count output ${genome}_2.meryl $illumina2
meryl union-sum output ${genome}_all_db.meryl ${genome}*.meryl
