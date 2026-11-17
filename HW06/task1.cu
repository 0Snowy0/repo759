#include <cstdlib>
#include <iostream>
#include <random>
#include <vector>

#include <cuda_runtime.h>

#include "matmul.cuh"

int main(int argc, char* argv[]) {
  if (argc != 3) {
    std::cerr << "Usage: ./task1 <n> <threads_per_block>\n";
    return 1;
  }

  size_t n = std::strtoull(argv[1], nullptr, 10);
  unsigned int threads_per_block = std::strtoul(argv[2], nullptr, 10);
  size_t total = n * n;

  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_real_distribution<float> dist(-1.0f, 1.0f);
  std::vector<float> hA(total), hB(total), hC(total);
  for (size_t i = 0; i < total; i++) {
    hA[i] = dist(gen);
    hB[i] = dist(gen);
  }

  float *dA, *dB, *dC;
  cudaMalloc(&dA, total * sizeof(float));
  cudaMalloc(&dB, total * sizeof(float));
  cudaMalloc(&dC, total * sizeof(float));
  cudaMemcpy(dA, hA.data(), total * sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(dB, hB.data(), total * sizeof(float), cudaMemcpyHostToDevice);

  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);

  cudaEventRecord(start);
  matmul(dA, dB, dC, n, threads_per_block);
  cudaEventRecord(stop);
  cudaEventSynchronize(stop);

  float time = 0.0f;
  cudaEventElapsedTime(&time, start, stop);

  cudaMemcpy(hC.data(), dC, total * sizeof(float), cudaMemcpyDeviceToHost);

  std::cout << hC[total - 1] << "\n";
  std::cout << time << "\n";

  cudaEventDestroy(start);
  cudaEventDestroy(stop);
  cudaFree(dA);
  cudaFree(dB);
  cudaFree(dC);
  return 0;
}