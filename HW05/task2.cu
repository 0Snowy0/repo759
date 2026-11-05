#include <random>
#include <cuda.h>
#include <iostream>

__global__ task2Kernal(int *dA, int a) {
  int i = threadIdx.x + blockIdx.x * blockDim.x;
  dA[i] = a * threadIdx.x + blockIdx.x;
}

int main() {
  int hA[16];
  int *dA;

  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_int_distribution<int> dist(1,100);
  int a = dist(gen);

  cudaMalloc(&dA, 16 * sizeof(int));

  task2Kernal<<<2, 8>>>(dA, a);
  cudaDeviceSynchronize();

  cudaMemcpy(hA, dA, 16 * sizeof(int), cudaMemcpyHostToDevice);

  for (int i = 0; i < 16; i++) {
    if (i > 0) {
      std::cout << " ";
    }
    std::cout << hA[i];
  }

  std::cout << std::endl;

  cudaFree(dA);
  return 0;
}