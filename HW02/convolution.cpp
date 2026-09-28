#include "convolution.h"

inline float f(const float *image, std::ptrdiff_t n, std::ptrdiff_t i, std::ptrdiff_t j) {
    const bool row = (i >= 0 && i < n);
    const bool col = (j >= 0 && j < n);

    if (row && col) {
        return image[i * n + j];
    }
    return (row != col) ? 1.0f: 0.0f;
}
/**
 * Computes the result of applying a mask to an image as in the convolution process described in HW02.pdf.
 * image is an nxn grid stored in row-major order.
 * mask is an mxm grid stored in row-major order. 
 * Stores the result in output, which is an nxn grid stored in row-major order.
 *
 * @param image Pointer to the input image array.
 * @param output Pointer to the output array where the result will be stored.
 * @param n Size of the input image array.
 * @param mask Pointer to the convolution mask array.
 * @param m Size of the convolution mask array.
 */
void convolve(const float *image, float *output, std::size_t n, const float *mask, std::size_t m) {
    const std::ptrdiff_t N = static_cast<std::ptrdiff_t>(n);
    const std::ptrdiff_t M = static_cast<std::ptrdiff_t>(m);
    const std::ptrdiff_t halfM = (M - 1) / 2;

    for (std::ptrdiff_t x = 0; x < N; x++) {
        for (std::ptrdiff_t y = 0; y < N; y++) {
            float sum = 0.0f;
            for (std::ptrdiff_t i = 0; i < M; i++) {
                for (std::ptrdiff_t j = 0; j < M; j++) {
                    sum += mask[i*M+j] * f(image, N, x + i - halfM, y + j - halfM);
                }
            }
            output[x * N + y] = sum;
        }
    }
}