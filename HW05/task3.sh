#!/usr/bin/env bash
#SBATCH --partition=instruction
#SBATCH --job-name=task3
#SBATCH --output=task3-%j.out
#SBATCH --error=task3-%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=0-00:30:00

set -euo pipefail

module load nvidia/cuda

nvcc task3.cu vscale.cu \
  -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 \
  -std=c++17 -o task3

echo "n,threads_per_block,milliseconds,first_result,last_result" > task3_timings.csv

for exponent in {10..29}; do
  n=$((1 << exponent))

  for threads in 512 16; do
    output=$(./task3 "$n" "$threads")
    mapfile -t result <<< "$output"

    printf '%s,%s,%s,%s,%s\n' \
      "$n" "$threads" "${result[0]}" "${result[1]}" "${result[2]}" \
      >> task3_timings.csv

    echo "Finished n=$n with $threads threads per block"
  done
done