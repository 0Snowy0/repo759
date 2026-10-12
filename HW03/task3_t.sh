#!/usr/bin/env bash
#SBATCH --partition=instruction
#SBATCH --job-name=task3_t
#SBATCH --output=task3_t.out
#SBATCH --error=task3_t.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=0-00:10:00

cd "$SLURM_SUBMIT_DIR" || exit

# best ts comes from task3_ts.sh (best_ts.txt), or pass one yourself: sbatch task3_t.sh 256
TS=${1:-$(cat best_ts.txt)}

g++ task3.cpp msort.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp

# n = 10^6, t = 1 ... 20, ts = best; times_t.txt gets "t time_ms" lines
rm -f times_t.txt
for t in $(seq 1 20); do
  ms=$(./task3 1000000 "$t" "$TS" | tail -n 1)
  echo "$t $ms" >> times_t.txt
done