#include <random>
#include <cuda_runtime.h>
#include <iostream>

__global__ void task2Kernel(int *dA, int a) {
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    dA[i] = a * threadIdx.x + blockIdx.x;
}

int main() {
    const int n = 16;
    int hA[n];
    int *dA;

    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<int> dist(1, 100);
    int a = dist(gen);

    cudaMalloc(&dA, n * sizeof(int));

    task2Kernel<<<2, 8>>>(dA, a);
    cudaDeviceSynchronize();

    cudaMemcpy(hA, dA, n * sizeof(int), cudaMemcpyDeviceToHost);

    for (int i = 0; i < n; i++) {
        if (i > 0) {
            std::cout << " ";
        }
        std::cout << hA[i];
    }

    std::cout << std::endl;

    cudaFree(dA);
    return 0;
}
