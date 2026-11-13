#include <cuda_runtime.h>
#include <cstdio>

__global__ void task1Kernel() {
    int a = threadIdx.x + 1;
    int b = 1;

    for (int i = 2; i <= a; ++i) {
        b *= i;
    }

    std::printf("%d!=%d\n", a, b);
}

int main() {
    task1Kernel<<<1, 8>>>();
    cudaDeviceSynchronize();
    return 0;
}
