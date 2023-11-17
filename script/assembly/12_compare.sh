#!/usr/bin/env bash

#SBATCH --time=10-04:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=32
#SBATCH --job-name=compare
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/assembly_annotation_course/assembly/logs/output_compare_%j.o
#SBATCH --error=/data/users/xcheng/assembly_annotation_course/assembly/logs/error_compare_%j.e
#SBATCH --partition=pall

reference=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
flye_polish=/data/users/xcheng/assembly_annotation_course/assembly/result/3_polishing/flye/polished_flye.fasta
canu_polish=/data/users/xcheng/assembly_annotation_course/assembly/result/3_polishing/canu/polished_canu.fasta
output=/data/users/xcheng/assembly_annotation_course/assembly/result/5_compare

#load module
module add UHTS/Analysis/mummer/4.0.0beta1

#nucmer:
#-p, --prefix=PREFIX                      Write output to PREFIX.delta (out)
#-b, --breaklen=uint32                    Set the distance an alignment extension will attempt to extend poor scoring regions before giving up (200)
#-c, --mincluster=uint32                  Sets the minimum length of a cluster of matches (65)

#cd $output
    
nucmer --mincluster=1000 --breaklen=1000 --prefix=flye_Cvi0 $reference $flye_polish 
nucmer --mincluster=1000 --breaklen=1000 --prefix=canu_Cvi0 $reference $canu_polish
nucmer --mincluster=1000 --breaklen=1000 --prefix=flye_canu $canu_polish $flye_polish
nucmer --mincluster=1000 --breaklen=1000 --prefix=canu_flye $flye_polish $canu_polish


export PATH=/software/bin:$PATH

cd $output

mkdir flye
cd flye
mummerplot --png --large --layout --filter -R $reference \
-Q $flye_polish ${output}/flye_Cvi0.delta
cd ..

mkdir canu
cd canu
mummerplot --png --large --layout --filter -R $reference \
-Q $canu_polish ${output}/canu_Cvi0.delta
cd ..

# flye vs canu(ref)
mkdir flye_vs_canu
cd flye_vs_canu
mummerplot --png --large --layout --filter -R $canu_polish \
-Q $flye_polish ${output}/flye_canu.delta     
cd ..

# canu vs flye(ref)
mkdir canu_flye
cd canu_flye
mummerplot --png --large --layout --filter -R $flye_polish \
-Q $canu_polish ${output}/canu_flye.delta

#mummerplot:
#-R|Rfile        Plot an ordered set of reference sequences from Rfile
#-Q|Qfile        Plot an ordered set of query sequences from Qfile
#--layout        Layout a .delta multiplot in an intelligible fashion,this option requires the -R -Q options
#--fat           Layout sequences using fattest alignment only
#--filter        Only display .delta alignments which represent the "best"
#-s|size         Set the output size to small, medium or large --large
#-t|terminal     Set the output terminal to x11, postscript or png --png