#include "matmul.h"

// Each function produces a row-major representation of the matrix C = A B.
// Details on the expected representation and order of operations within the
// function are given in the task1 description. The matrices A, B, and C are n
// by n and represented as 1D arrays or vectors.
void mmul1(const double* A, const double* B, double* C, const unsigned int n) {
  for (std::ptrdiff_t i = 0; i < n; i++) {
    for (std::ptrdiff_t j = 0; j < n; j++) {
      for (std::ptrdiff_t k = 0; k < n; k++) {
        C[i * n + j] += A[i * n + k] * B[k * n + j];
      } 
    }
  }
}

void mmul2(const double* A, const double* B, double* C, const unsigned int n) {
  for (std::ptrdiff_t i = 0; i < n; i++) {
    for (std::ptrdiff_t k = 0; k < n; k++) {
      for (std::ptrdiff_t j = 0; j < n; j++) {
        C[i * n + j] += A[i * n + k] * B[k * n + j];
      } 
    }
  }
}

void mmul3(const double* A, const double* B, double* C, const unsigned int n) {
  for (std::ptrdiff_t j = 0; j < n; j++) {
    for (std::ptrdiff_t k = 0; k < n; k++) {
      for (std::ptrdiff_t i = 0; i < n; i++) {
        C[i * n + j] += A[i * n + k] * B[k * n + j];
      } 
    }
  }
}

void mmul4(const std::vector<double>& A, const std::vector<double>& B, double* C, const unsigned int n){
  for (std::ptrdiff_t i = 0; i < n; i++) {
    for (std::ptrdiff_t j = 0; j < n; j++) {
      for (std::ptrdiff_t k = 0; k < n; k++) {
        C[i * n + j] += A[i * n + k] * B[k * n + j];
      } 
    }
  }
}