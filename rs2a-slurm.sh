#!/bin/bash
#SBATCH --time=24:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=5   # number of CPUs for this task
#SBATCH -J "rs2a"   # job name
#SBATCH -o rs2a-slurm.%N.%j.out # STDOUT
#SBATCH -e rs2a-slurm.%N.%j.err # STDERR

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
export PATH=/data/miniconda3/envs/env1/bin:$PATH
/data/miniconda3/envs/env1/bin/python -u -c "import PyHipp as pyh; \
import DataProcessingTools as DPT; \
import time; \
t0 = time.time(); \
print(time.localtime()); \
DPT.objects.processDirs(dirs=None, objtype=pyh.RPLSplit, channel=[*range(33,65)], SkipHPC=False, SkipLFP=False, SkipHighPass=False, SkipSort=False, HPCScriptsDir='/data/src/PyHipp/'); \
print(time.localtime()); \
print(time.time()-t0);"

aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:513051133346:awsnotify --message "rs2aJobDone"
