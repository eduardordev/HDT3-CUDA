#include <stdio.h>
#include <cuda.h>

__global__ void hello(int totalThreads)
{
  int myID = (blockIdx.x * blockDim.x) + threadIdx.x;
  int globalID = myID + blockIdx.x * blockDim.x * gridDim.x;

  if (myID < totalThreads)
  {
    if (myID == totalThreads - 1)
    {
      printf("Hello world from the thread with the maximum global ID: %i (global ID: %i)\n", myID, globalID);
    }
  }
}

int main()
{
  int totalThreads = 100000;  // Número total de hilos
  int threadsPerBlock = 256; // Número de hilos por bloque (puedes ajustarlo según tu preferencia)

  int blocks = (totalThreads + threadsPerBlock - 1) / threadsPerBlock;  // Calcula el número de bloques necesario

  dim3 g(blocks, 1, 1);  // Dimensión de la grilla
  dim3 b(threadsPerBlock, 1, 1);   // Dimensión de los bloques

  hello <<<g, b>>>(totalThreads);
  cudaDeviceSynchronize();

  return 0;
}

