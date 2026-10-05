#!/usr/bin/env bash
#SBATCH --partition=instruction
#SBATCH --job-name=test3
#SBATCH --output=test3.out
#SBATCH --error=test3.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=0-00:10:00
#SBATCH --mem=8G

cd "$SLURM_SUBMIT_DIR" || exit

./task3