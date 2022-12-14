// Brandon Forsythe
// 11/18/22
// kernel.cu        (will have a better name next time)
// CUDA code in order to compliment and allow compilation of imageTest.cpp

#include "cuda_runtime.h" // for all cuda needs
#include "device_launch_parameters.h" // for copying between GPU and CPU
#include "imageTest.h" // see imageTest header. includes Image_Inversion as well as GreenShift
#include "opencv2/opencv.hpp" // for all OpenCV needs

using namespace cv; // Contrary to popular belief, this does NOT slow down the code.



// NOTE TO SELF: IT'S BGR, NOT RGB ⚠️



// ---------------------- CUDA/CV Inversion ----------------------

__global__ void Inversion_CUDA(unsigned char* Image, int Channels) { // void function to init and process image
    int x = blockIdx.x;
    int y = blockIdx.y;
    int idx = (x + y * gridDim.x) * Channels;



    for (int i = 0; i < Channels; i++) {          // Image handling workhorse, what's written here will impact each pixel of the image input 
        Image[idx + i] = 255 - Image[idx + i];    // Note: OpenCV uses the BGR formula, and each channel is separated, idx + 0 is Blue
                                                                                                                    // idx + 1 is Green
                                                                                                                    // idx + 2 is Red
    }
}

void Image_Inversion_CUDA(unsigned char* Input_Image, int Height, int Width, int Channels) { // Cuda setup in order for the thing to.... actually work.
    unsigned char* Dev_Input_Image = NULL; // Dev Image by default is null, so it can be changed later.

    cudaMalloc((void**)&Dev_Input_Image, Height * Width * Channels);             // Allocates as much memory as is necessary for the GPU

    
    cudaMemcpy(Dev_Input_Image, Input_Image, Height * Width * Channels, cudaMemcpyHostToDevice); // Copies all memory into Device (GPU)

    dim3 Grid_Image(Width, Height);                                              // Initializes image input into grid with every pixel corresponding to one square on the grid.
    Inversion_CUDA << <Grid_Image, 1 >> > (Dev_Input_Image, Channels);           // Creates workers on GPU in order to carry out above
    cudaMemcpy(Input_Image, Dev_Input_Image, Height * Width * Channels, cudaMemcpyDeviceToHost); // Copies all memory back to Host (CPU / Computer?)

    cudaFree(Dev_Input_Image);          // Frees all memory used.
    cudaFree(Input_Image);
} 
// ------------------------------------------------------------------


//          Below is the Secondary test being worked on. To get compilation, please comment everything above this line, and uncomment below.
//          GreenShift also follows the basic steps as documented above, with more computation as it parses every orange pixel individually.
/*

__global__ void GreenShift(unsigned char* Image, int Channels) {
    int x = blockIdx.x;
    int y = blockIdx.y;
    int idx = (x + y * gridDim.x) * Channels;

    //for (int i = 0; i < Channels; i++) {
      //  Image[idx+2] = 255;

    for (int i = 0; i < Channels; i++) {
        if (Image[idx + 1] <= 190 && Image[idx+1] >= 100 && Image[idx+2] <= 255 && Image[idx+2] >= 210) {
            Image[idx + 1] = 1 + (Image[idx+1]) / 2;
            Image[idx] = 0;
            Image[idx + 2] = 0;
        }
    }


        // orange is (0,165,255)
    }




void GreenShift_CUDA(unsigned char* Input_Image, int Height, int Width, int Channels) {
    unsigned char* Dev_Input_Image = NULL;

    cudaMalloc((void**)&Dev_Input_Image, Height * Width * Channels);


    cudaMemcpy(Dev_Input_Image, Input_Image, Height * Width * Channels, cudaMemcpyHostToDevice);

    dim3 Grid_Image(Width, Height);
    GreenShift << <Grid_Image, 1 >> > (Dev_Input_Image, Channels);
    cudaMemcpy(Input_Image, Dev_Input_Image, Height * Width * Channels, cudaMemcpyDeviceToHost);
    cudaFree(Dev_Input_Image);
    cudaFree(Input_Image);
}
*/

 