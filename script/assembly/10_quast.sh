#!/usr/bin/env bash

#SBATCH --time=10-03:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=quast
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/assembly_annotation_course/assembly/logs/output_quast_%j.o
#SBATCH --error=/data/users/xcheng/assembly_annotation_course/assembly/logs/error_quast_%j.e
#SBATCH --partition=pall

# import module
module add UHTS/Quality_control/quast/4.6.0

flye=/data/users/xcheng/assembly_annotation_course/assembly/result/2_assemblies/flye/flye_assembly.fasta
canu=/data/users/xcheng/assembly_annotation_course/assembly/result/2_assemblies/canu/canu_pacbio.contigs.fasta
trinity=/data/users/xcheng/assembly_annotation_course/assembly/result/2_assemblies/trinity/Trinity.fasta
flye_polish=/data/users/xcheng/assembly_annotation_course/assembly/result/3_polishing/flye/polished_flye.fasta
canu_polish=/data/users/xcheng/assembly_annotation_course/assembly/result/3_polishing/canu/polished_canu.fasta

output=/data/users/xcheng/assembly_annotation_course/assembly/result/4_evaluation/quast
reference=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa


# without reference

python /software/UHTS/Quality_control/quast/4.6.0/quast.py -o $output/no_ref \
-l flye_no_ref,flye_polished_no_ref,canu_no_ref,canu_polished_no_ref $flye $flye_polish $canu $canu_polish \
--eukaryote --min-contig 3000 --min-alignment 500 --extensive-mis-size 7000 --threads 16 --est-ref-size 133725193




# with reference

python /software/UHTS/Quality_control/quast/4.6.0/quast.py -R $reference \
-o $output/ref -l flye,flye_polished,canu,canu_polished $flye $flye_polish $canu $canu_polish \
--eukaryote --min-contig 3000 --min-alignment 500 --extensive-mis-size 7000 --threads 16




#--features ${REF_GEN}/TAIR10_GFF3_genes.gff
#--est-ref-size <int>              Estimated reference size (for computing NGx metrics without a reference)
#-t  --threads     <int>       Maximum number of threads [default: 25% of CPUs]
#-l  --labels "label, label, ..."      Names of assemblies to use in reports, comma-separated. If contain spaces, use quotes
#-R                <filename>  Reference genome file