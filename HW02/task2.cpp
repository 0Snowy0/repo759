#include <random>
#include <iostream>
#include <chrono>
#include <cstdlib>
#include "convolution.h"

int main (int argc, char *argv[]) {
  std::size_t n = std::strtoull(argv[1], nullptr, 10);
  std::size_t m = std::strtoull(argv[2], nullptr, 10);

  // nxn matrix image of random float from -10.0 to 10.0
  float *image = new float[n * n];

  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_real_distribution<float> dis(-10.0, 10.0);

  for (std::size_t i = 0; i < n; ++i) {
    for (std::size_t j = 0; j < n; ++j) {
      image[i * n + j] = dis(gen);
    }
  }

  // mxm matrix mask of random float from -1.0 to 1.0
  float *mask = new float[m * m];
  std::uniform_real_distribution<float> dis1(-1.0, 1.0);

  for (std::size_t i = 0; i < m; ++i) {
    for (std::size_t j = 0; j < m; ++j) {
      mask[i * m + j] = dis1(gen);
    }
  }
  float *output = new float[n * n];

  const auto start = std::chrono::high_resolution_clock::now();
  convolve(image, output, n, mask, m);
  const auto end = std::chrono::high_resolution_clock::now();
  const std::chrono::duration<double, std::milli> elapsed = end - start;

  std::cout << elapsed.count() << std::endl;
  std::cout << output[0] << std::endl;
  std::cout << output[n * n - 1] << std::endl;

  // deallocate
  delete[] image;
  delete[] mask;
  delete[] output;

  return 0;
}
