#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=5
#SBATCH -J "rs2a"
#SBATCH -o rs2a-slurm.%N.%j.out
#SBATCH -e rs2a-slurm.%N.%j.err
export PATH=/data/miniconda3/envs/env1/bin:$PATH
/data/miniconda3/envs/env1/bin/python -u -c "import PyHipp as pyh; \
import DataProcessingTools as DPT; \
import time; \
t0 = time.time(); \
print(time.localtime()); \
DPT.objects.processDirs(dirs=None, objtype=pyh.RPLSplit, channel=[*range(1,33)], SkipHPC=False, SkipLFP=False, SkipHighPass=False, SkipSort=False, HPCScriptsDir='/data/src/PyHipp/'); \
print(time.localtime()); \
print(time.time()-t0);"
aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:513051133346:awsnotify --message "rs2aJobDone"
