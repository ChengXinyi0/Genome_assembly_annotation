#!/usr/bin/env bash

#SBATCH --time=2-12:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=50
#SBATCH --job-name=phylogenetic
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/assembly_annotation_course/annotation/logs/phylogenetic_%j.o
#SBATCH --error=/data/users/xcheng/assembly_annotation_course/annotation/logs/phylogenetic_%j.e

module load UHTS/Analysis/SeqKit/0.13.2
TE=/data/users/xcheng/assembly_annotation_course/annotation/result/tesorter

#copia Brass
cat ${TE}/brassicaceae/brassicaceae_copia.fasta.rexdb-plant.dom.faa | grep Ty1-RT | sed 's/>//'| sed 's/ .\+//'> ${TE}/brassicaceae/Brass_copia_ty1rt.txt
#gypsy Brass
cat ${TE}/brassicaceae/brassicaceae_gypsy.fasta.rexdb-plant.dom.faa | grep Ty3-RT | sed 's/>//'| sed 's/ .\+//'> ${TE}/brassicaceae/Brass_gypsy_ty3rt.txt
#copia flye
cat ${TE}/Cvi0/Cvi0_copia.fasta.rexdb-plant.dom.faa | grep Ty1-RT | sed 's/>//'| sed 's/ .\+//'> ${TE}/Cvi0/flye_copia_ty1rt.txt
#gypsy flye
cat ${TE}/Cvi0/Cvi0_gypsy.fasta.rexdb-plant.dom.faa | grep Ty3-RT | sed 's/>//'| sed 's/ .\+//'> ${TE}/Cvi0/flye_gypsy_ty3rt.txt

##Brass
seqkit grep -f ${TE}/brassicaceae/Brass_copia_ty1rt.txt ${TE}/brassicaceae/brassicaceae_copia.fasta.rexdb-plant.dom.faa -o ${TE}/brassicaceae/brass_copia_RT.fasta
seqkit grep -f ${TE}/brassicaceae/Brass_gypsy_ty3rt.txt ${TE}/brassicaceae/brassicaceae_gypsy.fasta.rexdb-plant.dom.faa -o ${TE}/brassicaceae/brass_gypsy_RT.fasta

##flye arabidopsis
seqkit grep -f ${TE}/Cvi0/flye_copia_ty1rt.txt ${TE}/Cvi0/Cvi0_copia.fasta.rexdb-plant.dom.faa -o ${TE}/Cvi0/ath_copia_RT.fasta
seqkit grep -f ${TE}/Cvi0/flye_gypsy_ty3rt.txt ${TE}/Cvi0/Cvi0_gypsy.fasta.rexdb-plant.dom.faa -o ${TE}/Cvi0/ath_gypsy_RT.fasta

#remove all characters following "|"
sed -i 's/|.\+//' ${TE}/brassicaceae/brass_copia_RT.fasta
sed -i 's/|.\+//' ${TE}/brassicaceae/brass_gypsy_RT.fasta
sed -i 's/|.\+//' ${TE}/Cvi0/ath_copia_RT.fasta
sed -i 's/|.\+//' ${TE}/Cvi0/ath_gypsy_RT.fasta

