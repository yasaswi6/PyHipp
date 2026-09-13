#!/bin/bash
<<<<<<< HEAD
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH -J "rplhighpass-sort"
#SBATCH -o rplhighpass-sort-slurm.%N.%j.out
#SBATCH -e rplhighpass-sort-slurm.%N.%j.err

# check out a cloned environment from the pool (env1's python has hickle/filelock installed)
cenv=$(/data/miniconda3/envs/env1/bin/python /data/src/PyHipp/envlist.py)

# activate the checked-out environment (sourcing conda.sh directly so this works
# in a non-interactive SLURM job shell, without depending on .bashrc)
source /data/miniconda3/etc/profile.d/conda.sh
conda activate $cenv

# run the highpass + sort + export pipeline using this environment's own
# python and its own isolated mountainlab install
python -u -c "import PyHipp as pyh; \
=======

# Submit this script with: sbatch <this-filename>

#SBATCH --time=24:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=1	# number of processors per task
#SBATCH -J "rplhps"   # job name

## /SBATCH -p general # partition (queue)
#SBATCH -o rplhps-slurm.%N.%j.out # STDOUT
#SBATCH -e rplhps-slurm.%N.%j.err # STDERR

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
/data/miniconda3/bin/conda init
source ~/.bashrc
envarg=`/data/src/PyHipp/envlist.py`
conda activate $envarg

python -u -c "import PyHipp as pyh; \
import time; \
>>>>>>> upstream/main
pyh.RPLHighPass(saveLevel=1); \
from PyHipp import mountain_batch; \
mountain_batch.mountain_batch(); \
from PyHipp import export_mountain_cells; \
<<<<<<< HEAD
export_mountain_cells.export_mountain_cells();"

# deactivate and return the environment to the pool for the next job to use
conda deactivate
/data/miniconda3/envs/env1/bin/python /data/src/PyHipp/envlist.py $cenv
=======
export_mountain_cells.export_mountain_cells(); \
print(time.localtime());"

conda deactivate 
/data/src/PyHipp/envlist.py $envarg
>>>>>>> upstream/main
