#!/usr/bin/env bash
#SBATCH --partition=instruction
#SBATCH --job-name=task1-scaling
#SBATCH --output=scaling.out
#SBATCH --error=scaling.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=0-00:30:00
#SBATCH --mem=8G

cd "$SLURM_SUBMIT_DIR" || exit

for p in $(seq 10 30); do
    n=$((2**p))
    echo "n=$n"
    ./task1 "$n"
done