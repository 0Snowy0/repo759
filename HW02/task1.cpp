#include <random>
#include <iostream>
#include <chrono>
#include <cstdlib>
#include "scan.h"

int main(int argc, char *argv[]) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <number>" << std::endl;
        return 1;
    }

    std::size_t n = std::strtoull(argv[1], nullptr, 10);
    float *arr = new float[n];
    // fill array with random float from -1.0 to 1.0
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<float> dis(-1.0, 1.0);

    for (std::size_t i = 0; i < n; ++i) {
        arr[i] = dis(gen);
    }

    float *output = new float[n];

    const auto start = std::chrono::high_resolution_clock::now();
    scan(arr, output, n);
    const auto end = std::chrono::high_resolution_clock::now();
    const std::chrono::duration<double, std::milli> elapsed = end - start;

    std::cout << elapsed.count() << std::endl;
    std::cout << output[0] << std::endl;
    std::cout << output[n - 1] << std::endl;

    delete[] arr;
    delete[] output;
    return 0;
}