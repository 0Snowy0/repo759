#include "matmul.cuh"

// Computes the matrix product of A and B, storing the result in C.
// Each thread should compute _one_ element of output.
// Does not use shared memory for this problem.
//
// A, B, and C are row major representations of nxn matrices in device memory.
//
// Assumptions:
// - 1D kernel configuration
__global__ void matmul_kernel(const float* A, const float* B, float* C, size_t n) {
  size_t idx = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
  if (idx >= n * n) {
    return;
  }

  size_t row = idx / n;
  size_t col = idx % n;

  float sum = 0.0f;
  for (size_t k = 0; k < n; k++) {
    sum += A[row * n + k] * B[k * n + col];
  }
  C[idx] = sum;
}

// Makes one call to matmul_kernel with threads_per_block threads per block.
// You can consider following the kernel call with cudaDeviceSynchronize (but if you use 
// cudaEventSynchronize to time it, that call serves the same purpose as cudaDeviceSynchronize).
void matmul(const float* A, const float* B, float* C, size_t n, unsigned int threads_per_block) {
  size_t total = n * n;
  unsigned int blocks = (total + threads_per_block - 1) / threads_per_block;
  matmul_kernel<<<blocks, threads_per_block>>>(A, B, C, n);
  cudaDeviceSynchronize();
}