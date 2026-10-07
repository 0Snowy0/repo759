#!/usr/bin/env bash
#SBATCH --partition=instruction
#SBATCH --job-name=task3_ts
#SBATCH --output=task3_ts.out
#SBATCH --error=task3_ts.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=0-00:10:00
 
cd "$SLURM_SUBMIT_DIR" || exit
 
g++ task3.cpp msort.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp
 
# n = 10^6, t = 8, ts = 2^1 ... 2^10; times_ts.txt gets "ts time_ms" lines
rm -f times_ts.txt
for e in $(seq 1 10); do
  ts=$((2**e))
  ms=$(./task3 1000000 8 "$ts" | tail -n 1)
  echo "$ts $ms" >> times_ts.txt
done