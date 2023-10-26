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



# import jellyfish
module load UHTS/Analysis/jellyfish/2.3.0
# module avail: find the available modules
HOME=/data/users/xcheng/assembly_annotation_course
INPUT=/data/users/xcheng/assembly_annotation_course/participant_3
OUTPUT=/data/users/xcheng/assembly_annotation_course/read_QC/kmer-counting

for folder in $(ls $INPUT); do
    for file in $(ls $INPUT/$folder); do
        filename=$(echo "$file" | cut -d '.' -f 1)
        echo $INPUT/$folder/$file
        echo $OUTPUT/$filename

        jellyfish count \
        -C -m 18 -s 100M -t 4 -o $OUTPUT/$filename.jf \
        <(zcat $INPUT/$folder/$file)
    done
done
