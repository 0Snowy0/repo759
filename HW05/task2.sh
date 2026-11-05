#!/usr/bin/env bash
#SBATCH --partition=instruction
#SBATCH --job-name=task2
#SBATCH --output=task2-%j.out
#SBATCH --error=task2-%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=0-00:05:00

module load nvidia/cuda
nvcc task2.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std=c++17 -o task2
./task2