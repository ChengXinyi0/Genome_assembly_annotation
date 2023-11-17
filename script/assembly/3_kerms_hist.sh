#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=10:00:00
#SBATCH --job-name=kmers_hist
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_kmers_hist_%j.o
#SBATCH --error=/data/users/xcheng/error_kmers_hist_%j.e
#SBATCH --partition=pall

# READ QC only illumina has result

# import jellyfish
module load UHTS/Analysis/jellyfish/2.3.0



INPUT=/data/users/xcheng/assembly_annotation_course/read_QC/kmer-counting

for file in $(ls $INPUT); do
    filename=$(echo "$file" | cut -d '.' -f 1)
    echo $INPUT/$file
    echo $INPUT/$filename
    jellyfish histo -t 4 $INPUT/$file -o $INPUT/$filename.histo
done
