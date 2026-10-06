#include <iostream>
#include <cstdlib>
#include <random>
#include <chrono>
#include "matmul.h"

int main (int argc, char *argv[]) {
  if (argc < 3) {
    std::cerr << "Usage: " << argv[0] << " <number> <thread>" << std::endl;
    return 1;
  }

  std::size_t n = std::strtoull(argv[1], nullptr, 10);
  const int t = std::atoi(argv[2]);

  float* A = new float[n * n];
  float* B = new float[n * n];

  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_real_distribution<float> dis(-1.0f, 1.0f);

  for (unsigned int i = 0; i < n * n; i++) {
    A[i] = dis(gen);
    B[i] = dis(gen);
  }

  float* C = new float[n * n];
  omp_set_num_threads(t);

  const auto start = std::chrono::high_resolution_clock::now();
  mmul(A, B, C, n);
  const auto end = std::chrono::high_resolution_clock::now();
  const std::chrono::duration<double, std::milli> elapsed = end - start;

  std::cout << C[n * n - 1] << std::endl;
  std::cout << C[0] << std::endl;
  std::cout << elapsed.count() << std::endl;
}