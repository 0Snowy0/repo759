#include <cstdlib>
#include <iostream>
#include <random>
#include <vector>

#include <cuda_runtime.h>

#include "stencil.cuh"

int main(int argc, char* argv[]) {
  if (argc != 4) {
    std::cerr << "Usage: ./task2 <n> <R> <threads_per_block>\n";
    return 1;
  }

  unsigned int n = std::strtoul(argv[1], nullptr, 10);
  unsigned int R = std::strtoul(argv[2], nullptr, 10);
  unsigned int threads_per_block = std::strtoul(argv[3], nullptr, 10);
  unsigned int mask_len = 2 * R + 1;

  if (threads_per_block < mask_len) {
    std::cerr << "threads_per_block must be >= 2 * R + 1\n";
    return 1;
  }

  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_real_distribution<float> dist(-1.0f, 1.0f);
  std::vector<float> h_image(n), h_mask(mask_len), h_output(n);
  for (unsigned int i = 0; i < n; i++) {
    h_image[i] = dist(gen);
  }
  for (unsigned int i = 0; i < mask_len; i++) {
    h_mask[i] = dist(gen);
  }

  float *d_image, *d_mask, *d_output;
  cudaMalloc(&d_image, n * sizeof(float));
  cudaMalloc(&d_mask, mask_len * sizeof(float));
  cudaMalloc(&d_output, n * sizeof(float));
  cudaMemcpy(d_image, h_image.data(), n * sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(d_mask, h_mask.data(), mask_len * sizeof(float), cudaMemcpyHostToDevice);

  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);

  cudaEventRecord(start);
  stencil(d_image, d_mask, d_output, n, R, threads_per_block);
  cudaEventRecord(stop);
  cudaEventSynchronize(stop);

  float time = 0.0f;
  cudaEventElapsedTime(&time, start, stop);

  cudaMemcpy(h_output.data(), d_output, n * sizeof(float), cudaMemcpyDeviceToHost);

  std::cout << h_output[n - 1] << "\n";
  std::cout << time << "\n";

  cudaEventDestroy(start);
  cudaEventDestroy(stop);
  cudaFree(d_image);
  cudaFree(d_mask);
  cudaFree(d_output);
  return 0;
}