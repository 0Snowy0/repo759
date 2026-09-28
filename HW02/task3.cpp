#include "matmul.h"

#include <chrono>
#include <iostream>
#include <random>
#include <vector>

int main() {
  const unsigned int n = 1024;

  std::cout << n << std::endl;

  double* Ap = new double[n * n];
  double* Bp = new double[n * n];

  std::vector<double> A(n * n);
  std::vector<double> B(n * n);

  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_real_distribution<float> dis(0.0, 10.0);

  for (unsigned int i = 0; i < n * n; i++) {
    Ap[i] = dis(gen);
    Bp[i] = Ap[i];

    A[i] = Ap[i];
    B[i] = Bp[i];
  }

  double* C = new double[n * n];
  for (unsigned int i = 0; i < n * n; i++) {
    C[i] = 0.0;
  }

  // mmul1
  auto start = std::chrono::high_resolution_clock::now();
  mmul1(Ap, Bp, C, n);
  auto end = std::chrono::high_resolution_clock::now();
  std::chrono::duration<double, std::milli> time1 = end - start;

  std::cout << time1.count() << std::endl;
  std::cout << C[n * n - 1] << std::endl;

  for (unsigned int i = 0; i < n * n; i++) {
    C[i] = 0.0;
  }

  // mmul2
  start = std::chrono::high_resolution_clock::now();
  mmul2(Ap, Bp, C, n);
  end = std::chrono::high_resolution_clock::now();
  std::chrono::duration<double, std::milli> time2 = end - start;

  std::cout << time2.count() << std::endl;
  std::cout << C[n * n - 1] << std::endl;

  for (unsigned int i = 0; i < n * n; i++) {
    C[i] = 0.0;
  }

  // mmul3
  start = std::chrono::high_resolution_clock::now();
  mmul3(Ap, Bp, C, n);
  end = std::chrono::high_resolution_clock::now();
  std::chrono::duration<double, std::milli> time3 = end - start;

  std::cout << time3.count() << std::endl;
  std::cout << C[n * n - 1] << std::endl;

  for (unsigned int i = 0; i < n * n; i++) {
    C[i] = 0.0;
  }

  // mmul4
  start = std::chrono::high_resolution_clock::now();
  mmul4(A, B, C, n);
  end = std::chrono::high_resolution_clock::now();
  std::chrono::duration<double, std::milli> time4 = end - start;

  std::cout << time4.count() << std::endl;
  std::cout << C[n * n - 1] << std::endl;

  delete[] C;
  delete[] Ap;
  delete[] Bp;

  return 0;
}