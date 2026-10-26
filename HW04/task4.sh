#!/usr/bin/env bash
#SBATCH --partition=instruction
#SBATCH --job-name=task4
#SBATCH --output=task4.out
#SBATCH --error=task4.err
#SBATCH --cpus-per-task=8
#SBATCH --time=0-00:30:00

g++ task3.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp

N=100
T=100

OUT=task4.csv
echo "schedule,threads,rep,time_ms" > $OUT

for sched in static dynamic guided; do
  export OMP_SCHEDULE=$sched 
  for t in 1 2 3 4 5 6 7 8; do
    for rep in 1 2 3; do
      ms=$(./task3 $N $T $t | awk '/time:/ {sub("ms","",$2); print $2}')
      echo "$sched,$t,$rep,$ms" >> $OUT
    done
  done
done