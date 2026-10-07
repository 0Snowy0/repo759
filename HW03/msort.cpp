#include "msort.h"

#include <algorithm>

// This function does a merge sort on the input array "arr" of length n. 
// You can add more functions as needed to complete the merge sort,
// but do not change this file. Declare and define your addtional
// functions in the msort.cpp file, but the calls to your addtional functions
// should be wrapped in the "msort" function.

// "threshold" is the lower limit of array size where your function would 
// start making parallel recursive calls. If the size of array goes below
// the threshold, a serial sort algorithm will be used to avoid overhead
// of task scheduling
void recurse(int* arr, std::size_t i, std::size_t j, std::size_t threshold) {
  // check if parallel needed
  if (j - i <= threshold) {
    std::sort(arr + i, arr + j);
    return;
  }

  const std::size_t mid = i + (j - i)/2;

  #pragma omp task
  recurse(arr, i, mid, threshold);
  #pragma omp task
  recurse(arr, mid, j, threshold);

  #pragma omp taskwait
  std::inplace_merge(arr + i, arr + mid, arr + j);
}

void msort(int* arr, const std::size_t n, const std::size_t threshold) {
  #pragma omp parallel
  {
    #pragma omp single
    recurse(arr, 0, n, threshold);
  }
}