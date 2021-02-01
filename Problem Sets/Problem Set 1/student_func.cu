#include "utils.h"
#include <stdio.h>

__global__
void rgba_to_greyscale(const uchar4* const rgbaImage,
                       unsigned char* const greyImage,
                       int numRows, int numCols)
{
  //TODO
  //Fill in the kernel to convert from color to greyscale
  //the mapping from components of a uchar4 to RGBA is:
  // .x -> R ; .y -> G ; .z -> B ; .w -> A
  //
  //The output (greyImage) at each pixel should be the result of
  //applying the formula: output = .299f * R + .587f * G + .114f * B;
  //Note: We will be ignoring the alpha channel for this conversion

  //First create a mapping from the 2D block and grid locations
  //to an absolute 2D location in the image, they use that to
  //calculate a 1D offset
  int y = threadIdx.y+ blockIdx.y* blockDim.y;
  int x = threadIdx.x+ blockIdx.x* blockDim.x;
  if (y >= numCols || x >= numRows) {
    return;
  }
  int index = numCols*x + y;
  uchar4 color_pixel = rgbaImage[index];
  unsigned char grey_pixel = (unsigned char)(0.299f*color_pixel.x+ 0.587f*color_pixel.y + 0.114f*color_pixel.z);
  greyImage[index] = grey_pixel;
}

void your_rgba_to_greyscale(const uchar4 * const h_rgbaImage, uchar4 * const d_rgbaImage,
                            unsigned char* const d_greyImage, size_t numRows, size_t numCols)
{
  int   blockWidth = 32;
  const dim3 blockSize(blockWidth, blockWidth, 1);
  int   blockX = numRows/blockWidth + 1;
  int   blockY = numCols/blockWidth + 1;
  const dim3 gridSize( blockX, blockY, 1);
  rgba_to_greyscale<<<gridSize, blockSize>>>(d_rgbaImage, d_greyImage, numRows, numCols);
  
  cudaDeviceSynchronize(); checkCudaErrors(cudaGetLastError());
}
