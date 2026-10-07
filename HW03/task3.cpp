#include <iostream>
#include <cstdlib>
#include <random>
#include <chrono>
#include "msort.h"

int main (int argc, char *argv[]) {
  if (argc < 4) {
    std::cerr << "Usage: " << argv[0] << " <number> <thread> <threshold>" << std::endl;
    return 1;
  }

  std::size_t n = std::strtoull(argv[1], nullptr, 10);
  const int t = std::atoi(argv[2]);
  std::size_t ts = std::strtoull(argv[4], nullptr, 10);

  if (n < 1 || t < 1 || t > 20 || ts < 1) {
    std::cerr << "Need <number> >=1, 1 <= <thread> <= 20, and <threshold> >=1" << std::endl;
  }

  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_real_distribution<float> dis(-1000, 1000);

  int *arr = new int[n];
  for (std::size_t i = 0; i < n; i++) arr[i] = dis(gen);

  omp_set_num_threads(t);
  const auto start = std::chrono::high_resolution_clock::now();
  msort(arr, n, ts);
  const auto end = std::chrono::high_resolution_clock::now();
  const std::chrono::duration<double, std::milli> elapsed = end - start;
  const double ms = elapsed.count();

  std::cout << arr[0] << std::endl;
  std::cout << arr[n - 1] << std::endl;
  std::cout << ms << std::endl;

  delete[] arr;
  return 0;
}