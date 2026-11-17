#!/usr/bin/env bash
#SBATCH -p instruction
#SBATCH -J HW06_task1
#SBATCH -t 0-00:30:00
#SBATCH -o task1-%j.out -e task1-%j.err
#SBATCH --gres=gpu:1 -c 1
#SBATCH --mem=8G

module load nvidia/cuda
nvcc task1.cu matmul.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o task1

for threads in 1024 512; do
  out="task1_${threads}.dat"
  : > $out
  for i in {5..14}; do
    n=$((2**i))
    t=$(./task1 $n $threads | tail -n 1)   # 2nd output line = time in ms
    echo "$n $t" >> $out
  done
done