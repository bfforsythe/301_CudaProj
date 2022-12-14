#include <iostream>
#include "opencv2/opencv.hpp"
#include <chrono>

using namespace cv;

int main() {

	auto start = std::chrono::high_resolution_clock::now();


	Mat Input_image = imread("gregantuan.png");




	std::cout << "Height : " << Input_image.rows << ", Width:" << Input_image.cols << ", Channels: " << Input_image.channels() << std::endl;
	
		for (int j = 0; j < Input_image.rows; j++) {
			for (int k = 0; k < Input_image.cols; k++) {
				Vec3b& color = Input_image.at<Vec3b>(j, k);

				int r = Input_image.at<Vec3b>(j, k)[0];
				int g = Input_image.at<Vec3b>(j, k)[1];
				int b = Input_image.at<Vec3b>(j, k)[2];

				color[1] = 255 + g;
				color[0] = r;
				color[2] = b;


			}
		}

	

	imwrite("inverted_gregantuan.png", Input_image);


	auto stop = std::chrono::high_resolution_clock::now();
	auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start);

	std::cout << "Time taken by function: "
		<< duration.count() << " milliseconds" << std::endl;

	return 0;

}
