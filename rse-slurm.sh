#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH -J "rse"
#SBATCH -o rse-slurm.%N.%j.out
#SBATCH -e rse-slurm.%N.%j.err
export PATH=/data/miniconda3/envs/env1/bin:$PATH
/data/miniconda3/envs/env1/bin/python -u -c "import PyHipp as pyh; \
import DataProcessingTools as DPT; \
import time; \
t0 = time.time(); \
print(time.localtime()); \
DPT.objects.processDirs(dirs=['sessioneye'], objtype=pyh.RPLSplit, channel=[*range(1,33)], SkipHPC=False, SkipLFP=False, HPCScriptsDir='/data/src/PyHipp/'); \
print(time.localtime()); \
print(time.time()-t0);"
