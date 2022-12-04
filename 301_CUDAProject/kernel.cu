﻿#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "imageTest.h"

__global__ void Inversion_CUDA(unsigned char* Image, int Channels);
void Image_Inversion_CUDA(unsigned char* Input_image, int Height, int Width, int Channels) {

	unsigned char* Dev_Input_Image = NULL;

	// memAlloc

	cudaMalloc((void**)&Dev_Input_Image, Height * Width * Channels);

	cudaMemcpy(Dev_Input_Image, Input_image, Height * Width * Channels, cudaMemcpyHostToDevice);

	dim3 Grid_Image;
	Grid_Image.x = Width;
	Grid_Image.y = Height;


	Inversion_CUDA << <Grid_Image, 255 >> > (Dev_Input_Image, Channels);


	cudaMemcpy(Input_image, Dev_Input_Image, Height * Width * Channels, cudaMemcpyDeviceToHost);

	cudaFree(Dev_Input_Image);
}


__global__ void Inversion_CUDA(unsigned char* Image, int Channels) {

	int x = blockIdx.x;
	int y = blockIdx.y;
	int idx = (x + y * gridDim.x) * Channels;


	for (int i = 0; i < Channels; i++) {
		Image[idx + i] = 255 - Image[idx + i];
	}
}
