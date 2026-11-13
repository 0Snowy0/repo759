#include <cuda_runtime.h>
#include <cstdlib>
#include <iostream>
#include <limits>
#include <random>
#include <vector>

#include "vscale.cuh"

void checkCuda(cudaError_t error, const char *operation) {
  if (error != cudaSuccess) {
    std::cerr << operation << ": " << cudaGetErrorString(error)
              << std::endl;
    std::exit(EXIT_FAILURE);
  }
}

int main(int argc, char *argv[]) {
  if (argc < 2 || argc > 3) {
    std::cerr << "Usage: " << argv[0] << " n [threads_per_block]"
              << std::endl;
    return 1;
  }

  char *end = nullptr;
  unsigned long parsedN = std::strtoul(argv[1], &end, 10);

  if (end == argv[1] || *end != '\0' || parsedN == 0 ||
      parsedN > std::numeric_limits<unsigned int>::max()) {
    std::cerr << "n must be a positive integer." << std::endl;
    return 1;
  }

  unsigned int n = static_cast<unsigned int>(parsedN);
  unsigned int threadsPerBlock = 512;

  if (argc == 3) {
    end = nullptr;
    unsigned long parsedThreads = std::strtoul(argv[2], &end, 10);

    if (end == argv[2] || *end != '\0' ||
        (parsedThreads != 16 && parsedThreads != 512)) {
      std::cerr << "threads_per_block must be 16 or 512." << std::endl;
      return 1;
    }

    threadsPerBlock = static_cast<unsigned int>(parsedThreads);
  }

  std::vector<float> a(n);
  std::vector<float> b(n);

  std::random_device entropySource;
  std::mt19937 generator(entropySource());
  std::uniform_real_distribution<float> distA(-10.0f, 10.0f);
  std::uniform_real_distribution<float> distB(0.0f, 1.0f);

  for (unsigned int i = 0; i < n; ++i) {
    a[i] = distA(generator);
    b[i] = distB(generator);
  }

  float *dA = nullptr;
  float *dB = nullptr;

  checkCuda(cudaMalloc(&dA, n * sizeof(float)), "cudaMalloc dA");
  checkCuda(cudaMalloc(&dB, n * sizeof(float)), "cudaMalloc dB");

  checkCuda(cudaMemcpy(dA, a.data(), n * sizeof(float), cudaMemcpyHostToDevice), "copy a to device");
  checkCuda(cudaMemcpy(dB, b.data(), n * sizeof(float), cudaMemcpyHostToDevice), "copy b to device");

  unsigned int blocks = (n + threadsPerBlock - 1) / threadsPerBlock;

  cudaEvent_t start, stop;
  checkCuda(cudaEventCreate(&start), "create start event");
  checkCuda(cudaEventCreate(&stop), "create stop event");

  checkCuda(cudaEventRecord(start), "record start event");
  vscale<<<blocks, threadsPerBlock>>>(dA, dB, n);
  checkCuda(cudaGetLastError(), "vscale launch");
  checkCuda(cudaEventRecord(stop), "record stop event");
  checkCuda(cudaEventSynchronize(stop), "synchronize stop event");

  float ms = 0.0f;
  checkCuda(cudaEventElapsedTime(&ms, start, stop), "elapsed time");

  checkCuda(cudaMemcpy(b.data(), dB, n * sizeof(float), cudaMemcpyDeviceToHost), "copy b to host");

  std::cout << ms << std::endl;
  std::cout << b[0] << std::endl;
  std::cout << b[n - 1] << std::endl;

  cudaEventDestroy(start);
  cudaEventDestroy(stop);
  cudaFree(dA);
  cudaFree(dB);
  return 0;
}
