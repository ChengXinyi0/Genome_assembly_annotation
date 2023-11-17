#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=10:00:00
#SBATCH --job-name=kmers_count
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/kmers_count_%j.o
#SBATCH --error=/data/users/xcheng/kmers_count_%j.e
#SBATCH --partition=pall

# READ QC

# import jellyfish
module load UHTS/Analysis/jellyfish/2.3.0
# module avail: find the available modules

INPUT1=/data/users/xcheng/assembly_annotation_course/participant_3/Illumina
INPUT2=/data/users/xcheng/assembly_annotation_course/participant_3/pacbio
INPUT3=/data/users/xcheng/assembly_annotation_course/participant_3/RNAseq

OUTPUT=/data/users/xcheng/assembly_annotation_course/read_QC/kmer-counting


#illumina
jellyfish count \
-C -m 19 -s 100M -t 4 -o $OUTPUT/ERR3624578_illumina.jf \
<(zcat $INPUT1/ERR3624578_1.fastq.gz) \
<(zcat $INPUT1/ERR3624578_2.fastq.gz)

#pacbio
jellyfish count \
-C -m 19 -s 100M -t 4 -o $OUTPUT/ERR341582_pacbio.jf \
<(zcat $INPUT1/ERR3415821.fastq.gz) \
<(zcat $INPUT1/ERR3415822.fastq.gz)

#RNAseq
jellyfish count \
-C -m 19 -s 100M -t 4 -o $OUTPUT/ERR754075_RNAseq.jf \
<(zcat $INPUT1/ERR754075_1.fastq.gz) \
<(zcat $INPUT1/ERR754075_2.fastq.gz)


