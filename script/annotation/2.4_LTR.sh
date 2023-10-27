#!/usr/bin/env bash

#SBATCH --time=12:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=32
#SBATCH --job-name=LTR
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/LTR_%j.o
#SBATCH --error=/data/users/xcheng/LTR_%j.e
#SBATCH --partition=pall


grep Ty3-RT <$.rexdb-plant.dom.faa> > <list> #make a list of RT proteins
to extract
sed -i 's/>//' <list> #remove ">" from the header
sed -i 's/ .\+//' <list> #remove all characters following "empty space"
from the header
seqkit grep -f <list> <$.rexdb-plant.dom.faa> -o <Gypsy_RT.fasta>