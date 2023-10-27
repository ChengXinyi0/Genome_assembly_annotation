#!/usr/bin/env bash

#SBATCH --job-name=CTL
#SBATCH --mail-user=xinyi.cheng@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/xcheng/CTL_%j.o
#SBATCH --error=/data/users/xcheng/CTL_%j.e
#SBATCH --time=0-20:00:00 
#SBATCH --mem-per-cpu=12G 
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=16 

export SLURM_EXPORT_ENV=ALL 
module load SequenceAnalysis/GenePrediction/maker/2.31.9

mpiexec -n 16 \
singularity exec \
--bind $SCRATCH:/TMP /data/courses/assembly-annotation-course/containers2/MAKER_3.01.03.sif maker \
-mpi --ignore_nfs_tmp -TMP /TMP maker_opts.ctl maker_bopts.ctl maker_exe.ctl