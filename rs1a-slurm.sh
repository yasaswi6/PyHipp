#!/bin/bash

# Submit this script with: sbatch <this-filename>

#SBATCH --time=24:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=5   # number of CPUs for this task
#SBATCH -J "rs1a"   # job name

## /SBATCH -p general # partition (queue)
#SBATCH -o rs1a-slurm.%N.%j.out # STDOUT
#SBATCH -e rs1a-slurm.%N.%j.err # STDERR

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
export PATH=/data/miniconda3/envs/env1/bin:$PATH
/data/miniconda3/envs/env1/bin/python -u -c "import PyHipp as pyh; \
import DataProcessingTools as DPT; \
import time; \
t0 = time.time(); \
print(time.localtime()); \
DPT.objects.processDirs(dirs=None, objtype=pyh.RPLSplit, channel=[*range(1,33)], SkipHPC=False, SkipLFP=False, SkipHighPass=False, SkipSort=False, HPCScriptsDir='/data/src/PyHipp/'); \
print(time.localtime()); \
print(time.time()-t0);"

aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:513051133346:awsnotify --message "rs1aJobDone"
