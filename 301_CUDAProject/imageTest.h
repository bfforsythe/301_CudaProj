// Brandon Forsythe
// 11/18/22
// imageTest.h       (will have a better name next time)
// Header file in order to store all functions used in kernel.cu.

#pragma once 

#ifndef _imageTest
#define _imageTest

void Image_Inversion_CUDA(unsigned char* Input_image, int Height, int Width, int Channels);
void GreenShift_CUDA(unsigned char* Input_image, int Height, int Width, int Channels);


#endif