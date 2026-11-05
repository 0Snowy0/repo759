#include <cuda.h>
#include <iostream>
#include <cstdio>

__global__ void task1Kernal() {
  int a = threadIdx.x;
  int b = 1;

  for (int i = a; i > 1; i++) {
    b *= i;
  }

  printf("%d! = %d\n", a, b);
}

int main () {
  task1Kernal<<<1,8>>>();
  cudaDeviceSynchronize();
  return 0;
}