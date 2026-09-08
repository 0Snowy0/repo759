#!/usr/bin/env bash
#SBATCH --job-name=FirstSlurm
#SBATCH --output=FirstSlurm.out
#SBATCH --error=FirstSlurm.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2

hostname