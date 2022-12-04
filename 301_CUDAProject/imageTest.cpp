#include <iostream>
#include <stdio.h>
#include <opencv2/opencv.hpp>
#include <opencv2/core/core.hpp>
#include "imageTest.h"

using namespace cv;

int main() {

	Mat Input_image = imread("gregory.png");

	std::cout << "Height : " << Input_image.rows << ", Width:" << Input_image.cols << ", Channels: " << Input_image.channels() << std::endl;

	Image_Inversion_CUDA(Input_image.data, Input_image.rows, Input_image.cols, Input_image.channels());

	imwrite("Inverted_gregory.png", Input_image);

	system("pause");

	return 0;
}