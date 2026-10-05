#include "matmul.h"

void mmul2(const double* A, const double* B, double* C, const unsigned int n) {
  for (std::ptrdiff_t i = 0; i < n; i++) {
    for (std::ptrdiff_t k = 0; k < n; k++) {
      for (std::ptrdiff_t j = 0; j < n; j++) {
        C[i * n + j] += A[i * n + k] * B[k * n + j];
      } 
    }
  }
}