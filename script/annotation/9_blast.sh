#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=blast
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_blast_%j.o
#SBATCH --error=/data/users/xcheng/error_blast_%j.e

# worked!

#module load Blast/ncbi-blast/2.10.1+
uniport_fasta=/data/users/xcheng/maker/uniprot-plant_reviewed.fasta
file=/data/users/xcheng/assembly_annotation_course/maker_others/run_mpi_master.all.maker.proteins.fasta.renamed.fasta
cd /data/users/xcheng/assembly_annotation_course/annotation/result/maker_others

#makeblastdb -in $uniport_fasta -dbtype prot -out blast

#blastp -query ${file} -db blast -num_threads 10 -outfmt 6 -evalue 1e-10 -out blastp_output

## did not do
# Add uniprot functional annotation in fasta header
maker_functional_fasta ${uniprot_ref} ${blast_output} ${maker_protein_file} > ${maker_protein_file}.uniprot
maker_functional_gff ${uniprot_ref} ${blast_output} ${maker_noseq_gff} > ${maker_noseq_gff}.uniprot
