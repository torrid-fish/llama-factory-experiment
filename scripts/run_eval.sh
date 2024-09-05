#!/bin/bash

#SBATCH --job-name=evaluate_medmcqa
#SBATCH --verbose
#SBATCH -D .
#SBATCH --partition=mi2104x
#SBATCH --output=log/O-%x.%j
#SBATCH --error=log/E-%x.%j
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1         # number of MP tasks
#SBATCH --time=12:00:00             # maximum execution time (HH:MM:SS)
#SBATCH --exclude=t008-003

srun --kill-on-bad-exit=1 bash scripts/eval.sh