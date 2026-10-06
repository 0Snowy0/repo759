#!/usr/bin/env bash
#SBATCH --partition=instruction
#SBATCH --job-name=task1
#SBATCH --output=task1.out
#SBATCH --error=task1.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=0-00:10:00

cd "$SLURM_SUBMIT_DIR" || exit
 
g++ task1.cpp matmul.cpp -Wall -O3 -std=c++17 -o task1 -fopenmp
 
# times.txt gets one "t time_ms" line per thread count
rm -f times.txt
for t in $(seq 1 20); do
  ms=$(./task1 1024 "$t" | tail -n 1)
  echo "$t $ms" >> times.txt
done