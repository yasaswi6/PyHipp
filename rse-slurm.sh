#!/bin/bash
<<<<<<< HEAD
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
=======

# Submit this script with: sbatch <this-filename>

#SBATCH --time=24:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=1	# number of processors per task
#SBATCH -J "rse"   # job name

## /SBATCH -p general # partition (queue)
#SBATCH -o rse-slurm.%N.%j.out # STDOUT
#SBATCH -e rse-slurm.%N.%j.err # STDERR

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
python -u -c "import PyHipp as pyh; \
import os; \
import time; \
t0 = time.time(); \
print(time.localtime()); \
os.chdir('sessioneye'); \
pyh.RPLSplit(SkipLFP=False, SkipHighPass=False); \
print(time.localtime()); \
print(time.time()-t0);"

aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:012345678901:awsnotify --message "RSEJobDone"
>>>>>>> upstream/main
