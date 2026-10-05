#!/usr/bin/env bash
#SBATCH --partition=instruction
#SBATCH --job-name=test1
#SBATCH --output=test1.out
#SBATCH --error=test1.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=0-00:05:00

cd "$SLURM_SUBMIT_DIR" || exit

./task1 1000000