#!/bin/bash

# first job called from the day directory
# creates RPLParallel, Unity, and EDFSplit objects, and
# calls aligning_objects and raycast
sbatch /data/src/PyHipp/rplparallel-slurm.sh

# submit rse-slurm.sh first (sessioneye - smaller files, processed first)
rse_jobid=$(sbatch --parsable /data/src/PyHipp/rse-slurm.sh)

# submit the four rs?a jobs, each waiting for rse-slurm.sh to finish successfully
rs1_jobid=$(sbatch --parsable --dependency=afterok:$rse_jobid /data/src/PyHipp/rs1a-slurm.sh)
rs2_jobid=$(sbatch --parsable --dependency=afterok:$rse_jobid /data/src/PyHipp/rs2a-slurm.sh)
rs3_jobid=$(sbatch --parsable --dependency=afterok:$rse_jobid /data/src/PyHipp/rs3a-slurm.sh)
rs4_jobid=$(sbatch --parsable --dependency=afterok:$rse_jobid /data/src/PyHipp/rs4a-slurm.sh)

# consolidate once all four rs?a jobs finish
sbatch --dependency=afterok:$rs1_jobid:$rs2_jobid:$rs3_jobid:$rs4_jobid /data/src/PyHipp/consol_jobs.sh
