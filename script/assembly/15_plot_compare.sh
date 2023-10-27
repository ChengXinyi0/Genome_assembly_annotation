#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=comparing_plot
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/output_comparing_plot%j.o
#SBATCH --error=/data/users/xcheng/error_comparing_plot%j.e
#SBATCH --partition=pall

#mummerplot:
#-R|Rfile        Plot an ordered set of reference sequences from Rfile
#-Q|Qfile        Plot an ordered set of query sequences from Qfile
#--layout        Layout a .delta multiplot in an intelligible fashion,this option requires the -R -Q options
#--fat           Layout sequences using fattest alignment only
#--filter        Only display .delta alignments which represent the "best"
#-s|size         Set the output size to small, medium or large --large
#-t|terminal     Set the output terminal to x11, postscript or png --png

#load module
module add UHTS/Analysis/mummer/4.0.0beta1
#mkdir /data/users/xcheng/assembly_annotation_course/quality_control/comparision
cd /data/users/xcheng/assembly_annotation_course/quality_control/comparision

flye=/data/users/xcheng/assembly_annotation_course/quality_control/comparision/flye_with_polish.delta
canu=/data/users/xcheng/assembly_annotation_course/quality_control/comparision/canu_with_polish.delta
flye_canu=/data/users/xcheng/assembly_annotation_course/quality_control/comparision/flye_and_canu.delta
reference=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
flye_polish=/data/users/xcheng/assembly_annotation_course/quality_control/polishing/polished_flye.fasta
canu_polish=/data/users/xcheng/assembly_annotation_course/quality_control/polishing/polished_canu.fasta

export PATH=/software/bin:$PATH

mummerplot -R $flye_polish -Q $canu_polish --layout --fat --filter --png --large $flye_canu
