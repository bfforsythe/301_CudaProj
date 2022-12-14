// Brandon Forsythe
// 11/18/22
// imageTest.cpp        (will have a better name next time)
// Main code in order to create, input, and output all image manipulation done.

#include <iostream>
#include <stdio.h>
#include <opencv2/opencv.hpp>
#include <opencv2/core/core.hpp>
#include "imageTest.h"
#include <chrono> // for std::high_resolution_clock.

using namespace cv;

int main() {

	auto start = std::chrono::high_resolution_clock::now(); // Clock begins on execution

	Mat Input_image = imread("gregantuan.png"); // OpenCV reads in image given in native folder.

	std::cout << "Height : " << Input_image.rows << ", Width:" << Input_image.cols << ", Channels: " << Input_image.channels() << std::endl; // Documents how LARGE the image is

	Image_Inversion_CUDA(Input_image.data, Input_image.rows, Input_image.cols, Input_image.channels()); // Runs the inversion
	// GreenShift_CUDA(Input_image.data, Input_image.rows, Input_image.cols, Input_image.channels());	//  If running GreenShift, uncomment me too 

	imwrite("Inverted_gregantuan.png", Input_image); // Writes image out to whatever file necessary, if file does not exist, will be created.


	auto stop = std::chrono::high_resolution_clock::now(); // clock stops
	auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start); // find difference between start and end (casted to milliseconds as these operations are large)

	std::cout << "Time taken by function: "
		<< duration.count() << " milliseconds" << std::endl; // output time.

	return 0;
}