#include <iostream>
#include <stdio.h>
#include <opencv2/opencv.hpp>
#include <opencv2/core/core.hpp>
#include "imageTest.h"
#include <chrono>

using namespace cv;

int main() {

	auto start = std::chrono::high_resolution_clock::now();

	Mat Input_image = imread("gregantuan.png");

	std::cout << "Height : " << Input_image.rows << ", Width:" << Input_image.cols << ", Channels: " << Input_image.channels() << std::endl;

	//Image_Inversion_CUDA(Input_image.data, Input_image.rows, Input_image.cols, Input_image.channels());
	GreenShift_CUDA(Input_image.data, Input_image.rows, Input_image.cols);

	imwrite("greengory.png", Input_image);


	auto stop = std::chrono::high_resolution_clock::now();
	auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start);

	std::cout << "Time taken by function: "
		<< duration.count() << " milliseconds" << std::endl;

	return 0;
}