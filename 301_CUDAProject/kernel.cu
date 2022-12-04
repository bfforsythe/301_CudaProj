﻿#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "imageTest.h"
#include "opencv2/opencv.hpp"


void Image_Inversion_CUDA(unsigned char* Input_Image, int Height, int Width, int Channels) {
    unsigned char* Dev_Input_Image = NULL;

    cudaMalloc((void**)&Dev_Input_Image, Height * Width * Channels);

    
    cudaMemcpy(Dev_Input_Image, Input_Image, Height * Width * Channels, cudaMemcpyHostToDevice);

    dim3 Grid_Image(Width, Height);
    Inversion_CUDA << <Grid_Image, 1 >> > (Dev_Input_Image, Channels); 
    cudaMemcpy(Input_Image, Dev_Input_Image, Height * Width * Channels, cudaMemcpyDeviceToHost);
    cudaFree(Dev_Input_Image);
    cudaFree(Input_Image);
}

/*__global__ void Inversion_CUDA(unsigned char* Image, int Channels) {
    int x = blockIdx.x;
    int y = blockIdx.y;
    int idx = (x + y * gridDim.x) * Channels;



    for (int i = 0; i < Channels; i++) {
        Image[idx + i] = 255 - Image[idx + i];
    }
} */


__global__ void GreenShift_CUDA(unsigned char* Image) {
    int x = blockIdx.x;
    int y = blockIdx.y;

    int idx = (x + y * gridDim.x);
   

    for (int i = 0; i < idx; i++) {
        Image[idx + 1] = 255 + Image[idx + 1];
    }
}