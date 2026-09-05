#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH -J "rpllfp"
#SBATCH -o rpllfp-slurm.%N.%j.out
#SBATCH -e rpllfp-slurm.%N.%j.err
export PATH=/data/miniconda3/envs/env1/bin:$PATH
/data/miniconda3/envs/env1/bin/python -u -c "import PyHipp as pyh; \
pyh.RPLLFP(saveLevel=1);"
