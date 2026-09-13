#!/bin/bash

<<<<<<< HEAD
# first job called from the day directory
# creates RPLParallel, Unity, and EDFSplit objects, and
# calls aligning_objects and raycast
sbatch /data/src/PyHipp/rplparallel-slurm.sh

# submit rse-slurm.sh first (sessioneye - smaller files, processed first)
rse_jobid=$(sbatch --parsable /data/src/PyHipp/rse-slurm.sh)

# submit the four rs?a jobs, each waiting for rse-slurm.sh to finish successfully
sbatch --dependency=afterok:$rse_jobid /data/src/PyHipp/rs1a-slurm.sh
sbatch --dependency=afterok:$rse_jobid /data/src/PyHipp/rs2a-slurm.sh
sbatch --dependency=afterok:$rse_jobid /data/src/PyHipp/rs3a-slurm.sh
sbatch --dependency=afterok:$rse_jobid /data/src/PyHipp/rs4a-slurm.sh
=======
# first job - no dependencies, called from the day directory
# creates RPLParallel, Unity, and EDFSplit objects, and
# calls aligning_objects and raycast
jid1=$(sbatch /data/src/PyHipp/rplparallel-slurm.sh)

# second job - no dependencies, called from the day directory
jid2=$(sbatch /data/src/PyHipp/rse-slurm.sh)

# third set of jobs - depends on rse-slurm.sh, called from the day directory
jid3=$(sbatch --dependency=afterok:${jid2##* } /data/src/PyHipp/rs1a-slurm.sh)
jid4=$(sbatch --dependency=afterok:${jid2##* } /data/src/PyHipp/rs2a-slurm.sh)
jid5=$(sbatch --dependency=afterok:${jid2##* } /data/src/PyHipp/rs3a-slurm.sh)
jid6=$(sbatch --dependency=afterok:${jid2##* } /data/src/PyHipp/rs4a-slurm.sh)

# put dependency for any job that will spawn more jobs here
sbatch --dependency=afterok:${jid3##* }:${jid4##* }:${jid5##* }:${jid6##* } /data/src/PyHipp/consol_jobs.sh

>>>>>>> upstream/main
