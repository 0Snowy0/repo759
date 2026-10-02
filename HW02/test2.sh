#!/usr/bin/env bash
#SBATCH --partition=instruction
#SBATCH --job-name=test2
#SBATCH --output=test2.out
#SBATCH --error=test2.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=0-00:05:00

cd "$SLURM_SUBMIT_DIR" || exit

./task2 1000 5