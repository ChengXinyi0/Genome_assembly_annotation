#!/usr/bin/env bash

#SBATCH --time=10-04:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=32
#SBATCH --job-name=merqury
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/assembly_annotation_course/assembly/logs/output_merqury_%j.o
#SBATCH --error=/data/users/xcheng/assembly_annotation_course/assembly/logs/error_merqury_%j.e
#SBATCH --partition=pall


illumina_1=/data/courses/assembly-annotation-course/raw_data/Cvi-0/participant_3/Illumina/ERR3624578_1.fastq.gz
illumina_2=/data/courses/assembly-annotation-course/raw_data/Cvi-0/participant_3/Illumina/ERR3624578_2.fastq.gz
output=/data/users/xcheng/assembly_annotation_course/assembly/result/4_evaluation/mercury

### create the merlys ###
PROJDIR=/data   
singularity exec \
--bind $PROJDIR /software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
meryl k=19 count $illumina_1 output ${output}/ERR3624578_1.meryl     

singularity exec \
--bind $PROJDIR /software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
meryl k=19 count $illumina_2 output ${output}/ERR3624578_2.meryl     

# merge together
singularity exec \
--bind $PROJDIR /software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
meryl union-sum output ${output}/ERR3624578.meryl ${output}/*.meryl 

  
cd /data/users/xcheng/assembly_annotation_course/assembly/result/4_evaluation/mercury
# flye
mkdir mercury_flye
cd mercury_flye
flye=/data/users/xcheng/assembly_annotation_course/assembly/result/2_assemblies/flye/flye_assembly.fasta

singularity exec \
--bind $PROJDIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh ${output}/ERR3624578.meryl $flye mercury_flye

cd ..
# canu
mkdir mercury_canu
cd mercury_canu
canu=/data/users/xcheng/assembly_annotation_course/assembly/result/2_assemblies/canu/canu_pacbio.contigs.fasta

singularity exec \
--bind $PROJDIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh ${output}/ERR3624578.meryl $canu mercury_canu

cd ..
#polished flye
mkdir mercury_flye_polished
cd mercury_flye_polished
flye_polish=/data/users/xcheng/assembly_annotation_course/assembly/result/3_polishing/flye/polished_flye.fasta

singularity exec \
--bind $PROJDIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh ${output}/ERR3624578.meryl $flye_polish mercury_flye_polished

cd ..
#polished canu
mkdir mercury_canu_polished
cd mercury_canu_polished
canu_polish=/data/users/xcheng/assembly_annotation_course/assembly/result/3_polishing/canu/polished_canu.fasta

singularity exec \
--bind $PROJDIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh ${output}/ERR3624578.meryl $canu_polish mercury_canu_polished

cd ..
#trinity
mkdir mercury_trinity
cd mercury_trinity
trinity=/data/users/xcheng/assembly_annotation_course/assembly/result/2_assemblies/trinity/Trinity.fasta

singularity exec \
--bind $PROJDIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh ${output}/ERR3624578.meryl $trinity mercury_trinity