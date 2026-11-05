// IntelliSense-only placeholder so the editor can resolve <cuda.h> without a CUDA Toolkit.
// Never used for real builds (nvcc uses the Toolkit's own header).
#pragma once
#include <stddef.h>

typedef int cudaError_t;
enum cudaMemcpyKind {
  cudaMemcpyHostToHost,
  cudaMemcpyHostToDevice,
  cudaMemcpyDeviceToHost,
  cudaMemcpyDeviceToDevice,
  cudaMemcpyDefault
};

cudaError_t cudaMalloc(void **devPtr, size_t size);
#ifdef __cplusplus
template <class T>
cudaError_t cudaMalloc(T **devPtr, size_t size);
#endif
cudaError_t cudaFree(void *devPtr);
cudaError_t cudaMemcpy(void *dst, const void *src, size_t count, cudaMemcpyKind kind);
cudaError_t cudaDeviceSynchronize(void);

// Lets IntelliSense parse kernel launches (<<<grid, block>>>).
struct __cudaStubDim3 {
  __cudaStubDim3(unsigned x = 1, unsigned y = 1, unsigned z = 1);
};
extern "C" unsigned __cudaPushCallConfiguration(__cudaStubDim3 gridDim, __cudaStubDim3 blockDim,
                                                size_t sharedMem = 0, void *stream = 0);
