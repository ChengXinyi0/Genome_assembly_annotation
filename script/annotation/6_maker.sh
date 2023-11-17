
#!/usr/bin/env bash

# This script performs genome annotation using MAKER (version 3.01.03).
# Usage: sbatch 05_annotate_genome.slurm <output directory>

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem-per-cpu=5G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=maker
#SBATCH --mail-user=
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=
#SBATCH --error=
#SBATCH --partition=pall

export SLURM_EXPORT_ENV=ALL

OUTPUT_DIR=$1
cd ${OUTPUT_DIR}

module load SequenceAnalysis/GenePrediction/maker/2.31.9

mpiexec -n 16 singularity exec \
--bind $SCRATCH:/TMP \
--bind /data/courses/assembly-annotation-course/CDS_annotation:/CDS_annotation \
--bind /data/users/grochat/genome_assembly_course:/mnt/home \
/data/courses/assembly-annotation-course/containers2/MAKER_3.01.03.sif \
maker -mpi --ignore_nfs_tmp -TMP /TMP maker_opts.ctl maker_bopts.ctl maker_exe.ctl maker_evm.ctl
