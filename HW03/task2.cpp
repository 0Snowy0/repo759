#include <iostream>
#include <cstdlib>
#include <random>
#include <chrono>
#include "convolution.h"

int main (int argc, char *argv[]) {
  if (argc < 3) {
    std::cerr << "Usage: " << argv[0] << " <number> <thread>" << std::endl;
    return 1;
  }

  std::size_t n = std::strtoull(argv[1], nullptr, 10);
  const int t = std::atoi(argv[2]);

  std::random_device rd;
  std::mt19937 gen(rd());

  float *image = new float[n * n];
  std::uniform_real_distribution<float> dis(-10.0, 10.0);

  for (std::size_t i = 0; i < n; ++i) {
    for (std::size_t j = 0; j < n; ++j) {
      image[i * n + j] = dis(gen);
    }
  }

  float *mask = new float[3 * 3];
  std::uniform_real_distribution<float> dis1(-1.0, 1.0);

  for (std::size_t i = 0; i < 3; ++i) {
    for (std::size_t j = 0; j < 3; ++j) {
      mask[i * 3 + j] = dis1(gen);
    }
  }

  float *output = new float[n*n];

  const auto start = std::chrono::high_resolution_clock::now();
  convolve(image, output, n, mask, 3);
  const auto end = std::chrono::high_resolution_clock::now();
  const std::chrono::duration<double, std::milli> elapsed = end - start;

  std::cout << output[0] << std::endl;
  std::cout << output[n * n - 1] << std::endl;
  std::cout << elapsed.count() << std::endl;

  delete[] image;
  delete[] mask;
  delete[] output;
  return 0;
}