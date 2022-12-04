#include <iostream>
#include "opencv2/opencv.hpp"

using namespace cv;
int main() {

	Mat_<Vec3b> Input_image = imread("gregory.png");




	std::cout << "Height : " << Input_image.rows << ", Width:" << Input_image.cols << ", Channels: " << Input_image.channels() << std::endl;
	
		for (int j = 0; j < Input_image.rows; j++) {
			for (int k = 0; k < Input_image.cols; k++) {
				Vec3b& color = Input_image.at<Vec3b>(j, k);

				int r = Input_image.at<Vec3b>(j, k)[0];
				int g = Input_image.at<Vec3b>(j, k)[1];
				int b = Input_image.at<Vec3b>(j, k)[2];

				color[0] = 255 - r;
				color[1] = 255 - g;
				color[2] = 255 - b;


			}
		}
	

	imwrite("Inverted_gregory.png", Input_image);

	return 0;
}
