#!/usr/bin/env bash
#SBATCH -p instruction
#SBATCH -J HW06_task2
#SBATCH -t 0-00:30:00
#SBATCH -o task2-%j.out -e task2-%j.err
#SBATCH --gres=gpu:1 -c 1
#SBATCH --mem=12G

module load nvidia/cuda
nvcc task2.cu stencil.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o task2

R=128
for threads in 1024 512; do
  out="task2_${threads}.dat"
  : > $out
  for i in {10..29}; do
    n=$((2**i))
    t=$(./task2 $n $R $threads | tail -n 1)   # 2nd output line = time in ms
    echo "$n $t" >> $out
  done
done