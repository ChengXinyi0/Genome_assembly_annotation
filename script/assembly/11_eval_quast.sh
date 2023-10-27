#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=eval_quast
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_eval_quast_%j.o
#SBATCH --error=/data/users/xcheng/error_eval_quast_%j.e
#SBATCH --partition=pall

# import module
module add UHTS/Quality_control/quast/4.6.0

flye=/data/users/xcheng/assembly_annotation_course/assemblies/flye/assembly.fasta
canu=/data/users/xcheng/assembly_annotation_course/assemblies/canu/canu_pacbio.contigs.fasta
trinity=/data/users/xcheng/assembly_annotation_course/assemblies/trinity_out_dir/Trinity.fasta
flye_polish=/data/users/xcheng/assembly_annotation_course/quality_control/polishing/polished_flye.fasta
canu_polish=/data/users/xcheng/assembly_annotation_course/quality_control/polishing/polished_canu.fasta

output=/data/users/xcheng/assembly_annotation_course/quality_control/quast
reference=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa


# without reference
#python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py -o $output/flye -t 12 $flye
#python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py -o $output/canu -t 12 $canu
#python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py -o $output/flye_polish -t 12 $flye_polish
#python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py -o $output/canu_polish -t 12 $canu_polish
#python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py -o $output/trinity -t 12 $trinity

python /software/UHTS/Quality_control/quast/4.6.0/quast.py -o $output/no_ref \
-l flye_no_ref,flye_polished_no_ref,canu_no_ref,canu_polished_no_ref $flye $flye_polish $canu $canu_polish \
--eukaryote --min-contig 3000 --min-alignment 500 --extensive-mis-size 7000 --threads 4 --est-ref-size 133725193




# with reference
#python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py -o $output/flye_re -R $reference -t 12 $flye
#python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py -o $output/canu_re -R $reference -t 12 $canu
#python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py -o $output/flye_polish_re -R $reference -t 12 $flye_polish
#python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py -o $output/canu_polish_re -R $reference -t 12 $canu_polish
#python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py -o $output/trinity_re -R $reference -t 12 $trinity



python /software/UHTS/Quality_control/quast/4.6.0/quast.py -R $reference \
-o $output/ref -l flye,flye_polished,canu,canu_polished $flye $flye_polish $canu $canu_polish \
--eukaryote --min-contig 3000 --min-alignment 500 --extensive-mis-size 7000 --threads 4
#--features ${REF_GEN}/TAIR10_GFF3_genes.gff
#--est-ref-size <int>              Estimated reference size (for computing NGx metrics without a reference)
#-t  --threads     <int>       Maximum number of threads [default: 25% of CPUs]
#-l  --labels "label, label, ..."      Names of assemblies to use in reports, comma-separated. If contain spaces, use quotes
#-R                <filename>  Reference genome file